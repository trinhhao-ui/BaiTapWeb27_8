package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Tiện ích kết nối SQL Server
 * Chỉ cần gọi DBConnection.getConnection() để lấy kết nối
 */
public class DBConnection {

    // ── Thay 3 thông tin này theo máy của bạn ──────────────────────────────
    private static final String SERVER   = "localhost";       // tên hoặc IP máy chủ SQL
    private static final String PORT     = "1433";            // port mặc định SQL Server
    private static final String DATABASE = "ltws3";    // ← đổi tên DB của bạn vào đây
    private static final String USERNAME = "sa";              // tên đăng nhập SQL Server
    private static final String PASSWORD = "0373703896Hao@";        // mật khẩu SQL Server
    // ───────────────────────────────────────────────────────────────────────

    // Chuỗi kết nối SQL Server
    // encrypt=false  -> không yêu cầu SSL (quan trọng với SQL Server local)
    // trustServerCertificate=true -> bỏ qua kiểm tra certificate
    private static final String URL =
            "jdbc:sqlserver://" + SERVER + ":" + PORT + ";"
          + "databaseName=" + DATABASE + ";"
          + "encrypt=false;"
          + "trustServerCertificate=true;";

    /**
     * Trả về một Connection đến SQL Server
     * Dùng trong try-with-resources để tự đóng sau khi xong
     *
     * Ví dụ sử dụng:
     *   try (Connection conn = DBConnection.getConnection()) {
     *       // dùng conn ở đây
     *   }
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Load driver thủ công - bắt buộc với Tomcat 10+
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Không tìm thấy SQL Server JDBC Driver", e);
        }
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}
