package Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet serve ảnh - giải quyết vấn đề Eclipse WTP không serve static file
 * URL: /img?name=ao-nam.png hoặc /images/ao-nam.png
 */
@WebServlet(urlPatterns = {"/img", "/images/*"})
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Lấy filename từ query param hoặc path
        String fileName = req.getParameter("name");
        if (fileName == null || fileName.isEmpty()) {
            // Nếu không có param, lấy từ path: /images/abc.png → abc.png
            String pathInfo = req.getPathInfo();
            if (pathInfo != null && !pathInfo.isEmpty()) {
                fileName = pathInfo.substring(1); // bỏ dấu / đầu
            }
        }
        
        if (fileName == null || fileName.isEmpty()) {
            resp.sendError(404); 
            return;
        }

        // Tìm ảnh trong wtpwebapps trước
        String deployImages = req.getServletContext().getRealPath("") 
                            + File.separator + "images" 
                            + File.separator + fileName;
        File file = new File(deployImages);

        System.out.println("=== ImageServlet ===");
        System.out.println("fileName  : " + fileName);
        System.out.println("deployPath: " + deployImages);
        System.out.println("exists    : " + file.exists());

        // Nếu không có trong deploy, tìm trong src/main/webapp
        if (!file.exists()) {
            String srcImages = getClass().getClassLoader()
                .getResource("").getPath()
                .replace("/WEB-INF/classes/", "/images/" + fileName);
            file = new File(srcImages);
        }

        if (!file.exists()) {
            resp.sendError(404, "Image not found: " + fileName);
            return;
        }

        // Set Content-Type theo đuôi file
        String ext = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
        switch (ext) {
            case "png"  -> resp.setContentType("image/png");
            case "jpg",
                 "jpeg" -> resp.setContentType("image/jpeg");
            case "svg"  -> resp.setContentType("image/svg+xml");
            case "gif"  -> resp.setContentType("image/gif");
            case "webp" -> resp.setContentType("image/webp");
            default     -> resp.setContentType("application/octet-stream");
        }

        resp.setContentLengthLong(file.length());

        // Stream file ra response
        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = resp.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}
