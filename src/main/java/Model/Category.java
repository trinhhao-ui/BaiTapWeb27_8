package Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 * TẦNG 1 - MODEL (JPA Entity)
 *
 * @Entity  -> Hibernate quản lý class này như một bảng
 * @Table   -> map tới bảng "Category" trong SQL Server
 *
 * Mapping cột:
 *   cate_id   -> id   (PK, IDENTITY)
 *   cate_name -> name
 *   icons     -> icon
 */
@Entity
@Table(name = "Category")
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // IDENTITY = AUTO_INCREMENT SQL Server
    @Column(name = "cate_id")
    private int id;

    @Column(name = "cate_name", nullable = false, length = 255)
    private String name;

    @Column(name = "icons", length = 500)
    private String icon;

    // ─── Constructors ────────────────────────────────────────────────────────
    /** Constructor rỗng - bắt buộc với JPA */
    public Category() {}

    /** Constructor tiện lợi khi tạo mới (không cần id) */
    public Category(String name, String icon) {
        this.name = name;
        this.icon = icon;
    }

    // ─── Getters / Setters ───────────────────────────────────────────────────
    public int    getId()              { return id; }
    public void   setId(int id)        { this.id = id; }

    public String getName()            { return name; }
    public void   setName(String name) { this.name = name; }

    public String getIcon()            { return icon; }
    public void   setIcon(String icon) { this.icon = icon; }

    @Override
    public String toString() {
        return "Category{id=" + id + ", name='" + name + "', icon='" + icon + "'}";
    }
}
