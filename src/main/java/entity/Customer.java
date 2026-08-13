package entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Customers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CustomerID")
    private Integer customerID;

    // Chuyển sang LAZY
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "AccountID", unique = true)
    private Account account;

    @Column(name = "FullName", nullable = false, length = 100)
    private String fullName;

    @Column(name = "Email", unique = true, length = 100)
    private String email;

    @Column(name = "Phone", length = 15)
    private String phone;

    @Column(name = "Address", columnDefinition = "NVARCHAR(MAX)")
    private String address;
}