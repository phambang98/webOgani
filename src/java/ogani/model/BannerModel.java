/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.model;

import java.util.List;
import ogani.entity.Banner;
import ogani.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Bang-GoD
 */
public class BannerModel {

    public List<Banner> getAllBanner() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Banner order by prioritys DESC");
        List<Banner> listBanner = query.list();
        session.getTransaction().commit();
        session.close();
        return listBanner;
    }
     public List<Banner> getAllBannerTrue() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Banner where bannerStatus=1 order by prioritys DESC");
        List<Banner> listBanner = query.list();
        session.getTransaction().commit();
        session.close();
        return listBanner;
    }

    public Banner findBanner(int bannerId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Banner where bannerId=:bannerId");
        query.setInteger("bannerId", bannerId);
        Banner banner = (Banner) query.uniqueResult();
        session.getTransaction().commit();
        session.close();
        return banner;

    }

    public boolean createBanner(Banner banner) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.save(banner);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
        } finally {
            session.close();
        }
        return check;
    }

    public boolean updateBanner(Banner banner) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.merge(banner);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return check;
    }

    public boolean deleteBanner(int bannerId) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Banner banner = findBanner(bannerId);
            session.delete(banner);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return check;
    }

    public int countBanner() {
        int count = 0;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select count(bannerId) from Banner");
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
