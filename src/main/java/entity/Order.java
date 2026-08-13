package entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Entity
@Table(name = "Orders")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderID")
    private Integer orderID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CustomerID")
    private Customer customer;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "StaffID")
    private Staff staff;

    @Column(name = "OrderDate", insertable = false, updatable = false)
    private LocalDateTime orderDate;

    @Column(name = "TotalAmount", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalAmount;

    @Enumerated(EnumType.STRING)
    @Column(name = "Status", nullable = false)
    private OrderStatus status = OrderStatus.Pending;

    @Column(name = "ShippingAddress")
    private String shippingAddress;

    // --- BỔ SUNG: Thêm trường phương thức và trạng thái thanh toán ---
    @Column(name = "PaymentMethod")
    private String paymentMethod;

    @Column(name = "PaymentStatus")
    private String paymentStatus;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderDetail> orderDetails;

    public enum OrderStatus {
        Pending, Paid, Approved, Cancelled
    }

    @PrePersist
    protected void onCreate() {
        if (this.orderDate == null) {
            this.orderDate = LocalDateTime.now();
        }
        if (this.paymentMethod == null) {
            this.paymentMethod = "COD";
        }
        if (this.paymentStatus == null) {
            this.paymentStatus = "Pending";
        }
    }

    public String getFormattedOrderDate() {
        if (this.orderDate == null) return "N/A";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return this.orderDate.format(formatter);
    }

    // Tự ghi đè equals và hashCode dựa trên ID để tránh Lombok gây StackOverflow / Loop với Hibernate
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Order order = (Order) o;
        return orderID != null && orderID.equals(order.orderID);
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }
}