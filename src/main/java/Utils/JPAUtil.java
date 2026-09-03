package Utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * JPAUtil - Singleton quản lý EntityManagerFactory
 */
public class JPAUtil {

    /** Tên phải khớp với persistence-unit name trong persistence.xml */
    private static final String PERSISTENCE_UNIT = "CategoryPU";

    /** Khởi tạo một lần duy nhất khi class được load */
    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);

    // Private constructor - không cho phép tạo instance
    private JPAUtil() {}

    /**
     * Trả về một EntityManager mới.
     * Caller có trách nhiệm gọi em.close() sau khi dùng xong.
     */
    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    /**
     * Đóng EntityManagerFactory khi ứng dụng shutdown.
     * Gọi method này trong ServletContextListener.contextDestroyed().
     */
    public static void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
