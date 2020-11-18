/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import com.google.gson.Gson;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import ogani.entity.Categories;
import ogani.entity.Product;
import ogani.model.BannerModel;
import ogani.model.CategoriesModel;
import ogani.model.CommentModel;
import ogani.model.ContactModel;
import ogani.model.OrderDetailModel;
import ogani.model.ProductModel;
import ogani.model.StarModel;
import ogani.model.UsersModel;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Bang-GoD
 */
@Controller
@RequestMapping(value = "/home")
public class Home {

    private ProductModel productModel;
    private CategoriesModel categoriesModel;
    private BannerModel bannerModel;
    private UsersModel usersModel;
    private StarModel starModel;
    private OrderDetailModel orderDetailModel;
    private CommentModel commentModel;
    private ContactModel contactModel;

    public Home() {
        productModel = new ProductModel();
        categoriesModel = new CategoriesModel();
        bannerModel = new BannerModel();
        usersModel = new UsersModel();
        starModel = new StarModel();
        orderDetailModel = new OrderDetailModel();
        commentModel = new CommentModel();
        contactModel = new ContactModel();
    }

    @RequestMapping(value = "/index")
    public ModelAndView index(@RequestParam(required = false) Integer page, HttpSession session, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("user/index");
        session.setAttribute("requestURL", request.getServletPath());
        //danh mục
        mav.addObject("listCate", categoriesModel.getAllCateTrue());
        //banner
        mav.addObject("listBanner", bannerModel.getAllBannerTrue());
        List<Product> listProduct = productModel.getAllProductByCateTrue();
        //random
        List<Product> listRandom = productModel.getAllProductByCateTrue();
        Collections.shuffle(listRandom, new Random());
        mav.addObject("listRandom", listRandom);
        //top 3 bình luận
        mav.addObject("Top3Cmt", commentModel.top3Comment());
        // top 3 đánh gia
        mav.addObject("Top3Star", starModel.top3Star());
        //Top 3 Buy
        mav.addObject("Top3Buy", orderDetailModel.Top3Product());
        //footer
        session.setAttribute("listContact", contactModel.getAllContact());

        //phan trang
        PagedListHolder<Product> pagedListProduct = new PagedListHolder<>(listProduct);
        pagedListProduct.setPageSize(4);
        mav.addObject("maxPages", pagedListProduct.getPageCount());
        if (page == null || page < 1 || page > pagedListProduct.getPageCount()) {
            page = 1;
        }
        mav.addObject("page", page);
        if (page == null || page < 1 || page > pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(0);
            mav.addObject("lp", pagedListProduct.getPageList());
        } else if (page <= pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(page - 1);
            mav.addObject("lp", pagedListProduct.getPageList());
        }
        return mav;
    }

    @RequestMapping(value = "/ajaxGetAllProduct", method = RequestMethod.POST)
    public ModelAndView ajaxGetAllProduct(@RequestParam(required = false) Integer page, Integer cateId) {
        ModelAndView mav = new ModelAndView("user/getallproduct");
        //truyền vào 1 CateId
        mav.addObject("pageCateId", cateId);
        //lấy ra categoris
        Categories categories = categoriesModel.findCate(cateId);
        //lấy List Product theo categories
        List<Product> lp = productModel.getByCategories(categories);
        //phân trang
        PagedListHolder<Product> pagedListProduct = new PagedListHolder<>(lp);
        pagedListProduct.setPageSize(4);
        mav.addObject("maxPages", pagedListProduct.getPageCount());
        if (page == null || page < 1 || page > pagedListProduct.getPageCount()) {
            page = 1;
        }
        mav.addObject("page", page);
        if (page == null || page < 1 || page > pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(0);
            mav.addObject("lp", pagedListProduct.getPageList());
        } else if (page <= pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(page - 1);
            mav.addObject("lp", pagedListProduct.getPageList());
        }
        return mav;
    }

//    @RequestMapping(value = "autocomplete")
//    public @ResponseBody String autocomplete(@RequestParam(value = "search") String search) {
//        List<String> autocomplete = productModel.autocomplete(search);
//        String json = new Gson().toJson(autocomplete );
//        return json;
//    }

}
