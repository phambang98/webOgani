/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.model;

import java.util.List;
import ogani.entity.Product;
import ogani.entity.Star;
import ogani.entity.Users;
import ogani.entityMore.ProductGroup;
import ogani.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Bang-GoD
 */
public class StarModel {

    public boolean insertStar(Star star) {
        boolean check = false;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.save(star);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }

    public Star findStar(Product product, Users users) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Star where product=:product and users=:users");
        query.setEntity("product", product);
        query.setEntity("users", users);
        Star star = (Star) query.uniqueResult();
        session.getTransaction().commit();
        session.close();
        return star;
    }

    public boolean deleteStar(Product product, Users users) {
        boolean check = false;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Star star = findStar(product, users);
            session.delete(star);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }

        return check;
    }

    //Xem ai đã đnáh giá


    //tính trung bình của 1
    public float starAVG(int prodId) {
        Session session = null;
        float avg = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("from Star where product.prodId=:prodId");
            query.setInteger("prodId", prodId);
            List<Star> listStar = query.list();
            int sum = 0;
            if (listStar.size() == 0) {
            } else {
                for (Star star : listStar) {
                    sum += star.getMark();
                }
                avg = (float) sum / (float) listStar.size();
            }
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return avg;
    }
    
    public List<ProductGroup> productGroups(String search, String name, String sort) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = null;
        if (sort.equals("") || name.equals("")) {
            sql = "select new ogani.entityMore.ProductGroup(s.product,avg(s.mark),count(s.id.userId)) "
                    + "from Star s "
                    + "where s.product.prodName like concat('%',:search,'%') "
                    + "group by s.id.prodId ";
        } else {
            sql = "select new ogani.entityMore.ProductGroup("
                    + "s.product as product,avg(s.mark) as avgStar,count(s.users.userId) as countUser) "
                    + "from Star s "
                    + "where s.product.prodName like concat('%',:search,'%') "
                    + "group by s.id.prodId "
                    + "order by " + name + " " + sort + "";
        }
        Query query = session.createQuery(sql);
        query.setString("search", search);
        List<ProductGroup> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public List<ProductGroup> top3Star() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = "select new ogani.entityMore.ProductGroup(s.product,avg(s.mark),count(s.users.userId)) "
                + "from Star s "
                + "group by s.id.prodId "
                + "order by avg(s.mark) DESC";
        Query query = session.createQuery(sql);
        query.setMaxResults(3);
        List<ProductGroup> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public List<ProductGroup> top1Star() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = "select new ogani.entityMore.ProductGroup(s.product,avg(s.mark),count(s.users.userId)) "
                + "from Star s "
                + "group by s.id.prodId "
                + "order by avg(s.mark) DESC";
        Query query = session.createQuery(sql);
        query.setMaxResults(1);
        List<ProductGroup> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public Integer countOne() {
        Session session = null;
        int count = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery(" SELECT count(s.mark) FROM Star s where s.mark=1");
            long abc = (long) query.uniqueResult();
            count = (int) abc;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return count;
    }

    public Integer countTwo() {
        Session session = null;
        int count = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery(" SELECT count(s.mark) FROM Star s where s.mark=2");
            long abc = (long) query.uniqueResult();
            count = (int) abc;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return count;
    }

    public Integer countThree() {
        Session session = null;
        int count = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery(" SELECT count(s.mark) FROM Star s where s.mark=3");
            long abc = (long) query.uniqueResult();
            count = (int) abc;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return count;
    }

    public Integer countFour() {
        Session session = null;
        int count = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery(" SELECT count(s.mark) FROM Star s where s.mark=4");
            long abc = (long) query.uniqueResult();
            count = (int) abc;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return count;
    }

    public Integer countFive() {
        Session session = null;
        int count = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery(" SELECT count(s.mark) FROM Star s where s.mark=5");
            long abc = (long) query.uniqueResult();
            count = (int) abc;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return count;
    }

    public Integer totalCount() {
        Session session = null;
        int count = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery(" SELECT count(s.mark) FROM Star s");
            long abc = (long) query.uniqueResult();
            count = (int) abc;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return count;
    }

}
