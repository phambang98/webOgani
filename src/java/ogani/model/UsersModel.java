/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.model;

import java.util.List;
import ogani.entity.Users;
import ogani.entityMore.UserGroup;
import ogani.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Bang-GoD
 */
public class UsersModel {

    public Users findUsers(int userId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Users where userId=:userId");
        query.setInteger("userId", userId);
        Users users = (Users) query.uniqueResult();
        session.getTransaction().commit();
        session.close();
        return users;
    }

    public boolean checkUserName(String userName) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("from Users where userName=:userName and isAdmin=0");
            query.setString("userName", userName);
            Users users = (Users) query.uniqueResult();
            if (users != null) {
                check = true;
            }
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }

    public Users login(String userName, String passWords) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Users where userName=:userName and passWords=:passWords and isAdmin=0");
        query.setString("userName", userName);
        query.setString("passWords", passWords);
        Users users = (Users) query.uniqueResult();
        session.getTransaction().commit();
        session.close();

        return users;

    }

    public Users loginAdmin(String userName, String passWords) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Users where userName=:userName and passWords=:passWords and isAdmin=1");
        query.setString("userName", userName);
        query.setString("passWords", passWords);
        Users users = (Users) query.uniqueResult();
        session.getTransaction().commit();
        session.close();

        return users;

    }

    public boolean createUsers(Users users) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.save(users);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }

    public boolean updateUsers(Users users) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.merge(users);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }

    public boolean DeleteUsers(int userId) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Users users = findUsers(userId);
            session.delete(users);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }

    public int countUsers() {
        Session session = null;
        int count = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select count(userId) from Users where isAdmin=0 ");
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

    public List<UserGroup> userGroup(String search, String sort) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = null;
        if (sort.equals("") || sort.equals("")) {
            sql = "select new ogani.entityMore.UserGroup(sum(o.totalAmount),o.users) "
                    + "from Orders o "
                    + "where o.users.userName like concat('%',:search,'%') and o.orderStatus='actived' and o.users.isAdmin=0 "
                    + "group by o.users.userId ";

        } else {
            sql = "select new ogani.entityMore.UserGroup(sum(o.totalAmount),o.users) "
                    + "from Orders o "
                    + "where o.users.userName like concat('%',:search,'%') and o.orderStatus='actived' and o.users.isAdmin=0 "
                    + "group by o.users.userId "
                    + "order by sum(o.totalAmount) " + sort + "";
        }
        Query query = session.createQuery(sql);
        query.setString("search", search);
        List<UserGroup> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public List<UserGroup> allUsersGroup(String search, String name, String sort) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = null;
        if (name.equals("") || sort.equals("")) {
            sql = "select new ogani.entityMore.UserGroup(u ,"
                    + "(select count(s.users.userId) from Star s where s.users.userId=u.userId) as countStar,"
                    + "(select count(c.users.userId) from Comment c where c.users.userId=u.userId) as countComment,"
                    + "(select count(o.users.userId) from Orders o where o.users.userId=u.userId "
                    + "and o.orderStatus='actived') as countBuy "
                    + ") "
                    + "from Users u "
                    + "where u.userName like concat('%',:search,'%') and  u.isAdmin=0 ";
        } else {
            sql = "select new ogani.entityMore.UserGroup(u ,"
                    + "(select count(s.users.userId) from Star s where s.users.userId=u.userId) as countStar,"
                    + "(select count(c.users.userId) from Comment c where c.users.userId=u.userId) as countComment,"
                    + "(select count(o.users.userId) from Orders o where o.users.userId=u.userId "
                    + "and o.orderStatus='actived') as countBuy "
                    + ") "
                    + "from Users u "
                    + "where u.userName like concat('%',:search,'%') and  u.isAdmin=0 "
                    + "order by " + name + " " + sort + "";
        }
        Query query = session.createQuery(sql);
        query.setString("search", search);
        List<UserGroup> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

}
