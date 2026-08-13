package servlet;

import dao.OrderDAO;
import entity.Order;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/staff/order-detail") // URL duy nhất cho Staff
public class StaffOrderDetailServlet extends HttpServlet {

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
                    req.getRequestDispatcher("/staff/order-detail.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                System.err.println(">>> [StaffOrderDetailServlet] ID không hợp lệ: " + idStr);
            }
        }

        resp.sendRedirect(req.getContextPath() + "/staff/orders");
    }
}