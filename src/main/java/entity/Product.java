package entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Entity
@Table(name = "Products")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ProductID")
    private Integer productID;

    @Column(name = "ProductName", nullable = false, length = 150)
    private String productName;

    @Column(name = "Price", nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    @Column(name = "StockQuantity", nullable = false)
    private Integer stockQuantity = 0;

    @ManyToOne
    @JoinColumn(name = "CategoryID")
    private Category category;

    @Column(name = "Description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    // Đổi 'image' thành 'thumbnailUrl' (khớp với DB mới hoặc map cột cũ)
    @Column(name = "ThumbnailUrl", length = 500)
    private String thumbnailUrl;

    // Thêm cột Video
    @Column(name = "VideoUrl", length = 500)
    private String videoUrl;
}