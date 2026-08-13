package servlet;

import dao.AccountDAO;
import entity.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.ParamUtil;

import java.io.IOException;

@WebServlet("/manager/account-delete")
public class AccountDeleteServlet extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy ID tài khoản cần xóa từ tham số URL
        int id = ParamUtil.getInt(request, "id", 0);
        Account currentUser = (Account) request.getSession().getAttribute("user");

        // 2. Ràng buộc: Không cho tài khoản tự xóa chính mình (Chỉ gọi getAccountID())
        if (currentUser != null && currentUser.getAccountID() == id) {
            response.sendRedirect(request.getContextPath() + "/manager/accounts?error=self_delete");
            return;
        }

        // 3. Thực hiện xóa trong database
        if (id > 0) {
            accountDAO.delete(id);
        }

        // 4. Quay lại trang danh sách
        response.sendRedirect(request.getContextPath() + "/manager/accounts");
    }
}