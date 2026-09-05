package Utils;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

/**
 * Custom Sitemesh 3 Filter - đọc config từ sitemesh3.xml (mặc định).
 *
 * Decorator JSP lấy content bằng:
 *   Content c = (Content) request.getAttribute("com.opensymphony.module.sitemesh.PAGE");
 * hoặc dùng WebAppContext.CONTENT_KEY.
 *
 * Cấu hình URL mappings được đặt trong applyCustomConfiguration().
 */
public class AppSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {

        // Giao diện mới dùng HTML đầy đủ tự viết (không Bootstrap decorator).
        // Tất cả đường dẫn đều bị exclude khỏi SiteMesh để tránh double-wrap.
        builder.addExcludedPath("/*");
    }
}
