package servlet;

import entity.Order;
import service.EntityConnectivity;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/qr-payment")
public class QrPaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr != null) {
            try {
                Long orderId = Long.parseLong(orderIdStr);
                EntityManager em = EntityConnectivity.getEntityManager();
                Order order = em.find(Order.class, orderId);
                em.close();

                if (order != null) {
                    // Truyền ngược thông tin order sang trang jsp
                    request.setAttribute("order", order);
                }
            } catch (NumberFormatException ignored) {}
        }

        // Chuyển tiếp sang file qr-payment.jsp
        request.getRequestDispatcher("/qr-payment.jsp").forward(request, response);
    }
}