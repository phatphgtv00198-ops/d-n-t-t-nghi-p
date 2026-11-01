package servlet;

import entity.Customer;
import service.EntityConnectivity;
import util.EmailUtil;
import util.ParamUtil;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Random;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = ParamUtil.getString(request, "email").trim();

        EntityManager em = EntityConnectivity.getEntityManager();
        try {
            // Kiểm tra xem email có tồn tại trong bảng Customers không
            List<Customer> customers = em.createQuery("SELECT c FROM Customer c WHERE c.email = :email", Customer.class)
                    .setParameter("email", email)
                    .getResultList();

            if (customers.isEmpty()) {
                request.setAttribute("error", "Email này không tồn tại trong hệ thống!");
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }

            // Tạo mã OTP ngẫu nhiên 6 chữ số
            String otp = String.format("%06d", new Random().nextInt(999999));

            // Lưu OTP và Email vào Session để bước sau xác thực
            HttpSession session = request.getSession();
            session.setAttribute("resetEmail", email);
            session.setAttribute("otpCode", otp);

            // Gửi email
            EmailUtil.sendOtp(email, otp);

            // Chuyển sang trang nhập mã OTP
            response.sendRedirect(request.getContextPath() + "/verify-code");

        } finally {
            em.close();
        }
    }
}