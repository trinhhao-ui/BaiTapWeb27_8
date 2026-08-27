package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import DAO.CategoryJpaDao;
import DAO.impl.CategoryJpaDaoImpl;
import Model.Category;

/**
 * Servlet test toàn bộ CRUD Category qua JPA.
 * URL: /test-jpa
 *
 * Kịch bản test (chạy tuần tự):
 *   1. INSERT  - thêm 2 danh mục mới
 *   2. GET ALL - lấy tất cả để xác nhận insert thành công
 *   3. GET BY ID  - lấy theo id
 *   4. GET BY NAME - lấy theo tên
 *   5. UPDATE  - sửa tên + icon
 *   6. SEARCH  - tìm kiếm theo từ khóa
 *   7. DELETE  - xóa 1 bản ghi
 *   8. GET ALL lần cuối - xác nhận đã xóa
 */
@WebServlet("/test-jpa")
public class TestJpaServlet extends HttpServlet {

    private final CategoryJpaDao jpaDao = new CategoryJpaDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        out.println("<!DOCTYPE html><html><head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>JPA CRUD Test</title>");
        out.println("<style>");
        out.println("  body { font-family: monospace; padding: 20px; background:#f5f5f5; }");
        out.println("  h2   { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom:5px; }");
        out.println("  .ok  { color: #27ae60; font-weight: bold; }");
        out.println("  .err { color: #e74c3c; font-weight: bold; }");
        out.println("  .box { background:#fff; border:1px solid #ddd; border-radius:6px;");
        out.println("         padding:12px 16px; margin:10px 0; }");
        out.println("  table { border-collapse:collapse; width:100%; }");
        out.println("  th,td { border:1px solid #ccc; padding:6px 10px; text-align:left; }");
        out.println("  th    { background:#3498db; color:#fff; }");
        out.println("  tr:nth-child(even) { background:#f0f8ff; }");
        out.println("</style></head><body>");
        out.println("<h1>&#128267; JPA CRUD Test - Category</h1>");

        // ── 1. INSERT ─────────────────────────────────────────────────────────
        out.println("<h2>1. INSERT (persist)</h2><div class='box'>");
        try {
            Category c1 = new Category("Áo Nam JPA", "ao-nam.png");
            Category c2 = new Category("Quần Nữ JPA", "quan-nu.png");
            jpaDao.insert(c1);
            jpaDao.insert(c2);
            out.println("<span class='ok'>&#10003; Insert 2 categories thành công</span><br>");
            out.println("&nbsp;&nbsp;- " + c1.getName() + "<br>");
            out.println("&nbsp;&nbsp;- " + c2.getName());
        } catch (Exception e) {
            out.println("<span class='err'>&#10007; Lỗi insert: " + e.getMessage() + "</span>");
        }
        out.println("</div>");

        // ── 2. GET ALL ────────────────────────────────────────────────────────
        out.println("<h2>2. GET ALL (JPQL SELECT)</h2><div class='box'>");
        List<Category> all = null;
        try {
            all = jpaDao.getAll();
            renderTable(out, all);
        } catch (Exception e) {
            out.println("<span class='err'>&#10007; Lỗi getAll: " + e.getMessage() + "</span>");
        }
        out.println("</div>");

        // ── 3. GET BY ID ──────────────────────────────────────────────────────
        out.println("<h2>3. GET BY ID (em.find)</h2><div class='box'>");
        if (all != null && !all.isEmpty()) {
            int testId = all.get(all.size() - 1).getId(); // lấy id bản ghi vừa insert
            try {
                Category found = jpaDao.get(testId);
                if (found != null) {
                    out.println("<span class='ok'>&#10003; Tìm thấy id=" + testId + "</span>: "
                            + found.getName() + " | " + found.getIcon());
                } else {
                    out.println("<span class='err'>&#10007; Không tìm thấy id=" + testId + "</span>");
                }
            } catch (Exception e) {
                out.println("<span class='err'>&#10007; Lỗi: " + e.getMessage() + "</span>");
            }
        } else {
            out.println("<em>Bỏ qua (không có dữ liệu)</em>");
        }
        out.println("</div>");

        // ── 4. GET BY NAME ────────────────────────────────────────────────────
        out.println("<h2>4. GET BY NAME (JPQL getSingleResult)</h2><div class='box'>");
        try {
            Category found = jpaDao.get("Áo Nam JPA");
            if (found != null) {
                out.println("<span class='ok'>&#10003; Tìm thấy tên 'Áo Nam JPA'</span>: id="
                        + found.getId() + " | icon=" + found.getIcon());
            } else {
                out.println("<span class='err'>&#10007; Không tìm thấy 'Áo Nam JPA'</span>");
            }
        } catch (Exception e) {
            out.println("<span class='err'>&#10007; Lỗi: " + e.getMessage() + "</span>");
        }
        out.println("</div>");

        // ── 5. UPDATE ─────────────────────────────────────────────────────────
        out.println("<h2>5. UPDATE (em.merge)</h2><div class='box'>");
        if (all != null && !all.isEmpty()) {
            Category toUpdate = all.get(all.size() - 1);
            String oldName = toUpdate.getName();
            try {
                toUpdate.setName(oldName + " [UPDATED]");
                toUpdate.setIcon("updated-icon.png");
                jpaDao.edit(toUpdate);
                Category afterUpdate = jpaDao.get(toUpdate.getId());
                out.println("<span class='ok'>&#10003; Update thành công</span><br>");
                out.println("&nbsp;&nbsp;Trước: " + oldName + "<br>");
                out.println("&nbsp;&nbsp;Sau&nbsp;: " + (afterUpdate != null ? afterUpdate.getName() : "N/A"));
            } catch (Exception e) {
                out.println("<span class='err'>&#10007; Lỗi update: " + e.getMessage() + "</span>");
            }
        } else {
            out.println("<em>Bỏ qua (không có dữ liệu)</em>");
        }
        out.println("</div>");

        // ── 6. SEARCH ─────────────────────────────────────────────────────────
        out.println("<h2>6. SEARCH (JPQL LIKE)</h2><div class='box'>");
        try {
            List<Category> results = jpaDao.search("JPA");
            out.println("Tìm kiếm keyword <b>'JPA'</b> - tìm thấy <b>" + results.size() + "</b> kết quả:<br><br>");
            renderTable(out, results);
        } catch (Exception e) {
            out.println("<span class='err'>&#10007; Lỗi search: " + e.getMessage() + "</span>");
        }
        out.println("</div>");

        // ── 7. DELETE ─────────────────────────────────────────────────────────
        out.println("<h2>7. DELETE (em.remove)</h2><div class='box'>");
        if (all != null && !all.isEmpty()) {
            int deleteId = all.get(all.size() - 1).getId();
            try {
                jpaDao.delete(deleteId);
                Category afterDelete = jpaDao.get(deleteId);
                if (afterDelete == null) {
                    out.println("<span class='ok'>&#10003; Xóa thành công id=" + deleteId + "</span>");
                } else {
                    out.println("<span class='err'>&#10007; Xóa thất bại - bản ghi vẫn còn</span>");
                }
            } catch (Exception e) {
                out.println("<span class='err'>&#10007; Lỗi delete: " + e.getMessage() + "</span>");
            }
        } else {
            out.println("<em>Bỏ qua (không có dữ liệu)</em>");
        }
        out.println("</div>");

        // ── 8. GET ALL sau khi delete ─────────────────────────────────────────
        out.println("<h2>8. GET ALL sau khi xóa</h2><div class='box'>");
        try {
            List<Category> final_ = jpaDao.getAll();
            renderTable(out, final_);
        } catch (Exception e) {
            out.println("<span class='err'>&#10007; Lỗi: " + e.getMessage() + "</span>");
        }
        out.println("</div>");

        out.println("<hr><p><em>Test hoàn tất.</em></p>");
        out.println("</body></html>");
    }

    /** Render danh sách Category thành HTML table */
    private void renderTable(PrintWriter out, List<Category> list) {
        if (list == null || list.isEmpty()) {
            out.println("<em>(Không có dữ liệu)</em>");
            return;
        }
        out.println("<table>");
        out.println("<tr><th>ID</th><th>Tên</th><th>Icon</th></tr>");
        for (Category c : list) {
            out.println("<tr><td>" + c.getId() + "</td><td>"
                    + c.getName() + "</td><td>" + c.getIcon() + "</td></tr>");
        }
        out.println("</table>");
    }
}
