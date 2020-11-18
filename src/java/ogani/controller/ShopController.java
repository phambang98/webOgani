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
import ogani.entity.Categories;
import ogani.entity.Comment;
import ogani.entity.ImageProduct;
import ogani.entity.Product;
import ogani.entity.Star;
import ogani.entity.StarId;
import ogani.entity.Users;
import ogani.model.CategoriesModel;
import ogani.model.CommentModel;
import ogani.model.ImageProductModel;
import ogani.model.ProductModel;
import ogani.model.StarModel;
import ogani.model.UsersModel;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Bang-GoD
 */
@Controller
@RequestMapping(value = "/shop")
public class ShopController {

    private ProductModel productModel;
    private CategoriesModel categoriesModel;
    private ImageProductModel imageProductModel;
    private StarModel starModel;
    private CommentModel commentModel;
    private UsersModel usersModel;

    public ShopController() {
        productModel = new ProductModel();
        categoriesModel = new CategoriesModel();
        imageProductModel = new ImageProductModel();
        usersModel = new UsersModel();
        starModel = new StarModel();
        commentModel = new CommentModel();

    }

    @RequestMapping(value = "/getAll")
    public ModelAndView index(@RequestParam(required = false) Integer page, HttpServletRequest request, HttpSession session) {
        ModelAndView mav = new ModelAndView("user/shop");
        List<Categories> listCate = categoriesModel.getAllCateTrue();
        mav.addObject("listCate", listCate);
        //truyền 1 cateId
        mav.addObject("cateIdPage", 0);
        session.setAttribute("requestURL", request.getServletPath());
        //giảm giá
        List<Product> listDiscount = productModel.listDiscount();
        Collections.shuffle(listDiscount, new Random());
        mav.addObject("listDiscount", listDiscount);
        return mav;
    }

    @RequestMapping("ajaxShop")
    public ModelAndView saleOf(@RequestParam(required = false) Integer page,
            @RequestParam(value = "cateId", required = false) Integer cateId,
            @RequestParam(value = "search", defaultValue = "") String search,
            @RequestParam(value = "sortPrice", defaultValue = "") String sortPrice,
            @RequestParam(value = "sortDiscount", defaultValue = "") String sortDiscount) {
        ModelAndView mav = new ModelAndView("user/shopAll");
        List<Product> lp = null;
        if (cateId == null || cateId == 0) {
            lp = productModel.shopAjaxNotCate(search, sortPrice, sortDiscount);
        } else {
            Categories categories = categoriesModel.findCate(cateId);
            lp = productModel.shopAjaxCate(cateId, search, sortPrice, sortDiscount);
            mav.addObject("rsCateName", categories.getCateName());
        }

        //tìm được product
        mav.addObject("countproduct", lp.size());
        mav.addObject("idsearch", search);
        mav.addObject("sortPrice", sortPrice);
        mav.addObject("cateIdPage", cateId);
        mav.addObject("sortDiscount", sortDiscount);
        //phân trang
        PagedListHolder<Product> pagedListProduct = new PagedListHolder<>(lp);
        pagedListProduct.setPageSize(6);
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
    public ModelAndView Details(@RequestParam(value = "prodId") int prodId, HttpSession session, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("user/shopDetails");
        session.setAttribute("requestURL", request.getServletPath() + "?" + request.getQueryString());
        Product product = productModel.findProduct(prodId);
        List<ImageProduct> listImage = imageProductModel.getImageByProduct(product);
        mav.addObject("listImage", listImage);
        mav.addObject("product", product);
        Users users = (Users) session.getAttribute("users");
        //tính trung bình
        float avg = starModel.starAVG(prodId);
        mav.addObject("avg", avg);
        Star star = null;
        if (users != null) {
            star = starModel.findStar(product, users);
            mav.addObject("star", star);
        }
        return mav;
    }

    @RequestMapping(value = "rate")
    public @ResponseBody
    ModelAndView rate(int rateSubmit, int prodId, HttpSession session) {
        Users users = (Users) session.getAttribute("users");
        String thongbao = null;
        Product product = productModel.findProduct(prodId);
        StarId starId = new StarId(prodId, users.getUserId());
        Star star = new Star(starId, product, users, rateSubmit);
        boolean check = starModel.insertStar(star);
        ModelAndView mav = new ModelAndView();
        if (check == true) {
            float avg = starModel.starAVG(prodId);
            mav.setViewName("user/Ajax/resultStar");
            mav.addObject("product", product);
            mav.addObject("avg", avg);
            mav.addObject("star", star);
        } else {
            mav.setViewName("user/Ajax/error");
        }
        return mav;
    }

    @RequestMapping(value = "deleteRate")
    public @ResponseBody
    ModelAndView deleteRate(int prodId, HttpSession session) {
        String thongbao = null;
        Users users = (Users) session.getAttribute("users");
        Product product = productModel.findProduct(prodId);
        Star star = starModel.findStar(product, users);
        boolean check = starModel.deleteStar(product, users);
        ModelAndView mav = new ModelAndView();
        if (check == true) {
            float avg = starModel.starAVG(prodId);
            mav.setViewName("user/Ajax/resultStar");
            mav.addObject("product", product);
            mav.addObject("avg", avg);
        } else {
            mav.setViewName("user/Ajax/error");
        }
        return mav;
    }

    @RequestMapping(value = "loadAllComment")
    public ModelAndView loadAllComment(@RequestParam(value = "prodId") Integer prodId) {
        ModelAndView mav = new ModelAndView("user/Ajax/allComment");
        List<Comment> listComment = commentModel.findListCommentByProduct(prodId);
        List<Comment> listRepComment = commentModel.findListRepCommentByProduct(prodId);
        mav.addObject("listRepComment", listRepComment);
        mav.addObject("listComment", listComment);
        return mav;
    }

    @RequestMapping(value = "createComment")
    public String createComment(Model model, int prodId, int parentId, String content, HttpSession session) {
        Users users = (Users) session.getAttribute("users");
        Product product = productModel.findProduct(prodId);
        Comment comment = new Comment(product, users, parentId, false, content);
        boolean check = commentModel.createComment(comment);
        List<Comment> listComment = commentModel.findListCommentByProduct(prodId);
        List<Comment> listRepComment = commentModel.findListRepCommentByProduct(prodId);
        model.addAttribute("listRepComment", listRepComment);
        model.addAttribute("listComment", listComment);
        return "user/Ajax/allComment";
    }

    @RequestMapping(value = "deleteComment")
    public String deleteComment(Model model,int commentId,int prodId, HttpSession session) {
        boolean check = commentModel.deleteComment(commentId);
        List<Comment> listComment = commentModel.findListCommentByProduct(prodId);
        List<Comment> listRepComment = commentModel.findListRepCommentByProduct(prodId);
        model.addAttribute("listRepComment", listRepComment);
        model.addAttribute("listComment", listComment);
        return "user/Ajax/allComment";
    }

    @RequestMapping(value = "initEditComment")
    public ModelAndView initEditComment(int commentId) {
        ModelAndView mav = new ModelAndView("user/Ajax/editComment");
        Comment comment = commentModel.findByCommentId(commentId);
        mav.addObject("comment", comment);
        return mav;
    }

    @RequestMapping(value = "editComment")
    public String editComment(Model model,int prodId, int commentId, int parentId, String content, HttpSession session) {
        ModelAndView mav = new ModelAndView("user/Ajax/allComment");
        Users users = (Users) session.getAttribute("users");
        Product product = productModel.findProduct(prodId);
        Comment comment = new Comment(commentId, product, users, parentId, true, content);
        boolean check = commentModel.updateComment(comment);
        List<Comment> listComment = commentModel.findListCommentByProduct(prodId);
        List<Comment> listRepComment = commentModel.findListRepCommentByProduct(prodId);
        model.addAttribute("listRepComment", listRepComment);
        model.addAttribute("listComment", listComment);
        return "user/Ajax/allComment";
    }

    @RequestMapping("repComment")
    public @ResponseBody
    String RepComment(int commentId) {

        Comment comment = commentModel.findByCommentId(commentId);
        String jsonInString = "Bạn Đang Rep Comment của :<span style='color:red'>"
                + comment.getUsers().getUserName() + "</span>.Với nội dung :<span style='color:red'>"
                + comment.getContent() + "</span>";
        return jsonInString;

    }

}
