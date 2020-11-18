/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.model;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import ogani.entity.Categories;
import ogani.entity.ImageProduct;
import ogani.entity.Product;
import ogani.upfile.UpFileMutil;
import ogani.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Bang-GoD
 */
public class ProductModel {

    public List<Product> getAllProductByCateTrue() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Product where categories.cateStatus=1");
        List<Product> listCate = query.list();
        session.getTransaction().commit();
        session.close();
        return listCate;
    }

    public Product findProduct(int prodId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Product where prodId=:prodId");
        query.setInteger("prodId", prodId);
        Product product = (Product) query.uniqueResult();
        session.getTransaction().commit();
        session.close();
        return product;
    }

    public boolean createProduct(Product productNew, MultipartFile[] imageOther, HttpServletRequest request) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.save(productNew);
            //save anh cua product
            for (MultipartFile multipartFile : imageOther) {
                ImageProduct imageProduct = new ImageProduct();
                imageProduct.setProduct(productNew);
                imageProduct.setImageLink(new UpFileMutil().saveImageToFolder(request, multipartFile));
                session.save(imageProduct);
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
     public boolean createProductNotMutil(Product productNew) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.save(productNew);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }

    public boolean updateProduct(Product product, MultipartFile[] imageOther, HttpServletRequest request) {
        Session session = null;
        boolean check = false;
        ImageProductModel ipm = new ImageProductModel();

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.merge(product);
            for (ImageProduct imageProduct : ipm.getImageByProduct(product)) {
                ipm.deleteImageProduct(imageProduct);
            }
            for (MultipartFile multipartFile : imageOther) {
                ImageProduct imageProduct = new ImageProduct();
                imageProduct.setProduct(product);
                imageProduct.setImageLink(new UpFileMutil().saveImageToFolder(request, multipartFile));
                session.save(imageProduct);
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

    public boolean updateProductNotMutil(Product product) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            session.merge(product);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }

    public boolean deleteProduct(int prodId) {
        Session session = null;
        boolean check = false;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Product product = findProduct(prodId);
            session.delete(product);
            check = true;
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return check;
    }

    //tìm kiếm list product theo cate
    public List<Product> getByCategories(Categories categories) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Product where categories.cateStatus=1 and categories=:categories");
        query.setEntity("categories", categories);
        List<Product> lp = query.list();
        session.getTransaction().commit();
        session.close();
        return lp;
    }

    public Long count() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("select count(*) from Product");
        Long count = (Long) query.uniqueResult();
        session.getTransaction().commit();
        session.close();
        return count;
    }

    //tổng sản phẩm giảm giá
    public Long discount() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("select count(*) from Product where discount>0");
        Long count = (Long) query.uniqueResult();
        session.getTransaction().commit();
        session.close();
        return count;
    }

    //list sản phẩm giảm giá
    public List<Product> listDiscount() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Product p where p.discount >0");
        List<Product> listDiscount = query.list();
        session.getTransaction().commit();
        session.close();
        return listDiscount;
    }

    public List<Product> listDiscountByCate(Categories categories) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        Query query = session.createQuery("from Product where categories=:categories and discount>0");
        query.setEntity("categories", categories);
        List<Product> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

//    public List<String> autocomplete(String search) {
//        Session session = HibernateUtil.getSessionFactory().openSession();
//        session.getTransaction().begin();
//        Query query = session.createQuery("select p.prodName from Product p where p.categories.cateStatus=1 "
//                + "and p.prodName like concat('%',:search,'%') ");
//        query.setString("search", search);
//        List<String> list = query.list();
//        session.getTransaction().commit();
//        session.close();
//        return list;
//    }

    public int countProductByCate(int cateId) {
        Session session = null;
        int count = 0;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.getTransaction().begin();
            Query query = session.createQuery("select count(prodId) from Product where categories.cateId=:cateId");
            query.setInteger("cateId", cateId);
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

    public List<Product> getBySearch(String search, String sort) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = null;
        if (sort.equals("")) {
            sql = "from Product where prodName like concat('%',:search,'%')";
        } else {
            sql = "from Product where prodName like concat('%',:search,'%') "
                    + "order by price " + sort + "";
        }
        Query query = session.createQuery(sql);
        query.setString("search", search);
        List<Product> lp = query.list();
        session.getTransaction().commit();
        session.close();
        return lp;
    }

    public List<Product> adminAllProduct(String search, String name, String sort) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = null;
        if (sort.equals("") || name.equals("")) {
            sql = "from Product  "
                    + "where prodName like concat('%',:search,'%') ";
        } else {
            sql = "from Product  "
                    + "where prodName like concat('%',:search,'%') "
                    + "order by " + name + " " + sort + "";
        }
        Query query = session.createQuery(sql);
        query.setString("search", search);
        List<Product> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public List<Product> shopAjaxNotCate(String search, String sort, String sortDiscount) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = null;
        if (sort.equals("") && sortDiscount.equals("")) {
            sql = "from Product  "
                    + "where prodName like concat('%',:search,'%') "
                    + "and categories.cateStatus=1";
        } else if (sort.equals("") && !sortDiscount.equals("")) {
            sql = "from Product  "
                    + "where prodName like concat('%',:search,'%') "
                    + "and categories.cateStatus=1 "
                    + "and discount" + sortDiscount + " "
                    + "order by price " + sort + "";
        } else if (!sort.equals("") && sortDiscount.equals("")) {
            sql = "from Product  "
                    + "where prodName like concat('%',:search,'%') "
                    + "and categories.cateStatus=1 "
                    + "order by price " + sort + "";
        } else if (!sort.equals("") && !sortDiscount.equals("")) {
            sql = "from Product  "
                    + "where prodName like concat('%',:search,'%') "
                    + "and categories.cateStatus=1 "
                    + "and discount" + sortDiscount + " "
                    + "order by price " + sort + "";
        }
        Query query = session.createQuery(sql);
        query.setString("search", search);
        List<Product> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

    public List<Product> shopAjaxCate(Integer cateId, String search, String sort, String sortDiscount) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction().begin();
        String sql = null;
        if (sort.equals("") && sortDiscount.equals("")) {
            sql = "from Product  "
                    + "where prodName like concat('%',:search,'%') "
                    + "and categories.cateId=:cateId and categories.cateStatus=1";
        } else if (sort.equals("") && !sortDiscount.equals("")) {
            sql = "from Product  "
                    + "where prodName like concat('%',:search,'%') "
                    + "and categories.cateId=:cateId and categories.cateStatus=1 "
                    + "and discount" + sortDiscount + " "
                    + "order by price " + sort + "";
        } else if (!sort.equals("") && sortDiscount.equals("")) {
            sql = "from Product  "
                    + "where prodName like concat('%',:search,'%') "
                    + "and categories.cateId=:cateId and categories.cateStatus=1 "
                    + "order by price " + sort + "";
        } else if (!sort.equals("") && !sortDiscount.equals("")) {
            sql = "from Product  "
                    + "where prodName like concat('%',:search,'%') "
                    + "and categories.cateId=:cateId and categories.cateStatus=1 "
                    + "and discount" + sortDiscount + " "
                    + "order by price " + sort + "";
        }
        Query query = session.createQuery(sql);

        query.setString("search", search);
        query.setInteger("cateId", cateId);
        List<Product> list = query.list();
        session.getTransaction().commit();
        session.close();
        return list;
    }

}
