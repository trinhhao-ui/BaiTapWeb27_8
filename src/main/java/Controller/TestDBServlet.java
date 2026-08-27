package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Utils.DBConnection;

@WebServlet("/testdb")
public class TestDBServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<style>body{font-family:Arial;padding:30px;font-size:14px}"
                  + "table{border-collapse:collapse;margin-top:12px;width:100%}"
                  + "td,th{border:1px solid #ccc;padding:8px 12px}"
                  + "th{background:#111;color:#fff}"
                  + ".ok{color:green;font-weight:bold}"
                  + ".err{color:red;font-weight:bold}"
                  + "pre{background:#f5f5f5;padding:12px;font-size:12px;overflow:auto}"
                  + "</style>");

        // ── BƯỚC 1: Test kết nối ────────────────────────────────
        out.println("<h3>BƯỚC 1 — Kết nối DB</h3>");
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            out.println("<p class='ok'>✅ Kết nối thành công — Database: <b>"
                      + conn.getCatalog() + "</b></p>");
        } catch (Exception e) {
            out.println("<p class='err'>❌ Kết nối THẤT BẠI</p>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            return;
        }

        // ── BƯỚC 2: Kiểm tra bảng users có tồn tại không ───────
        out.println("<h3>BƯỚC 2 — Kiểm tra bảng users</h3>");
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM users");
            rs.next();
            int total = rs.getInt("total");
            out.println("<p class='ok'>✅ Bảng users tồn tại — có <b>" + total + "</b> bản ghi</p>");
        } catch (Exception e) {
            out.println("<p class='err'>❌ Bảng users KHÔNG tồn tại hoặc lỗi: " + e.getMessage() + "</p>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            conn = null;
        }

        if (conn == null) return;

        // ── BƯỚC 3: Hiển thị dữ liệu bảng users ────────────────
        out.println("<h3>BƯỚC 3 — Dữ liệu bảng users</h3>");
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(
                "SELECT id, username, password, fullname, email, phone FROM users");

            out.println("<table><tr><th>id</th><th>username</th><th>password</th>"
                      + "<th>fullname</th><th>email</th><th>phone</th></tr>");
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
                out.println("<tr>"
                    + "<td>" + rs.getInt("id")          + "</td>"
                    + "<td>" + rs.getString("username")  + "</td>"
                    + "<td>" + rs.getString("password")  + "</td>"
                    + "<td>" + rs.getString("fullname")  + "</td>"
                    + "<td>" + rs.getString("email")     + "</td>"
                    + "<td>" + rs.getString("phone")     + "</td>"
                    + "</tr>");
            }
            if (!hasData) {
                out.println("<tr><td colspan='6' style='color:red;text-align:center'>"
                    + "⚠️ Bảng users TRỐNG — chưa có dữ liệu!</td></tr>");
            }
            out.println("</table>");
        } catch (Exception e) {
            out.println("<p class='err'>❌ Lỗi đọc dữ liệu: " + e.getMessage() + "</p>");
        }

        // ── BƯỚC 4: Test query đăng nhập admin/admin ────────────
        out.println("<h3>BƯỚC 4 — Test query đăng nhập (admin / admin)</h3>");
        try {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT id, username, fullname FROM users WHERE username = ? AND password = ?");
            ps.setString(1, "admin");
            ps.setString(2, "admin");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                out.println("<p class='ok'>✅ Đăng nhập admin/admin THÀNH CÔNG — id="
                    + rs.getInt("id") + ", fullname=" + rs.getString("fullname") + "</p>");
            } else {
                out.println("<p class='err'>❌ Không tìm thấy tài khoản admin/admin trong DB!</p>");
            }
        } catch (Exception e) {
            out.println("<p class='err'>❌ Lỗi query: " + e.getMessage() + "</p>");
        }

        try { conn.close(); } catch (Exception ignored) {}
    }
}
