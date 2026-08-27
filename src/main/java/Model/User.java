package Model;

import java.io.Serializable;
import java.sql.Date;

/**
 * TẦNG 1 - MODEL
 * Tương ứng bảng [users] trong database
 */
@SuppressWarnings("serial")
public class User implements Serializable {

    private int    id;
    private String email;
    private String userName;    // tên đăng nhập
    private String fullName;
    private String passWord;
    private String avatar;
    private int    roleid;      // 1=admin, 2=manager, 5=user thường
    private String phone;
    private Date   createdDate;

    // Constructor rỗng
    public User() {}

    // Constructor đầy đủ - dùng khi đăng ký
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
    }

    // ── Getter / Setter ──────────────────────────────────────
    public int    getId()                      { return id; }
    public void   setId(int id)                { this.id = id; }

    public String getEmail()                   { return email; }
    public void   setEmail(String email)       { this.email = email; }

    public String getUserName()                { return userName; }
    public void   setUserName(String userName) { this.userName = userName; }

    public String getFullName()                { return fullName; }
    public void   setFullName(String fullName) { this.fullName = fullName; }

    public String getPassWord()                { return passWord; }
    public void   setPassWord(String passWord) { this.passWord = passWord; }

    public String getAvatar()                  { return avatar; }
    public void   setAvatar(String avatar)     { this.avatar = avatar; }

    public int    getRoleid()                  { return roleid; }
    public void   setRoleid(int roleid)        { this.roleid = roleid; }

    public String getPhone()                   { return phone; }
    public void   setPhone(String phone)       { this.phone = phone; }

    public Date   getCreatedDate()                     { return createdDate; }
    public void   setCreatedDate(Date createdDate)     { this.createdDate = createdDate; }
}
