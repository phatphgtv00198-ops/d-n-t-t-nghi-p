package servlet;

import entity.Order;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.JPAUtil;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/manager/reports")
public class ReportServlet extends HttpServlet {

    public static class TopProductDTO {
        private String productName;
        private Long quantity;
        private BigDecimal totalPrice;

        public TopProductDTO(String productName, Long quantity, BigDecimal totalPrice) {
            this.productName = productName;
            this.quantity = quantity;
            this.totalPrice = totalPrice;
        }

        public String getProductName() { return productName; }
        public Long getQuantity() { return quantity; }
        public BigDecimal getTotalPrice() { return totalPrice; }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filterType = request.getParameter("filter");
        if (filterType == null || filterType.trim().isEmpty()) {
            filterType = "this_month";
        }

        EntityManager em = JPAUtil.getEntityManager();

        // Chuẩn bị danh sách trạng thái cần lọc
        List<Order.OrderStatus> validStatuses = Arrays.asList(Order.OrderStatus.Paid, Order.OrderStatus.Pending);

        try {
            // Chuẩn bị điều kiện Lọc theo thời gian
            String dateCondition = getDateFilterCondition(filterType, "o.orderDate");
            String odDateCondition = getDateFilterCondition(filterType, "od.order.orderDate");

            // 1. Doanh thu tổng cộng (theo bộ lọc)
            String hqlRevenue = "SELECT SUM(o.totalAmount) FROM Order o " +
                    "WHERE o.status IN :statuses " + dateCondition;
            TypedQuery<BigDecimal> qRevenue = em.createQuery(hqlRevenue, BigDecimal.class)
                    .setParameter("statuses", validStatuses);
            BigDecimal totalRev = qRevenue.getSingleResult();
            BigDecimal monthlyRevenue = (totalRev != null) ? totalRev : BigDecimal.ZERO;

            // 2. Tổng số đơn hàng (theo bộ lọc)
            String hqlOrders = "SELECT COUNT(o) FROM Order o " +
                    "WHERE o.status IN :statuses " + dateCondition;
            TypedQuery<Long> qOrders = em.createQuery(hqlOrders, Long.class)
                    .setParameter("statuses", validStatuses);
            Long completedOrders = qOrders.getSingleResult();
            if (completedOrders == null) completedOrders = 0L;

            // 3. Tổng số lượng sản phẩm đã bán (theo bộ lọc)
            String hqlProducts = "SELECT SUM(od.quantity) FROM OrderDetail od " +
                    "WHERE od.order.status IN :statuses " + odDateCondition;
            TypedQuery<Long> qProducts = em.createQuery(hqlProducts, Long.class)
                    .setParameter("statuses", validStatuses);
            Long soldProducts = qProducts.getSingleResult();
            if (soldProducts == null) soldProducts = 0L;

            // 4. Top 5 sản phẩm bán chạy (theo bộ lọc)
            String hqlTop = "SELECT od.product.productName, SUM(od.quantity), SUM(od.quantity * od.unitPrice) " +
                    "FROM OrderDetail od WHERE od.order.status IN :statuses " + odDateCondition + " " +
                    "GROUP BY od.product.productName ORDER BY SUM(od.quantity) DESC";
            TypedQuery<Object[]> qTop = em.createQuery(hqlTop, Object[].class)
                    .setParameter("statuses", validStatuses);
            qTop.setMaxResults(5);

            List<Object[]> rawTopList = qTop.getResultList();
            List<TopProductDTO> topProducts = new ArrayList<>();
            for (Object[] row : rawTopList) {
                String pName = (String) row[0];
                Long qty = (Long) row[1];
                BigDecimal price = (BigDecimal) row[2];
                topProducts.add(new TopProductDTO(pName, qty, price != null ? price : BigDecimal.ZERO));
            }

            // 5. Dữ liệu biểu đồ doanh thu 12 tháng (trong năm hiện tại)
            int currentYear = LocalDate.now().getYear();
            List<BigDecimal> chartDataList = new ArrayList<>();
            for (int m = 1; m <= 12; m++) {
                String hqlMonthly = "SELECT SUM(o.totalAmount) FROM Order o WHERE o.status IN :statuses AND YEAR(o.orderDate) = :yr AND MONTH(o.orderDate) = :mn";
                TypedQuery<BigDecimal> qM = em.createQuery(hqlMonthly, BigDecimal.class)
                        .setParameter("statuses", validStatuses)
                        .setParameter("yr", currentYear)
                        .setParameter("mn", m);
                BigDecimal mRev = qM.getSingleResult();
                chartDataList.add(mRev != null ? mRev : BigDecimal.ZERO);
            }

            // Đưa dữ liệu sang JSP
            request.setAttribute("selectedFilter", filterType);
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("completedOrders", completedOrders);
            request.setAttribute("soldProducts", soldProducts);
            request.setAttribute("topProducts", topProducts);

            // Chuyển danh sách thành định dạng JSON để truyền vào JavaScript Chart.js
            request.setAttribute("chartData", chartDataList.toString());
            request.setAttribute("chartLabels", "['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12']");

            request.getRequestDispatcher("/manager/reports.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống khi tải báo cáo doanh thu: " + e.getMessage());
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    private String getDateFilterCondition(String filterType, String dateField) {
        LocalDate now = LocalDate.now();
        if ("last_month".equals(filterType)) {
            LocalDate startLast = now.minusMonths(1).withDayOfMonth(1);
            LocalDate endLast = now.withDayOfMonth(1);
            return "AND " + dateField + " >= '" + startLast + "' AND " + dateField + " < '" + endLast + "' ";
        } else if ("this_year".equals(filterType)) {
            int year = now.getYear();
            return "AND YEAR(" + dateField + ") = " + year + " ";
        } else {
            // Mặc định: this_month
            int year = now.getYear();
            int month = now.getMonthValue();
            return "AND YEAR(" + dateField + ") = " + year + " AND MONTH(" + dateField + ") = " + month + " ";
        }
    }
}