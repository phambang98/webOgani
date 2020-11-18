/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.model;


import java.util.List;
import ogani.entity.Comment;
import ogani.entityMore.ProductGroup;
import ogani.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Bang-GoD
 */
public class CommentModel {

    //lấy hết
    public List<Comment> getAllCommentByTrue() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Comment where commentStatus=1");
        List<Comment> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    //lấy hết comment đã duyệt
    public List<Comment> getAllComment() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Comment");
        List<Comment> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }
// lấy hết comment chưa duyệt

    public List<Comment> getAllCommentByFalse() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Comment where commentStatus=0");
        List<Comment> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    //Top 3 comment chưa duyệt
    public List<Comment> top3CommentFalse() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Comment where commentStatus=0 order by commentId DESC");
        query.setMaxResults(3);
        List<Comment> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public List<Comment> findListRepCommentByProduct(int prodId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Comment where product.prodId=:prodId and parentId>0 and commentStatus=1");
        query.setInteger("prodId", prodId);
        List<Comment> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public List<Comment> findListCommentByProduct(int prodId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Comment where product.prodId=:prodId and parentId=0 and commentStatus=1");
        query.setInteger("prodId", prodId);
        List<Comment> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public Comment findByCommentId(int commentId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Comment where commentId=:commentId");
        query.setInteger("commentId", commentId);
        Comment comment = (Comment) query.uniqueResult();
        session.getTransaction().commit();
        session.close();
        return comment;
    }

    public List<Comment> findCommentAndUserId(int prodId, int userId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Comment where product.prodId=:prodId and Users.userId=:userId");
        query.setInteger("prodId", prodId);
        query.setInteger("userId", userId);
        List<Comment> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public boolean createComment(Comment comment) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.save(comment);
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

    public boolean updateComment(Comment comment) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.merge(comment);
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

    public boolean deleteComment(int commentId) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Comment comment = (Comment) findByCommentId(commentId);
             session.delete(comment);
            List<Comment> lc = findParentId(commentId);
            for (Comment comment1 : lc) {
                session.delete(comment1);
            }
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

    public List<Comment> findParentId(int commentId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Comment where parentId=:commentId");
        query.setInteger("commentId", commentId);
        List<Comment> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    //lấy productId
    public List<Integer> listProdId() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery(" SELECT DISTINCT product.prodId FROM Comment");
        List<Integer> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }
    //tổng số bình luận theo sản phẩm
    public int countComment(int prodId) {
        int inum = 0;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select count(commentId) from Comment where product.prodId=:prodId");
            query.setInteger("prodId", prodId);
            long count = (long) query.uniqueResult();
            inum = (int) count;
            session.getTransaction().commit();
        } catch (Exception e) {
        } finally {
            session.close();
        }

        return inum;
    }
//tổng số bình luận theo Người dùng

    public int countCommentByUser(int userId) {
        int inum = 0;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select count(commentId) from Comment where users.userId=:userId");
            query.setInteger("userId", userId);
            long count = (long) query.uniqueResult();
            inum = (int) count;
            session.getTransaction().commit();
        } catch (Exception e) {
        } finally {
            session.close();
        }

        return inum;
    }

    public int countCommentByTrue() {
        int inum = 0;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select count(commentId) from Comment where commentStatus=1");
            long count = (long) query.uniqueResult();
            inum = (int) count;
            session.getTransaction().commit();
        } catch (Exception e) {
        } finally {
            session.close();
        }

        return inum;
    }

    //tổng bình luận chưa duyệt
    public int countCommentByFalse() {
        int inum = 0;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select count(commentId) from Comment where commentStatus=0");
            long count = (long) query.uniqueResult();
            inum = (int) count;
            session.getTransaction().commit();
        } catch (Exception e) {
        } finally {
            session.close();
        }

        return inum;
    }

   
    
     public List<ProductGroup> top3Comment() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = "select new ogani.entityMore.ProductGroup(count(c.product.prodId),c.product) "
                    + "from Comment c "
                    + "group by c.product.prodId "
                    + "order by count(c.product.prodId) DESC";
        Query query = session.createQuery(sql);
        query.setMaxResults(3);
        List<ProductGroup> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

}
