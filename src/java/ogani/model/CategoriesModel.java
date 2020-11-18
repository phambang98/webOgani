/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.model;

import java.util.List;
import ogani.entity.Categories;
import ogani.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Bang-GoD
 */
public class CategoriesModel {

    public List<Categories> getAllCateTrue() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Categories where cateStatus=1");
        List<Categories> listCate = query.list();
        session.getTransaction().commit();
        session.close();
        return listCate;
    }

    public Categories findCate(int cateId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Categories where cateId=:cateId");
        query.setInteger("cateId", cateId);
        Categories categories = (Categories) query.uniqueResult();
        session.getTransaction().commit();
        session.close();
        return categories;
    }
    //tìm kiếm list product theo cate và từ khóa search

    public boolean createCate(Categories categories) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.save(categories);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }

    public boolean updateCate(Categories categories) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.merge(categories);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }

    public boolean deleteCate(int cateId) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Categories categories = findCate(cateId);
            session.delete(categories);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }

    public List<Categories> getBySearch(String search, String sort) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = null;
        if (sort.equals("")) {
            sql = "from Categories where cateName like concat('%',:search,'%')";
        } else {
            sql = "from Categories where cateName like concat('%',:search,'%') "
                    + "order by cateName " + sort + "";
        }
        Query query = session.createQuery(sql);
        query.setString("search", search);
        List<Categories> lp = query.list();
        session.getTransaction().commit();
        session.close();
        return lp;
    }

    public int countCate() {
        Session session = null;
        int count = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select count(cateId) from Categories");
            long imun = (long) query.uniqueResult();
            count = (int) imun;
            session.getTransaction().commit();

        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return count;
    }
}
