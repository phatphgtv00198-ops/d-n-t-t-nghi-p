package servlet;

import entity.Account;
import entity.Customer;
import service.EntityConnectivity;
import util.ParamUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
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

        // Lấy thêm các thông tin cá nhân (nếu form có)
        String fullName = ParamUtil.getString(request, "fullName").trim();
        String email = ParamUtil.getString(request, "email").trim();
        String phone = ParamUtil.getString(request, "phone").trim();
        String address = ParamUtil.getString(request, "address").trim();

        // 2. Kiểm tra tính hợp lệ dữ liệu (Validation)
        if (username.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không trùng khớp!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        EntityManager em = EntityConnectivity.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            // 3. Kiểm tra xem Username đã tồn tại chưa
            Long count = em.createQuery("SELECT COUNT(a) FROM Account a WHERE a.username = :username", Long.class)
                    .setParameter("username", username)
                    .getSingleResult();

            if (count > 0) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            // 4. Bắt đầu Transaction tạo Tài khoản & Thông tin Khách hàng
            tx.begin();

            // A. Tạo Account
            Account account = new Account();
            account.setUsername(username);
            account.setPassword(password);
            account.setRole(Account.Role.Customer); // Mặc định là Khách hàng

            em.persist(account); // Lưu Account trước để lấy ID

            // B. Tạo bản ghi Customer tương ứng (Khóa ngoại kết nối 1-1 với Account)
            Customer customer = new Customer();
            customer.setAccount(account);
            // Nếu không nhập Họ tên thì lấy tạm tên đăng nhập làm Họ tên
            customer.setFullName(fullName.isEmpty() ? username : fullName);
            customer.setEmail(email.isEmpty() ? null : email);
            customer.setPhone(phone.isEmpty() ? null : phone);
            customer.setAddress(address.isEmpty() ? null : address);

            em.persist(customer);

            // C. Xác nhận lưu toàn bộ dữ liệu vào Database
            tx.commit();

            // 5. Đăng ký thành công -> Chuyển hướng sang trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/login?registered=true");

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback(); // Hoàn tác nếu có lỗi
            }
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi tạo tài khoản: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        } finally {
            em.close();
        }
    }
}