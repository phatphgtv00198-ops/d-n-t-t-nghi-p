package servlet;

import dao.AccountDAO;
import entity.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/manager/accounts")
public class AccountServlet extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy danh sách tài khoản từ database
        List<Account> accountList = accountDAO.findAll();

        // 2. Tính toán thống kê nhanh
        long totalAccounts = (accountList != null) ? accountList.size() : 0;

        long managerCount = (accountList != null) ? accountList.stream()
                                                    .filter(a -> a.getRole() != null &&
                                                                 ("Manager".equalsIgnoreCase(a.getRole().name()) || "Admin".equalsIgnoreCase(a.getRole().name())))
                                                    .count() : 0;

        long staffCount = (accountList != null) ? accountList.stream()
                                                  .filter(a -> a.getRole() != null &&
                                                          "Staff".equalsIgnoreCase(a.getRole().name()))
                                                  .count() : 0;

        // 3. Đẩy dữ liệu sang JSP
        request.setAttribute("accounts", accountList);
        request.setAttribute("totalAccounts", totalAccounts);
        request.setAttribute("managerCount", managerCount);
        request.setAttribute("staffCount", staffCount);

        // 4. Forward tới giao diện JSP
        request.getRequestDispatcher("/manager/accounts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}