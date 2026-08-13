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
import java.util.List;

@WebServlet("/order-history")
public class OrderHistoryServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Account account = (session != null) ? (Account) session.getAttribute("user") : null;

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            List<Order> orderList = orderDAO.findByAccount(account);

            request.setAttribute("orders", orderList);
            request.setAttribute("orderList", orderList);

            request.getRequestDispatcher("/order-history.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println(">>> [OrderHistoryServlet] Lỗi tải lịch sử đơn hàng:");
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi tải lịch sử đơn hàng!");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}