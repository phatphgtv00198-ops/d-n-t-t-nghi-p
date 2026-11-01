package servlet;

import entity.Account;
import entity.Customer;
import service.EntityConnectivity;
import util.EmailUtil; // Gọi class gửi mail của bạn
import util.ParamUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/register")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu truy cập trực tiếp bằng GET, chuyển hướng về trang chủ
        response.sendRedirect(request.getContextPath() + "/");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Hỗ trợ tiếng Việt cho form đăng ký
        request.setCharacterEncoding("UTF-8");

        // 1. Lấy dữ liệu từ Form
        String username = ParamUtil.getString(request, "username").trim();
        String password = ParamUtil.getString(request, "password").trim();
        String confirmPassword = ParamUtil.getString(request, "confirmPassword").trim();

        // Lấy thêm các thông tin cá nhân
        String fullName = ParamUtil.getString(request, "fullName").trim();
        String email = ParamUtil.getString(request, "email").trim();
        String phone = ParamUtil.getString(request, "phone").trim();
        String address = ParamUtil.getString(request, "address").trim();

        HttpSession session = request.getSession();

        // 2. Kiểm tra tính hợp lệ dữ liệu cơ bản
        if (username.isEmpty() || password.isEmpty()) {
            session.setAttribute("registerError", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            session.setAttribute("isOpenRegisterModal", "true");
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        if (!password.equals(confirmPassword)) {
            session.setAttribute("registerError", "Mật khẩu xác nhận không trùng khớp!");
            session.setAttribute("isOpenRegisterModal", "true");
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        EntityManager em = EntityConnectivity.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            // 3. Kiểm tra xem Tên đăng nhập đã tồn tại chưa
            Long usernameCount = em.createQuery("SELECT COUNT(a) FROM Account a WHERE a.username = :username", Long.class)
                    .setParameter("username", username)
                    .getSingleResult();

            if (usernameCount > 0) {
                session.setAttribute("registerError", "Tên đăng nhập đã tồn tại!");
                session.setAttribute("isOpenRegisterModal", "true");
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            // 4. Kiểm tra xem Email đã được sử dụng ở tài khoản khác chưa
            if (!email.isEmpty()) {
                Long emailCount = em.createQuery("SELECT COUNT(c) FROM Customer c WHERE c.email = :email", Long.class)
                        .setParameter("email", email)
                        .getSingleResult();

                if (emailCount > 0) {
                    session.setAttribute("registerError", "Địa chỉ email này đã được sử dụng cho tài khoản khác!");
                    session.setAttribute("isOpenRegisterModal", "true");
                    response.sendRedirect(request.getContextPath() + "/");
                    return;
                }
            }

            // 5. Bắt đầu Transaction tạo Tài khoản & Thông tin Khách hàng
            tx.begin();

            // A. Tạo Account
            Account account = new Account();
            account.setUsername(username);
            account.setPassword(password);
            account.setRole(Account.Role.Customer); // Mặc định là Khách hàng

            em.persist(account); // Lưu Account trước để lấy ID

            // B. Tạo bản ghi Customer tương ứng
            Customer customer = new Customer();
            customer.setAccount(account);
            customer.setFullName(fullName.isEmpty() ? username : fullName);
            customer.setEmail(email.isEmpty() ? null : email);
            customer.setPhone(phone.isEmpty() ? null : phone);
            customer.setAddress(address.isEmpty() ? null : address);

            em.persist(customer);

            // C. Xác nhận lưu toàn bộ dữ liệu vào Database
            tx.commit();

            // 6. GỬI EMAIL THÔNG BÁO ĐĂNG KÝ THÀNH CÔNG (Chạy ngầm bằng Thread để không đơ web)
            if (email != null && !email.isEmpty()) {
                final String recipientEmail = email;
                final String recipientName = fullName.isEmpty() ? username : fullName;

                new Thread(() -> {
                    try {
                        EmailUtil.sendRegistrationEmail(recipientEmail, recipientName);
                    } catch (Exception ex) {
                        System.err.println("Lỗi gửi email đăng ký: " + ex.getMessage());
                        ex.printStackTrace();
                    }
                }).start();
            }

            // 7. Đăng ký thành công -> Lưu thông báo thành công và chuyển về trang chủ mở popup đăng nhập
            session.setAttribute("registerSuccess", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/");

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback(); // Hoàn tác nếu có lỗi
            }
            e.printStackTrace();
            session.setAttribute("registerError", "Đã xảy ra lỗi khi tạo tài khoản: " + e.getMessage());
            session.setAttribute("isOpenRegisterModal", "true");
            response.sendRedirect(request.getContextPath() + "/");
        } finally {
            em.close();
        }
    }
}