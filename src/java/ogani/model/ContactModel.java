/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.model;

import java.util.List;
import ogani.entity.Contact;
import ogani.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Bang-GoD
 */
public class ContactModel {


     public List<Contact> getAllContact() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Contact");
        List<Contact> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }
    
    public Contact top1Contact() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Contact");
        query.setMaxResults(1);
        Contact contact=(Contact) query.uniqueResult();
        session.getTransaction().commit();
        session.close();
        return contact;
    }

    public Contact findContact(int id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Contact where id=:id");
        query.setInteger("id", id);
        Contact contact = (Contact) query.uniqueResult();
        session.getTransaction().commit();
        session.close();
        return contact;
    }

    public boolean createContact(Contact contact) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.save(contact);
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

    public boolean updateContact(Contact contact) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.merge(contact);
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

    public boolean deleteContact(int id) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Contact contact = findContact(id);
            session.delete(contact);
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
}
