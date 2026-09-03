package Utils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

/**
 * Tiện ích xử lý upload ảnh
 */
public class UploadHelper {

    // Thư mục lưu ảnh trong webapp
    private static final String IMAGE_FOLDER = "images";

    /**
     * Upload ảnh, trả về đường dẫn relative lưu vào DB
     * VD: "images/1234567890_ao-nam.jpg"
     */
    public static String uploadImage(Part filePart, ServletContext context) throws IOException {

        String fileName = getFileName(filePart);
        if (fileName == null || fileName.isEmpty()) return "";

        // Tên file unique = timestamp + tên gốc
        String uniqueName = System.currentTimeMillis() + "_" + fileName;

        // ── Thư mục 1: wtpwebapps (đang chạy, hiện ảnh ngay) ──
        String deployDir = context.getRealPath("") + File.separator + IMAGE_FOLDER;
        File deployFolder = new File(deployDir);
        if (!deployFolder.exists()) deployFolder.mkdirs();

        File deployFile = new File(deployDir + File.separator + uniqueName);
        filePart.write(deployFile.getAbsolutePath());

        // ── Thư mục 2: src/main/webapp/images/ (giữ sau redeploy) ──
        // Tìm đường dẫn src từ đường dẫn deploy
        String deployPath = context.getRealPath("");
        // deployPath dạng: ...\.metadata\.plugins\...\tmp0\wtpwebapps\BaiHocDauTien\
        // Thay thế bằng workspace path
        String srcImages = deployPath
            .replace(".metadata" + File.separator + ".plugins" + File.separator
                   + "org.eclipse.wst.server.core" + File.separator
                   + "tmp0" + File.separator + "wtpwebapps" + File.separator + "BaiHocDauTien",
                     "BaiHocDauTien" + File.separator + "src" + File.separator
                   + "main" + File.separator + "webapp" + File.separator + IMAGE_FOLDER);

        File srcFolder = new File(srcImages);
        if (srcFolder.exists()) {
            Files.copy(deployFile.toPath(),
                       new File(srcImages + File.separator + uniqueName).toPath(),
                       StandardCopyOption.REPLACE_EXISTING);
        }

        return IMAGE_FOLDER + "/" + uniqueName;
    }

    /**
     * Xóa ảnh cũ (xóa cả 2 nơi)
     */
    public static void deleteImage(String iconPath, ServletContext context) {
        if (iconPath == null || iconPath.isEmpty()) return;

        String fileName = new File(iconPath).getName();

        // Xóa trong deploy
        String deployFile = context.getRealPath("") + File.separator + IMAGE_FOLDER
                          + File.separator + fileName;
        new File(deployFile).delete();

        // Xóa trong src
        String deployPath = context.getRealPath("");
        String srcFile = deployPath.replace(
            ".metadata" + File.separator + ".plugins" + File.separator
          + "org.eclipse.wst.server.core" + File.separator
          + "tmp0" + File.separator + "wtpwebapps" + File.separator + "BaiHocDauTien",
            "BaiHocDauTien" + File.separator + "src" + File.separator
          + "main" + File.separator + "webapp" + File.separator + IMAGE_FOLDER)
            + File.separator + fileName;
        new File(srcFile).delete();
    }

    /**
     * Lấy tên file từ Part header
     */
    public static String getFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        if (cd == null) return null;
        for (String token : cd.split(";")) {
            if (token.trim().startsWith("filename")) {
                String name = token.substring(token.indexOf('=') + 1)
                                   .trim().replace("\"", "");
                return new File(name).getName(); // tránh IE gửi full path
            }
        }
        return null;
    }
}
