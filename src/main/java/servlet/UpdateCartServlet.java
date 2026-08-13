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

@WebServlet("/cart-update")
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cartIdStr = request.getParameter("cartId");
        String quantityStr = request.getParameter("quantity");

        if (cartIdStr != null && quantityStr != null) {
            EntityManager em = EntityConnectivity.getEntityManager();
            EntityTransaction tx = em.getTransaction();
            try {
                int cartId = Integer.parseInt(cartIdStr);
                int quantity = Integer.parseInt(quantityStr);

                if (quantity > 0) {
                    tx.begin();
                    Cart cartItem = em.find(Cart.class, cartId);
                    if (cartItem != null) {
                        cartItem.setQuantity(quantity);
                        em.merge(cartItem); // Cập nhật số lượng mới vào CSDL
                    }
                    tx.commit();
                }
            } catch (Exception e) {
                if (tx != null && tx.isActive()) {
                    tx.rollback();
                }
                e.printStackTrace();
            } finally {
                em.close();
            }
        }
        response.setStatus(HttpServletResponse.SC_OK);
    }
}