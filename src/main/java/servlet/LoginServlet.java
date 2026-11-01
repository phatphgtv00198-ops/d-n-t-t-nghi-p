package servlet;

import dao.AccountDAO;
import entity.Account;
import util.AuthUtil;
import util.ParamUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu truy cập trực tiếp /login bằng GET, đá về trang chủ để hiện popup nếu cần
        response.sendRedirect(request.getContextPath() + "/");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String username = ParamUtil.getString(request, "username").trim();
        String password = ParamUtil.getString(request, "password").trim();

        HttpSession session = request.getSession();

        if (username.isEmpty() || password.isEmpty()) {
            session.setAttribute("loginError", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            session.setAttribute("isOpenLoginModal", "true");
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        // Gọi hàm findByUsername từ AccountDAO
        Account account = accountDAO.findByUsername(username);

        if (account != null && account.getPassword().equals(password)) {
            // Lưu Session đăng nhập thành công
            AuthUtil.setUser(request, account);

            // Xóa sạch cờ lỗi cũ
            session.removeAttribute("loginError");
            session.removeAttribute("isOpenLoginModal");

            // Phân luồng chuyển hướng dựa trên Role (Customer về trang chủ, Admin/Staff về dashboard)
            if (account.getRole() == Account.Role.Customer) {
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
        } else {
            // Đăng nhập sai -> Lưu lỗi vào Session và bật cờ mở modal đăng nhập
            session.setAttribute("loginError", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            session.setAttribute("isOpenLoginModal", "true");
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}