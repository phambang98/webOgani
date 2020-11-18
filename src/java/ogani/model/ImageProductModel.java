/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.model;

import java.util.List;
import ogani.entity.ImageProduct;
import ogani.entity.Product;
import ogani.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Bang-GoD
 */
public class ImageProductModel {

//
    public boolean createImageProduct(ImageProduct imageProduct) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.save(imageProduct);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }

        return check;
    }
//

    public boolean updateImageProduct(ImageProduct imageProduct) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.merge(imageProduct);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }

        return check;
    }

    public boolean deleteImageProduct(ImageProduct imageProduct) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.delete(imageProduct);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
        } finally {
            session.close();
        }

        return check;
    }

    public List<ImageProduct> getImageByProduct(Product product) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from ImageProduct where product=:product");
        query.setEntity("product", product);
        List<ImageProduct> listImage = query.list();
        session.getTransaction().commit();
        session.close();
        return listImage;

    }

}
