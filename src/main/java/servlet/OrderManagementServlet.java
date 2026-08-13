package servlet;

import dao.OrderDAO;
import entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/staff/orders")
public class OrderManagementServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Order> orderList = orderDAO.findAll();

            if (orderList != null && !orderList.isEmpty()) {
                System.out.println(">>> [OrderManagementServlet] Lay thanh cong " + orderList.size() + " don hang.");
            } else {
                System.out.println(">>> [OrderManagementServlet] Danh sach don hang RONG (size = 0).");
            }

            // Đặt đúng key "orders" trùng với JSP ${orders}
            request.setAttribute("orders", orderList);
            request.getRequestDispatcher("/staff/orders.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println(">>> [OrderManagementServlet] LOI TAI DOGET:");
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống khi lấy danh sách đơn hàng.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}