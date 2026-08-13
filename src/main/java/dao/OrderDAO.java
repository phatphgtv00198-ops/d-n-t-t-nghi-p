package dao;

import entity.Account;
import entity.Order;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import util.JPAUtil;

import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    /**
     * Lấy danh sách tất cả đơn hàng cho Admin/Staff.
     */
    public List<Order> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // Fetch Customer và Staff để hiển thị đầy đủ thông tin bảng Admin
            String hql = "SELECT DISTINCT o FROM Order o " +
                    "LEFT JOIN FETCH o.customer " +
                    "LEFT JOIN FETCH o.staff " +
                    "ORDER BY o.orderID DESC";
            return em.createQuery(hql, Order.class).getResultList();
        } catch (Exception e) {
            System.err.println(">>> [OrderDAO] LOI TAI findAll:");
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * Lấy danh sách lịch sử đơn hàng theo Account ID
     */
    public List<Order> findByAccount(Account account) {
        if (account == null) return new ArrayList<>();

        EntityManager em = JPAUtil.getEntityManager();
        try {
            // Sửa lại HQL: JOIN FETCH cả Customer và OrderDetails để nạp dữ liệu an toàn trong 1 phiên EntityManager
            String hql = "SELECT DISTINCT o FROM Order o " +
                    "LEFT JOIN FETCH o.customer c " +
                    "LEFT JOIN FETCH o.orderDetails d " +
                    "WHERE c.account = :acc OR c.account.accountID = :accId " +
                    "ORDER BY o.orderID DESC";

            List<Order> list = em.createQuery(hql, Order.class)
                    .setParameter("acc", account)
                    .setParameter("accId", account.getAccountID())
                    .getResultList();

            return list;
        } catch (Exception e) {
            System.err.println(">>> [OrderDAO] LOI TAI findByAccount:");
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * Lấy chi tiết đơn hàng theo ID (Fetch lồng 3 cấp: Order -> OrderDetail -> Product)
     */
    public Order findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String hql = "SELECT DISTINCT o FROM Order o " +
                    "LEFT JOIN FETCH o.customer " +
                    "LEFT JOIN FETCH o.staff " +
                    "LEFT JOIN FETCH o.orderDetails d " +
                    "LEFT JOIN FETCH d.product " +
                    "WHERE o.orderID = :id";

            return em.createQuery(hql, Order.class)
                    .setParameter("id", id)
                    .getSingleResult();

        } catch (NoResultException e) {
            System.out.println(">>> [OrderDAO] KHONG TIM THAY DON HANG ID: " + id);
            return null;
        } catch (Exception e) {
            System.err.println(">>> [OrderDAO] LOI TAI findById:");
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Cập nhật trạng thái đơn hàng (Duyệt/Hủy)
     */
    public boolean updateStatus(int orderId, Object newStatus) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Order order = em.find(Order.class, orderId);
            if (order != null) {
                Order.OrderStatus statusToUpdate = null;

                if (newStatus instanceof Order.OrderStatus) {
                    statusToUpdate = (Order.OrderStatus) newStatus;
                } else if (newStatus != null) {
                    String statusStr = newStatus.toString().trim();
                    for (Order.OrderStatus statusEnum : Order.OrderStatus.values()) {
                        if (statusEnum.name().equalsIgnoreCase(statusStr)) {
                            statusToUpdate = statusEnum;
                            break;
                        }
                    }
                }

                // Chỉ commit nếu trạng thái hợp lệ
                if (statusToUpdate != null) {
                    order.setStatus(statusToUpdate);
                    em.merge(order);
                    trans.commit();
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            System.err.println(">>> [OrderDAO] LOI TAI updateStatus:");
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}