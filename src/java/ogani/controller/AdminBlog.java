/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import ogani.entity.Blog;
import ogani.model.BlogModel;
import ogani.upfile.UpFlieBlog;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Bang-GoD
 */
@Controller
@RequestMapping(value = "/adminBlog")
public class AdminBlog {

    private BlogModel blogModel;

    public AdminBlog() {
        blogModel = new BlogModel();
    }

    @RequestMapping(value = "/View")
    public ModelAndView view() {
        ModelAndView mav = new ModelAndView("admin/blog");
        return mav;
    }

    @RequestMapping(value = "/dataBlog")
    public ModelAndView dataBlog(@RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "search", defaultValue = "") String search,
            @RequestParam(value = "sort", defaultValue = "") String sort,
            @RequestParam(value = "blogId", required = false) Integer blogId) {
        ModelAndView mav = new ModelAndView("admin/Ajax/dataBlog");
        if (blogId != null) {
            boolean check = blogModel.deleteBlog(blogId);
        }

        List<Blog> lb = blogModel.getBySearch(search, sort);
        PagedListHolder<Blog> pagedListProduct = new PagedListHolder<>(lb);
        pagedListProduct.setPageSize(2);
        mav.addObject("maxPages", pagedListProduct.getPageCount());
        if (page == null || page < 1) {
            page = 1;
        } else if (page > pagedListProduct.getPageCount()) {
            page = pagedListProduct.getPageCount();
        }
        mav.addObject("page", page);
        if (page == null || page < 1 || page > pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(0);
            mav.addObject("listBlog", pagedListProduct.getPageList());
        } else if (page <= pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(page - 1);
            mav.addObject("listBlog", pagedListProduct.getPageList());
        }
        mav.addObject("sortBlog", sort);
        mav.addObject("searchBlog", search);
        mav.addObject("countBlog", blogModel.countAllBlog());

        return mav;
    }

    @RequestMapping("initNew")
    public ModelAndView initNew() {
        ModelAndView mav = new ModelAndView("admin/Modal/blogNew");
        mav.addObject("blogNew", new Blog());
        return mav;
    }

    @RequestMapping(value = "new",method = RequestMethod.POST)
    public String New(HttpServletRequest request, Blog blogNew,
            @RequestParam(value = "newBlogImg", required = false) MultipartFile imageLink) {

        Date date = new Date();
        blogNew.setCreated(date);
        blogNew.setImageLink(new UpFlieBlog().saveImageToFolder(request, imageLink));
        boolean check = blogModel.createBlog(blogNew);
        return "redirect:View.htm";
    }

    @RequestMapping("initEdit")
    public ModelAndView initEdit(@RequestParam("blogId") Integer blogId) {
        ModelAndView mav = new ModelAndView("admin/Modal/blogEdit");
        mav.addObject("blogEdit", blogModel.findBlog(blogId));
        return mav;
    }

    @RequestMapping(value = "edit",method = RequestMethod.POST)
    public String Update(Blog blogEdit, HttpServletRequest request,
            @RequestParam(value = "editImageLink", required = false) MultipartFile imageLink) {
        Date date = new Date();
        blogEdit.setCreated(date);
        if (!imageLink.isEmpty()) {
            blogEdit.setImageLink(new UpFlieBlog().saveImageToFolder(request, imageLink));
        } else {
            Blog blog = blogModel.findBlog(blogEdit.getBlogId());
            blogEdit.setImageLink(blog.getImageLink());
        }
        boolean check = blogModel.updateBlog(blogEdit);
        return "redirect:View.htm";
    }

}
