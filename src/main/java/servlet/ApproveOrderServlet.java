package servlet;

import dao.OrderDAO;
import entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/staff/approve-order")
public class ApproveOrderServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Lấy ID đơn hàng từ Parameter (?id=...)
            String idParam = request.getParameter("id");

            if (idParam != null && !idParam.trim().isEmpty()) {
                int orderId = Integer.parseInt(idParam.trim());

                // 2. Gọi updateStatus truyền trực tiếp Enum Order.OrderStatus.Paid
                orderDAO.updateStatus(orderId, Order.OrderStatus.Paid);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 3. Cập nhật xong chuyển hướng người dùng về lại trang Quản lý đơn hàng
        response.sendRedirect(request.getContextPath() + "/staff/orders");
    }
}