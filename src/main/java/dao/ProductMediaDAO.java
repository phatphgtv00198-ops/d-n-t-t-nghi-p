package dao;

import entity.ProductMedia;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import service.EntityConnectivity;

import java.util.List;

public class ProductMediaDAO implements CrudDAO<ProductMedia, Integer> {

    @Override
    public void create(ProductMedia entity) {
        EntityManager em = EntityConnectivity.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(ProductMedia entity) {
        EntityManager em = EntityConnectivity.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Integer id) {
        EntityManager em = EntityConnectivity.getEntityManager();
        try {
            em.getTransaction().begin();
            ProductMedia media = em.find(ProductMedia.class, id);
            if (media != null) {
                em.remove(media);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public ProductMedia findById(Integer id) {
        EntityManager em = EntityConnectivity.getEntityManager();
        try {
            return em.find(ProductMedia.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<ProductMedia> findAll() {
        EntityManager em = EntityConnectivity.getEntityManager();
        try {
            String jpql = "SELECT m FROM ProductMedia m";
            TypedQuery<ProductMedia> query = em.createQuery(jpql, ProductMedia.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Hàm lấy danh sách tất cả ảnh & video chi tiết của 1 sản phẩm
     */
    public List<ProductMedia> findByProductId(Integer productId) {
        EntityManager em = EntityConnectivity.getEntityManager();
        try {
            String jpql = "SELECT m FROM ProductMedia m WHERE m.product.productID = :productId";
            TypedQuery<ProductMedia> query = em.createQuery(jpql, ProductMedia.class);
            query.setParameter("productId", productId);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
}