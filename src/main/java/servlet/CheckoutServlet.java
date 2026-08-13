package servlet;

import entity.Account;
import entity.Cart;
import entity.Customer;
import entity.Order;
import entity.OrderDetail;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy địa chỉ người dùng nhập từ modal ở trang giỏ hàng
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "COD"; // Mặc định là COD nếu không nhận được giá trị
        }

        String[] selectedCartIdsStr = request.getParameterValues("selectedCartIds");

        if (address == null || address.trim().isEmpty() || selectedCartIdsStr == null || selectedCartIdsStr.length == 0) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        List<Integer> selectedCartIds = new ArrayList<>();
        for (String idStr : selectedCartIdsStr) {
            try {
                selectedCartIds.add(Integer.parseInt(idStr));
            } catch (NumberFormatException ignored) {}
        }

        EntityManager em = EntityConnectivity.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            // Bắt đầu Transaction để xử lý an toàn việc tạo Customer và Order
            tx.begin();

            // Tìm thông tin Customer tương ứng với Account
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
                em.flush(); // Đồng bộ ID ngay lập tức
            } else {
                customer = customers.get(0);
            }

            // Lấy danh sách sản phẩm được chọn trong giỏ hàng
            List<Cart> cartList = em.createQuery("SELECT c FROM Cart c WHERE c.customer.customerID = :custId AND c.cartID IN :cartIds", Cart.class)
                    .setParameter("custId", customer.getCustomerID())
                    .setParameter("cartIds", selectedCartIds)
                    .getResultList();

            if (cartList.isEmpty()) {
                tx.rollback();
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            // Tính tổng tiền các món được chọn
            BigDecimal totalAmount = BigDecimal.ZERO;
            for (Cart item : cartList) {
                BigDecimal itemTotal = item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity()));
                totalAmount = totalAmount.add(itemTotal);
            }

            // Tạo hóa đơn mới và lưu chính xác địa chỉ người dùng vừa nhập vào shippingAddress
            Order order = new Order();
            order.setCustomer(customer);
            order.setTotalAmount(totalAmount);
            order.setStatus(Order.OrderStatus.Pending);
            order.setShippingAddress(address.trim()); // Đảm bảo gán địa chỉ động từ form gửi lên
            order.setPaymentMethod(paymentMethod);
            order.setPaymentStatus("Pending");

            em.persist(order);

            // Lưu chi tiết đơn hàng & Xóa món đã mua khỏi giỏ
            for (Cart item : cartList) {
                OrderDetail detail = new OrderDetail();
                detail.setOrder(order);
                detail.setProduct(item.getProduct());
                detail.setQuantity(item.getQuantity());
                detail.setUnitPrice(item.getProduct().getPrice());

                em.persist(detail);
                em.remove(item); // Xóa khỏi giỏ hàng
            }

            // Hoàn tất giao dịch
            tx.commit();

            // Điều hướng theo phương thức thanh toán
            if ("BANK_TRANSFER".equals(paymentMethod)) {
                response.sendRedirect(request.getContextPath() + "/qr-payment.jsp?orderId=" + order.getOrderID());
            } else {
                response.sendRedirect(request.getContextPath() + "/checkout-success.jsp");
            }

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/cart");
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}