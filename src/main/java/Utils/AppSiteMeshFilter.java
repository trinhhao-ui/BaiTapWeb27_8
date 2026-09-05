package Utils;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

/**
 * SiteMesh 3 Filter — áp dụng Bootstrap decorator theo từng nhóm URL.
 *
 * Decorator JSP dùng:
 *   Content _c = (Content) request.getAttribute(WebAppContext.CONTENT_KEY);
 *   String _body = _c.getExtractedProperties().getChild("body").getValue();
 */
public class AppSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {

        // ── Exclude static resources ──────────────────────────
        builder.addExcludedPath("/images/*")
               .addExcludedPath("/img")
               .addExcludedPath("/uploads/*")
               .addExcludedPath("/css/*")
               .addExcludedPath("/js/*")
               .addExcludedPath("/test-jpa")
               .addExcludedPath("/waiting");

        // ── Decorator mappings ────────────────────────────────
        // Guest (chưa đăng nhập): login, register, forgot/reset/verify
        builder.addDecoratorPath("/login",           "guest-layout.jsp")
               .addDecoratorPath("/register",        "guest-layout.jsp")
               .addDecoratorPath("/forgot-password", "guest-layout.jsp")
               .addDecoratorPath("/verify-otp",      "guest-layout.jsp")
               .addDecoratorPath("/reset-password",  "guest-layout.jsp");

        // Admin panel
        builder.addDecoratorPath("/admin/*", "admin-layout.jsp");

        // User + public product pages
        builder.addDecoratorPath("/user/*",       "user-layout.jsp")
               .addDecoratorPath("/product",      "user-layout.jsp")
               .addDecoratorPath("/product/*",    "user-layout.jsp");
    }
}
