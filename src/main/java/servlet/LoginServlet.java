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
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Nếu đã đăng nhập trước đó -> Tự động chuyển hướng đúng trang theo Role
        if (AuthUtil.isAuthenticated(request)) {
            Account currentUser = (Account) request.getSession().getAttribute("user");
            redirectByUserRole(request, response, currentUser);
            return;
        }

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = ParamUtil.getString(request, "username").trim();
        String password = ParamUtil.getString(request, "password").trim();

        if (username.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Gọi hàm findByUsername từ AccountDAO (đã xử lý close EntityManager an toàn)
        Account account = accountDAO.findByUsername(username);

        if (account != null && account.getPassword().equals(password)) {
            // Lưu Session
            AuthUtil.setUser(request, account);

            // Phân luồng chuyển hướng dựa trên Role
            redirectByUserRole(request, response, account);
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void redirectByUserRole(HttpServletRequest request, HttpServletResponse response, Account account)
            throws IOException {
        if (account != null && account.getRole() == Account.Role.Customer) {
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }
}