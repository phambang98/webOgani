/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import ogani.entity.Orders;
import ogani.entityMore.UserGroup;
import ogani.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Bang-GoD
 */
public class OrderModel {

    //Tìm Đơn Hàng
    public Orders getOrdersById(int orderId) {
        Session session = null;
        Orders orders = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("from Orders where orderId=:orderId");
            query.setInteger("orderId", orderId);
            orders = (Orders) query.uniqueResult();
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().commit();
        } finally {
            session.close();
        }
        return orders;
    }
    //thêm đơn hàng

    public boolean createOrders(Orders orders) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.persist(orders);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return check;
    }

    //sủa đơn hàng
    public boolean updateOrders(Orders orders) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.merge(orders);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return check;
    }

    //Đã Duyệt
    //lấy đơn hàng đã duyệt
    public List<Orders> getAllTrueAndSearchSort(String search, String name, String sort) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();

        String sql = null;
        if (name.equals("") || sort.equals("")) {
            sql = "from Orders where orderStatus='actived' and "
                    + "users.userName like concat('%',:search,'%')";

        } else {
            sql = "from Orders where orderStatus='actived' and "
                    + "users.userName like concat('%',:search,'%')"
                    + " order by " + name + " " + sort + "";
        }

        Query query = session.createQuery(sql);
        query.setString("search", search);
        List<Orders> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }
    //Tổng tiền đã duyệt

    public float AmountOrderTrue() {
        Session session = null;
        float totalAmount = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select sum(totalAmount) from Orders where orderStatus='actived'");
            double sum = (double) query.uniqueResult();
            totalAmount = (float) sum;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {

            session.close();
        }
        return totalAmount;
    }

    //tổng số lượng đơn hàng đã duyệt
    public int countOrderTrue() {
        Session session = null;
        int countInt = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select count(orderId) from Orders where orderStatus='actived'");
            long count = (long) query.uniqueResult();
            countInt = (int) count;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return countInt;
    }

    //Top 1 người Dùng
    public List<UserGroup> top1Users() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = "select new ogani.entityMore.UserGroup(sum(o.totalAmount),o.users) "
                + "from Orders o "
                + "where o.orderStatus='actived' "
                + "group by o.users.userId "
                + "order by sum(o.totalAmount) DESC ";
        Query query = session.createQuery(sql);
        query.setMaxResults(1);
        List<UserGroup> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    //tính min ngày 
    public String minDate() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = "select min(o.created) from Orders o where o.orderStatus='actived'";
        Query query = session.createQuery(sql);
        Date dateMin = (Date) query.uniqueResult();
        DateFormat df = new SimpleDateFormat("yyyy-MM");
        String min = df.format(dateMin);
        session.getTransaction().commit();
        session.close();
        return min;
    }

    //mã ngày
    public String maxDate() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = "select max(o.created) from Orders o where o.orderStatus='actived'";
        Query query = session.createQuery(sql);
        Date dateMax = (Date) query.uniqueResult();
        DateFormat df = new SimpleDateFormat("yyyy-MM");
        String max = df.format(dateMax);
        session.getTransaction().commit();
        session.close();
        return max;
    }

    //Kết thúc đã duyệt
    //Chờ Duyệt
    //All
    public List<Orders> getAllPendingAndSearchSort(String search, String name, String sort) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = null;
        if (name.equals("") || sort.equals("")) {
            sql = "from Orders where orderStatus='pending' and "
                    + "users.userName like concat('%',:search,'%')";

        } else {
            sql = "from Orders where orderStatus='pending' and "
                    + "users.userName like concat('%',:search,'%')"
                    + " order by " + name + " " + sort + "";
        }
        Query query = session.createQuery(sql);
        query.setString("search", search);
        List<Orders> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    //lấy đơn hàng chờ duyệt
    public List<Orders> top3OrderPending() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Orders where orderStatus='pending' order by orderId DESC");
        query.setMaxResults(3);
        List<Orders> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    //tim đơn hàng theo users
    public List<Orders> findOrders(int userId) {
        Session session = null;
        List<Orders> list = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("from Orders where users.userId=:userId");
            query.setInteger("userId", userId);
            list = query.list();
            session.getTransaction().commit();

        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return list;
    }

    //Tổng tiền chờ duyệt
    public float AmountOrderPending() {
        Session session = null;
        float totalAmount = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select sum(totalAmount) from Orders  where orderStatus='pending'");
            double sum = (double) query.uniqueResult();
            totalAmount = (float) sum;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return totalAmount;
    }

    //tổng số lượng đơn hàng Chờ duyệt
    public int countOrderPending() {
        Session session = null;
        int countInt = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select count(orderId) from Orders where orderStatus='pending'");
            long count = (long) query.uniqueResult();
            countInt = (int) count;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return countInt;
    }

    //Từ Chối
    //Số Lượng
    public int countOrderFalse() {
        Session session = null;
        int countInt = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select count(orderId) from Orders where orderStatus='not actived'");
            long count = (long) query.uniqueResult();
            countInt = (int) count;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return countInt;
    }
    //Tất cả từ chối

    public List<Orders> getAllFalse() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = "from Orders where orderStatus='not actived'";
        Query query = session.createQuery(sql);
        List<Orders> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }


}
