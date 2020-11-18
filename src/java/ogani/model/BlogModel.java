/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.model;

import java.util.List;
import ogani.entity.Blog;
import ogani.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Bang-GoD
 */
public class BlogModel {

    public List<Blog> getAllBlogTrue() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Blog where blogStatus=1");
        List<Blog> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public int countAllBlog() {
        Session session = null;
        int count = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select count(blogId) from Blog ");
            long imun = (long) query.uniqueResult();
            count = (int) imun;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        }
        session.close();
        return count;
    }

    public Blog findBlog(int blogId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Blog where blogId=:blogId");
        query.setInteger("blogId", blogId);
        Blog blog = (Blog) query.uniqueResult();
        session.getTransaction().commit();
        session.close();
        return blog;
    }

    public boolean createBlog(Blog blog) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.save(blog);
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

    public boolean updateBlog(Blog blog) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.merge(blog);
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

    public boolean deleteBlog(int blogId) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Blog categories = findBlog(blogId);
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

    public List<Blog> newBlog() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery(" from Blog where blogStatus=1 ORDER BY created DESC");
        List<Blog> listblog = query.list();
        session.getTransaction().commit();
        session.close();
        return listblog;
    }

    public List<Blog> getBySearch(String search, String sort) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = null;
        if (sort.equals("")) {
            sql = "from Blog where blogName like concat('%',:search,'%')";
        } else {
            sql = "from Blog where blogName like concat('%',:search,'%') "
                    + " order by blogName " + sort + "";
        }
        Query query = session.createQuery(sql);
        query.setString("search", search);
        List<Blog> lp = query.list();
        session.getTransaction().commit();
        session.close();
        return lp;
    }
}
