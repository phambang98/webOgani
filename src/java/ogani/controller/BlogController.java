/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import java.util.Collections;
import java.util.List;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import ogani.entity.Blog;
import ogani.entity.Categories;
import ogani.model.BannerModel;
import ogani.model.BlogModel;
import ogani.model.CategoriesModel;
import ogani.model.ProductModel;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Bang-GoD
 */
@Controller
@RequestMapping(value = "/blog")
public class BlogController {

    private ProductModel productModel;
    private CategoriesModel categoriesModel;
    private BannerModel bannerModel;
    private BlogModel blogModel;

    public BlogController() {
        productModel = new ProductModel();
        categoriesModel = new CategoriesModel();
        bannerModel = new BannerModel();
        blogModel = new BlogModel();

    }

    @RequestMapping("/getAll")
    public ModelAndView allBlog(@RequestParam(required = false) Integer page, HttpServletRequest request, HttpSession session) {
        session.setAttribute("reuqestURL", request.getServletPath());
        ModelAndView mav = new ModelAndView("user/blog");
        mav.addObject("listCate",  categoriesModel.getAllCateTrue());
        mav.addObject("newTimeBlog", blogModel.newBlog());
        //random
        List<Blog> listRandom = blogModel.getAllBlogTrue();
        Collections.shuffle(listRandom, new Random());
        mav.addObject("listRandom", listRandom);
        List<Blog> listBlog = blogModel.getAllBlogTrue();
        //footer

        //phantrang
        PagedListHolder<Blog> pagedListProduct = new PagedListHolder<>(listBlog);
        pagedListProduct.setPageSize(2);
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

    @RequestMapping(value = "/details")
    public ModelAndView Details(@RequestParam(value = "blogId") int blogId,HttpServletRequest request,HttpSession session) {
        ModelAndView mav = new ModelAndView("user/blogdetails");
         session.setAttribute("requestURL", request.getServletPath()+"?"+request.getQueryString());
        mav.addObject("listCate", categoriesModel.getAllCateTrue());
        mav.addObject("blog", blogModel.findBlog(blogId));
        List<Blog> listRandom = blogModel.getAllBlogTrue();
        Collections.shuffle(listRandom, new Random());
        mav.addObject("listRandom", listRandom);
        mav.addObject("newTimeBlog", blogModel.newBlog());

        return mav;
    }
}
