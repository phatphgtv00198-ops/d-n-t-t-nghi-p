package servlet;

import dao.OrderDAO;
import entity.Order;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/manager/order-detail") // Bỏ "/staff/order-detail" ở đây đi
public class OrderDetailServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");

        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                Order order = orderDAO.findById(id);

                if (order != null) {
                    req.setAttribute("order", order);
                    req.getRequestDispatcher("/manager/order-detail.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                System.err.println(">>> [OrderDetailServlet] ID không hợp lệ: " + idStr);
            }
        }

        resp.sendRedirect(req.getContextPath() + "/manager/orders");
    }
}