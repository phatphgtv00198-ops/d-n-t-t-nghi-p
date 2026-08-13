package servlet;

import entity.Account;
import entity.Cart;
import entity.Customer;
import entity.Product;
import service.EntityConnectivity;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/cart/add")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Bắt linh hoạt tham số ID sản phẩm
        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            productIdStr = request.getParameter("id");
        }

        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        int productId = Integer.parseInt(productIdStr);
        String quantityStr = request.getParameter("quantity");
        int quantity = (quantityStr != null && !quantityStr.trim().isEmpty()) ? Integer.parseInt(quantityStr) : 1;

        EntityManager em = EntityConnectivity.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            // Tìm hoặc Tạo Customer
            List<Customer> customers = em.createQuery("SELECT c FROM Customer c WHERE c.account.accountID = :accId", Customer.class)
                    .setParameter("accId", user.getAccountID())
                    .getResultList();

            Customer customer;
            if (customers.isEmpty()) {
                Account managedAccount = em.find(Account.class, user.getAccountID());
                customer = new Customer();
                customer.setAccount(managedAccount);
                customer.setFullName(user.getUsername());
                em.persist(customer);
                em.flush();
            } else {
                customer = customers.get(0);
            }

            Product product = em.find(Product.class, productId);

            if (customer != null && product != null) {
                List<Cart> existingCarts = em.createQuery("SELECT c FROM Cart c WHERE c.customer.customerID = :custId AND c.product.productID = :prodId", Cart.class)
                        .setParameter("custId", customer.getCustomerID())
                        .setParameter("prodId", productId)
                        .getResultList();

                if (!existingCarts.isEmpty()) {
                    Cart existingCart = existingCarts.get(0);
                    existingCart.setQuantity(existingCart.getQuantity() + quantity);
                    em.merge(existingCart);
                } else {
                    Cart newCart = new Cart();
                    newCart.setCustomer(customer);
                    newCart.setProduct(product);
                    newCart.setQuantity(quantity);
                    em.persist(newCart);
                }
            }

            tx.commit();
            // Thêm xong tự động chuyển sang trang giỏ hàng
            response.sendRedirect(request.getContextPath() + "/cart");

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/product-detail?id=" + productId);
        } finally {
            em.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}