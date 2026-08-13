package util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {
    // Sửa tên thành "BanDoGiaDung" cho trùng với persistence.xml
    private static final String PERSISTENCE_UNIT_NAME = "BanDoGiaDung";
    private static EntityManagerFactory factory;

    public static EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
        }
        return factory.createEntityManager();
    }

    public static void close() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}