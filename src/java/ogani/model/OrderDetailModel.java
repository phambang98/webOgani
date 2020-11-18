/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.model;

import java.util.List;

import ogani.entity.OrderDetail;
import ogani.entityMore.ProductGroup;
import ogani.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Bang-GoD
 */
public class OrderDetailModel {

    public List<OrderDetail> getAllOrderDetail() {

        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from OrderDetail");
        List<OrderDetail> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public List<OrderDetail> findOrderDetail(int orderId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from OrderDetail where orders.orderId=:orderId ");
        query.setInteger("orderId", orderId);
        List<OrderDetail> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public boolean createOrderDetail(List<OrderDetail> orderDetail) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            for (int i = 0; i < orderDetail.size(); i++) {
                session.save(orderDetail.get(i));
            }
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }

    public boolean updateOrderDetail(OrderDetail orderDetail) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.merge(orderDetail);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }
    

    //Tính sản phẩm : số lượng thành tiền đã bán
    public List<ProductGroup> productGroup(String search, String sort, String name) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = null;
        if (sort.equals("") || name.equals("")) {

            sql = "select new ogani.entityMore.ProductGroup(sum(o.quantity),sum(o.amount),o.product) "
                    + "from OrderDetail o "
                    + "where o.product.prodName like concat('%',:search,'%') and o.orders.orderStatus='actived' "
                    + "group by o.id.prodId ";
        } else {
            sql = "select new ogani.entityMore.ProductGroup(sum(o.quantity),sum(o.amount),o.product) "
                    + "from OrderDetail o "
                    + "where o.product.prodName like concat('%',:search,'%') and o.orders.orderStatus='actived' "
                    + "group by o.id.prodId "
                    + "order by sum(o." + name + ") " + sort + "";

        }
        Query query = session.createQuery(sql);
        query.setString("search", search);
        List<ProductGroup> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }
    
    public List<ProductGroup> top5Product() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = "select new ogani.entityMore.ProductGroup(sum(o.amount),o.product) "
                + "from OrderDetail o "
                + "where o.orders.orderStatus='actived' "
                + "group by o.id.prodId "
                + "order by sum(o.amount) DESC ";
        Query query = session.createQuery(sql);
        query.setMaxResults(5);
        List<ProductGroup> list = query.list();
        session.getTransaction().commit();
        session.close();

        return list;
    }

    public List<ProductGroup> Top3Product() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = "select new ogani.entityMore.ProductGroup(sum(o.amount),o.product) "
                + "from OrderDetail o "
                + "where o.orders.orderStatus='actived' "
                + "group by o.id.prodId "
                + "order by sum(o.amount) DESC ";
        Query query = session.createQuery(sql);
        query.setMaxResults(3);
        List<ProductGroup> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public List<ProductGroup> top1Product() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = "select new ogani.entityMore.ProductGroup(sum(o.amount),o.product) "
                + "from OrderDetail o "
                + "where o.orders.orderStatus='actived' "
                + "group by o.id.prodId "
                + "order by sum(o.amount) DESC ";
        Query query = session.createQuery(sql);
        query.setMaxResults(1);
        List<ProductGroup> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    
    //Thống kê sản phẩm bán theo giảm giá
    public List<ProductGroup> viewProduct(Integer prodId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = "select new ogani.entityMore.ProductGroup(sum(o.quantity),sum(o.amount),o.product,o.discount) "
                + "from OrderDetail o "
                + "where o.orders.orderStatus='actived' and o.id.prodId=:prodId "
                + "group by o.discount,o.id.prodId ";
        Query query = session.createQuery(sql);
        query.setInteger("prodId", prodId);
        List<ProductGroup> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

//    //Thống Kê Sản Phẩm Theo Tháng
    public List<ProductGroup> writeExcelToMonth(Integer year, Integer month) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = "select new ogani.entityMore.ProductGroup(sum(o.quantity),sum(o.amount),o.product,o.discount) "
                + "from OrderDetail o "
                + "where o.id.orderId in "
                + "(select orderId from Orders "
                + "where year(created)=:year and month(created)=:month and orderStatus='actived') "
                + "group by o.id.prodId,o.discount ";
        Query query = session.createQuery(sql);
        query.setParameter("year", year);
        query.setParameter("month", month);
        List<ProductGroup> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }
}
