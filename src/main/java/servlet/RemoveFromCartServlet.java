package servlet;

import entity.Cart;
import service.EntityConnectivity;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cart-remove")
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cartIdParam = request.getParameter("id");

        if (cartIdParam != null && !cartIdParam.trim().isEmpty()) {
            EntityManager em = EntityConnectivity.getEntityManager();
            EntityTransaction tx = em.getTransaction();
            try {
                int cartId = Integer.parseInt(cartIdParam);
                tx.begin();
                Cart cartItem = em.find(Cart.class, cartId);
                if (cartItem != null) {
                    em.remove(cartItem);
                }
                tx.commit();
            } catch (Exception e) {
                if (tx != null && tx.isActive()) {
                    tx.rollback();
                }
                e.printStackTrace();
            } finally {
                em.close();
            }
        }

        // Xóa xong chuyển hướng lại về trang giỏ hàng
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}