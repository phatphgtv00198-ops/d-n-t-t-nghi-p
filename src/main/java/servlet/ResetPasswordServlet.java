package servlet;

import entity.Account;
import entity.Customer;
import service.EntityConnectivity;
import util.ParamUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("canResetPassword") == null) {
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }
        request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = ParamUtil.getString(request, "newPassword").trim();
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");

        if (email == null || session.getAttribute("canResetPassword") == null) {
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }

        EntityManager em = EntityConnectivity.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            // Tìm Customer theo email để lấy Account tương ứng
            Customer customer = em.createQuery("SELECT c FROM Customer c WHERE c.email = :email", Customer.class)
                    .setParameter("email", email)
                    .getSingleResult();

            if (customer != null && customer.getAccount() != null) {
                Account account = customer.getAccount();
                account.setPassword(newPassword); // Cập nhật mật khẩu mới
                em.merge(account);
            }

            tx.commit();

            // Xóa session tạm
            session.removeAttribute("otpCode");
            session.removeAttribute("resetEmail");
            session.removeAttribute("canResetPassword");

            response.sendRedirect(request.getContextPath() + "/login?resetSuccess=true");

        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cập nhật mật khẩu!");
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
        } finally {
            em.close();
        }
    }
}