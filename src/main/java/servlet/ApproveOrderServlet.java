package servlet;

import entity.Order;
import service.EntityConnectivity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/staff/approve-order")
public class ApproveOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.trim().isEmpty()) {
                int orderId = Integer.parseInt(idParam.trim());

                EntityManager em = EntityConnectivity.getEntityManager();
                EntityTransaction tx = em.getTransaction();

                try {
                    tx.begin();
                    Order order = em.find(Order.class, orderId);
                    if (order != null) {
                        // 1. Chuyển trạng thái đơn hàng sang Paid/Approved để hiển thị là "Chờ giao hàng"
                        order.setStatus(Order.OrderStatus.Paid);

                        // 2. Nếu là đơn chuyển khoản ngân hàng, cập nhật luôn trạng thái thanh toán thành Paid
                        if ("BANK_TRANSFER".equals(order.getPaymentMethod())) {
                            order.setPaymentStatus("Paid");
                        }

                        em.merge(order);
                    }
                    tx.commit();
                } catch (Exception e) {
                    if (tx != null && tx.isActive()) {
                        tx.rollback();
                    }
                    e.printStackTrace();
                } finally {
                    if (em != null && em.isOpen()) {
                        em.close();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Chuyển hướng về lại trang quản lý đơn hàng của nhân viên/admin
        response.sendRedirect(request.getContextPath() + "/staff/orders");
    }
}