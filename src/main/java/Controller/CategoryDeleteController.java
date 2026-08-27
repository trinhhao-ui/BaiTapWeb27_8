package Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import Service.CategoryService;
import Service.impl.CategoryServiceImpl;

/**
 * Xử lý xóa danh mục
 * URL: /admin/category/delete?id=1
 * GET -> xóa theo id, redirect về list
 */
@WebServlet(urlPatterns = { "/admin/category/delete" })
public class CategoryDeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. Lấy id từ URL: /delete?id=1
        String id = req.getParameter("id");

        // 2. Gọi Service xóa
        cateService.delete(Integer.parseInt(id));

        // 3. Redirect về danh sách
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }
}
