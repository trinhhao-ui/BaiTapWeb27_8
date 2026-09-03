package Model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 * JPA Entity mapping bảng [users]
 */
@Entity
@Table(name = "users")
@SuppressWarnings("serial")
public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "email", length = 100)
    private String email;

    @Column(name = "username", nullable = false, length = 50)
    private String userName;

    @Column(name = "fullname", length = 100)
    private String fullName;

    @Column(name = "password", nullable = false, length = 100)
    private String passWord;

    @Column(name = "avatar", length = 255)
    private String avatar;

    @Column(name = "roleid", nullable = false)
    private int roleid;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "createdDate")
    private Date createdDate;

    @Column(name = "status")
    private int status;         // 0=chưa kích hoạt, 1=đã kích hoạt

    @Column(name = "otp", length = 10)
    private String otp;

    @Column(name = "otp_expiry")
    private Timestamp otpExpiry;

    // ── Constructors ──────────────────────────────────────────
    public User() {}

    public User(String email, String userName, String fullName,
                String passWord, String avatar, int roleid,
                String phone, Date createdDate) {
        this.email       = email;
        this.userName    = userName;
        this.fullName    = fullName;
        this.passWord    = passWord;
        this.avatar      = avatar;
        this.roleid      = roleid;
        this.phone       = phone;
        this.createdDate = createdDate;
        this.status      = 0;
    }

    // ── Getters / Setters ─────────────────────────────────────
    public int       getId()                        { return id; }
    public void      setId(int id)                  { this.id = id; }

    public String    getEmail()                     { return email; }
    public void      setEmail(String email)         { this.email = email; }

    public String    getUserName()                  { return userName; }
    public void      setUserName(String userName)   { this.userName = userName; }

    public String    getFullName()                  { return fullName; }
    public void      setFullName(String fullName)   { this.fullName = fullName; }

    public String    getPassWord()                  { return passWord; }
    public void      setPassWord(String passWord)   { this.passWord = passWord; }

    public String    getAvatar()                    { return avatar; }
    public void      setAvatar(String avatar)       { this.avatar = avatar; }

    public int       getRoleid()                    { return roleid; }
    public void      setRoleid(int roleid)          { this.roleid = roleid; }

    public String    getPhone()                     { return phone; }
    public void      setPhone(String phone)         { this.phone = phone; }

    public Date      getCreatedDate()               { return createdDate; }
    public void      setCreatedDate(Date d)         { this.createdDate = d; }

    public int       getStatus()                    { return status; }
    public void      setStatus(int status)          { this.status = status; }

    public String    getOtp()                       { return otp; }
    public void      setOtp(String otp)             { this.otp = otp; }

    public Timestamp getOtpExpiry()                 { return otpExpiry; }
    public void      setOtpExpiry(Timestamp t)      { this.otpExpiry = t; }
}
