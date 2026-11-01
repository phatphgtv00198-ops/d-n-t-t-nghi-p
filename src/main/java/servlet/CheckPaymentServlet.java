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
import java.io.PrintWriter;

@WebServlet("/api/check-payment")
public class CheckPaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            out.print("{\"success\": false, \"message\": \"Thiếu mã đơn hàng!\"}");
            return;
        }

        EntityManager em = EntityConnectivity.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            Long orderId = Long.parseLong(orderIdStr);

            // Bắt đầu giao dịch với Database
            tx.begin();
            Order order = em.find(Order.class, orderId);

            if (order == null) {
                if (tx.isActive()) tx.rollback();
                em.close();
                out.print("{\"success\": false, \"message\": \"Không tìm thấy đơn hàng!\"}");
                return;
            }

            // TỰ ĐỘNG CẬP NHẬT TRẠNG THÁI VÀO DATABASE KHI KHÁCH BẤM NÚT
            order.setPaymentStatus("Paid");               // Cập nhật thành Đã thanh toán
            order.setStatus(Order.OrderStatus.Pending);   // Cập nhật trạng thái đơn hàng là Chờ duyệt

            em.merge(order); // Thực thi lệnh cập nhật vào cơ sở dữ liệu
            tx.commit();     // Lưu thay đổi chính thức vào DB
            em.close();

            // Phản hồi về giao diện với trạng thái thành công (true) để web tự động chuyển trang
            out.print("{\"success\": true, \"message\": \"Thanh toán thành công! Đơn hàng đã chuyển sang trạng thái chờ duyệt.\"}");

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback(); // Hoàn tác nếu có lỗi xảy ra
            }
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Lỗi hệ thống khi cập nhật database!\"}");
        }
    }
}