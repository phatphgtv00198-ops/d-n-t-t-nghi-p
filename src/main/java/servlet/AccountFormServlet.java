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
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(urlPatterns = {"/manager/account-add", "/manager/account-edit"})
public class AccountFormServlet extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/manager/account-edit".equals(path)) {
            int id = ParamUtil.getInt(request, "id", 0);
            Account account = accountDAO.findById(id);

            if (account == null) {
                response.sendRedirect(request.getContextPath() + "/manager/accounts");
                return;
            }
            request.setAttribute("account", account);
            request.setAttribute("isEdit", true);
        } else {
            request.setAttribute("isEdit", false);
        }

        request.getRequestDispatcher("/manager/account-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String path = request.getServletPath();
        boolean isEdit = "/manager/account-edit".equals(path);

        String username = ParamUtil.getString(request, "username").trim();
        String password = ParamUtil.getString(request, "password").trim();
        String roleStr = ParamUtil.getString(request, "role").trim();

        if (username.isEmpty() || (!isEdit && password.isEmpty())) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc!");
            request.setAttribute("isEdit", isEdit);
            request.getRequestDispatcher("/manager/account-form.jsp").forward(request, response);
            return;
        }

        try {
            Account.Role role = Account.Role.valueOf(roleStr);

            if (isEdit) {
                int id = ParamUtil.getInt(request, "id", 0);
                Account account = accountDAO.findById(id);

                if (account != null) {
                    account.setUsername(username);
                    account.setRole(role);
                    if (!password.isEmpty()) {
                        account.setPassword(password);
                    }
                    accountDAO.update(account);
                }
            } else {
                if (accountDAO.findByUsername(username) != null) {
                    request.setAttribute("error", "Username này đã tồn tại trong hệ thống!");
                    request.setAttribute("isEdit", false);
                    request.getRequestDispatcher("/manager/account-form.jsp").forward(request, response);
                    return;
                }

                Account newAcc = new Account();
                newAcc.setUsername(username);
                newAcc.setPassword(password);
                newAcc.setRole(role);
                accountDAO.create(newAcc);
            }

            // Encode username để tránh lỗi kí tự đặc biệt trên URL
            String encodedUsername = URLEncoder.encode(username, StandardCharsets.UTF_8);
            String status = isEdit ? "updated" : "created";

            // Redirect về danh sách kèm theo bằng chứng trạng thái
            response.sendRedirect(request.getContextPath() + "/manager/accounts?status=" + status + "&user=" + encodedUsername);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý dữ liệu: " + e.getMessage());
            request.setAttribute("isEdit", isEdit);
            request.getRequestDispatcher("/manager/account-form.jsp").forward(request, response);
        }
    }
}