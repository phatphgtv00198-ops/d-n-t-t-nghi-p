package servlet;

import dao.OrderDAO;
import entity.Account;
import entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Account account = (session != null) ? (Account) session.getAttribute("user") : null;

        // 1. Kiểm tra đăng nhập
        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int orderId = Integer.parseInt(idStr);

                // 2. Lấy đơn hàng để xác minh chủ sở hữu và trạng thái
                Order order = orderDAO.findById(orderId);

                // Chỉ cho phép hủy nếu đơn hàng tồn tại, thuộc về chính khách hàng đó, và đang 'Pending'
                if (order != null
                        && order.getCustomer() != null
                        && order.getCustomer().getAccount() != null
                        && order.getCustomer().getAccount().getAccountID().equals(account.getAccountID())
                        && order.getStatus() == Order.OrderStatus.Pending) {

                    // 3. Cập nhật trạng thái thành Cancelled
                    orderDAO.updateStatus(orderId, Order.OrderStatus.Cancelled);
                } else {
                    System.err.println(">>> [CancelOrderServlet] Không thể hủy đơn hàng ID: " + orderId + " (Không hợp lệ hoặc không có quyền)");
                }

            } catch (NumberFormatException e) {
                System.err.println(">>> [CancelOrderServlet] ID đơn hàng không hợp lệ: " + idStr);
            }
        }

        // 4. Quay lại trang lịch sử đơn hàng
        response.sendRedirect(request.getContextPath() + "/order-history");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}