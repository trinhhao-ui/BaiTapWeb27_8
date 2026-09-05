package Model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

/**
 * JPA Entity mapping bảng [products]
 * Quan hệ N-1: nhiều Product thuộc 1 Category
 */
@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private int id;

    @Column(name = "product_name", nullable = false, length = 255)
    private String name;

    @Column(name = "description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "price", nullable = false, precision = 18, scale = 2)
    private BigDecimal price = BigDecimal.ZERO;

    @Column(name = "quantity", nullable = false)
    private int quantity = 0;

    @Column(name = "image", length = 255)
    private String image;

    @Column(name = "status", nullable = false)
    private int status = 1;  // 1=hiển thị, 0=ẩn

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date", nullable = false, updatable = false)
    private Date createdDate = new Date();

    // ── Quan hệ ManyToOne với Category ───────────────────────
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "cate_id", nullable = false)
    private Category category;

    // ── Constructors ─────────────────────────────────────────
    public Product() {}

    public Product(String name, String description, BigDecimal price,
                   int quantity, String image, int status, Category category) {
        this.name        = name;
        this.description = description;
        this.price       = price;
        this.quantity    = quantity;
        this.image       = image;
        this.status      = status;
        this.category    = category;
        this.createdDate = new Date();
    }

    // ── Getters / Setters ─────────────────────────────────────
    public int        getId()                          { return id; }
    public void       setId(int id)                    { this.id = id; }

    public String     getName()                        { return name; }
    public void       setName(String name)             { this.name = name; }

    public String     getDescription()                 { return description; }
    public void       setDescription(String d)         { this.description = d; }

    public BigDecimal getPrice()                       { return price; }
    public void       setPrice(BigDecimal price)       { this.price = price; }

    public int        getQuantity()                    { return quantity; }
    public void       setQuantity(int quantity)        { this.quantity = quantity; }

    public String     getImage()                       { return image; }
    public void       setImage(String image)           { this.image = image; }

    public int        getStatus()                      { return status; }
    public void       setStatus(int status)            { this.status = status; }

    public Date       getCreatedDate()                 { return createdDate; }
    public void       setCreatedDate(Date d)           { this.createdDate = d; }

    public Category   getCategory()                    { return category; }
    public void       setCategory(Category category)   { this.category = category; }

    @Override
    public String toString() {
        return "Product{id=" + id + ", name='" + name + "', price=" + price + "}";
    }
}
