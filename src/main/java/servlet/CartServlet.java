package servlet;

import entity.Account;
import entity.Cart;
import entity.Customer;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");

        // 1. Bắt buộc đăng nhập, nếu chưa đăng nhập -> sang /login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        EntityManager em = EntityConnectivity.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            // An toàn: Tìm Customer bằng ResultList tránh lỗi NoResultException
            List<Customer> customers = em.createQuery("SELECT c FROM Customer c WHERE c.account.accountID = :accId", Customer.class)
                    .setParameter("accId", user.getAccountID())
                    .getResultList();

            Customer customer;
            if (customers.isEmpty()) {
                // Tự động tạo bản ghi Customer cho Account nếu chưa có
                tx.begin();
                Account managedAccount = em.find(Account.class, user.getAccountID());
                customer = new Customer();
                customer.setAccount(managedAccount);
                customer.setFullName(user.getUsername());
                em.persist(customer);
                tx.commit();
            } else {
                customer = customers.get(0);
            }

            // Lấy danh sách giỏ hàng
            List<Cart> cartList = em.createQuery("SELECT c FROM Cart c WHERE c.customer.customerID = :custId", Cart.class)
                    .setParameter("custId", customer.getCustomerID())
                    .getResultList();

            request.setAttribute("cartList", cartList);
            request.setAttribute("customer", customer);

            // Chuyển hướng sang giao diện cart.jsp
            request.getRequestDispatcher("/cart.jsp").forward(request, response);

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            // Nếu có lỗi hệ thống thực sự thì mới về home
            response.sendRedirect(request.getContextPath() + "/home");
        } finally {
            em.close();
        }
    }
}