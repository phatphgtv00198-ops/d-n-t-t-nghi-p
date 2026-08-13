package servlet;

import entity.Account;
import entity.Customer;
import entity.Order;
import entity.OrderDetail;
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
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/buy-now")
public class BuyNowServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        // BƯỚC 2: Người dùng xác nhận thanh toán
        if ("confirmOrder".equals(action)) {
            processOrder(request, response, user);
            return;
        }

        // BƯỚC 1: Bấm nút "Mua ngay" ở trang chi tiết sản phẩm
        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            productIdStr = request.getParameter("id");
        }

        String quantityStr = request.getParameter("quantity");

        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        EntityManager em = EntityConnectivity.getEntityManager();
        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = (quantityStr != null && !quantityStr.trim().isEmpty()) ? Integer.parseInt(quantityStr) : 1;

            Product product = em.find(Product.class, productId);
            if (product != null) {
                BigDecimal totalAmount = product.getPrice().multiply(new BigDecimal(quantity));

                request.setAttribute("product", product);
                request.setAttribute("quantity", quantity);
                request.setAttribute("totalAmount", totalAmount);

                request.getRequestDispatcher("/buy-now.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        } finally {
            em.close();
        }
    }

    private void processOrder(HttpServletRequest request, HttpServletResponse response, Account user)
            throws IOException {

        EntityManager em = EntityConnectivity.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        int productId = 0;

        try {
            productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Lấy địa chỉ giao hàng do người dùng nhập từ giao diện buy-now.jsp
            String shippingAddress = request.getParameter("address");

            tx.begin();

            List<Customer> customers = em.createQuery("SELECT c FROM Customer c WHERE c.account.accountID = :accId", Customer.class)
                    .setParameter("accId", user.getAccountID())
                    .getResultList();

            Customer customer;
            if (customers.isEmpty()) {
                Account managedAccount = em.find(Account.class, user.getAccountID());
                customer = new Customer();
                customer.setAccount(managedAccount);
                customer.setFullName(user.getUsername());
                customer.setAddress(shippingAddress); // Lưu kèm địa chỉ nếu mới tạo
                em.persist(customer);
                em.flush();
            } else {
                customer = customers.get(0);
                // Cập nhật lại địa chỉ mới nhất cho khách hàng
                if (shippingAddress != null && !shippingAddress.trim().isEmpty()) {
                    customer.setAddress(shippingAddress);
                    em.merge(customer);
                }
            }

            Product product = em.find(Product.class, productId);
            BigDecimal totalAmount = product.getPrice().multiply(new BigDecimal(quantity));

            // Tạo Đơn hàng và gán địa chỉ giao hàng
            Order order = new Order();
            order.setCustomer(customer);
            order.setTotalAmount(totalAmount);
            order.setStatus(Order.OrderStatus.Pending);

            // Gán địa chỉ giao hàng (Lưu ý: Nếu Entity Order của bạn dùng setAddress thì sửa lại thành order.setAddress)
            order.setShippingAddress(shippingAddress);

            em.persist(order);

            // Tạo Chi tiết đơn hàng
            OrderDetail detail = new OrderDetail();
            detail.setOrder(order);
            detail.setProduct(product);
            detail.setQuantity(quantity);
            detail.setUnitPrice(product.getPrice());
            em.persist(detail);

            // Cập nhật tồn kho
            if (product.getStockQuantity() >= quantity) {
                product.setStockQuantity(product.getStockQuantity() - quantity);
                em.merge(product);
            }

            tx.commit();
            response.sendRedirect(request.getContextPath() + "/checkout-success.jsp");

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
        response.sendRedirect(request.getContextPath() + "/home");
    }
}