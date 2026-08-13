package entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "ProductMedia")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductMedia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MediaID")
    private Integer mediaID;

    @ManyToOne
    @JoinColumn(name = "ProductID", nullable = false)
    private Product product;

    @Column(name = "MediaType", nullable = false, length = 10)
    private String mediaType; // 'IMAGE' hoặc 'VIDEO'

    @Column(name = "MediaUrl", nullable = false, length = 500)
    private String mediaUrl;

    @Column(name = "IsPrimary")
    private Boolean isPrimary = false;

    @Column(name = "Caption", length = 255)
    private String caption;

    @Column(name = "CreatedAt", insertable = false, updatable = false)
    private LocalDateTime createdAt;
}