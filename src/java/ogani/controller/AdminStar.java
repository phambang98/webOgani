/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;


import java.util.List;
import ogani.entityMore.ProductGroup;

import ogani.model.ProductModel;
import ogani.model.StarModel;
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
@RequestMapping(value = "/adminStar")
public class AdminStar {

    private StarModel starModel;

    public AdminStar() {
        starModel = new StarModel();

    }
    private ProductModel productModel = new ProductModel();

    @RequestMapping(value = "/View")
    public ModelAndView view() {
        ModelAndView mav = new ModelAndView("admin/star");
        mav.addObject("Top1Star", starModel.top1Star());
        return mav;
    }

    @RequestMapping(value = "topProduct")
    public ModelAndView topProduct(@RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "search", defaultValue = "") String search,
            @RequestParam(value = "sort", defaultValue = "") String sort,
            @RequestParam(value = "name", defaultValue = "") String name) {

        ModelAndView mav = new ModelAndView("admin/Ajax/starProduct");
        List<ProductGroup> list = starModel.productGroups(search, name, sort);
        PagedListHolder<ProductGroup> pageList = new PagedListHolder<>(list);
        pageList.setPageSize(4);
        mav.addObject("maxPages", pageList.getPageCount());
        if (page == null || page < 1) {
            page = 1;
        } else if (page > pageList.getPageCount()) {
            page = pageList.getPageCount();
        }
        mav.addObject("page", page);
        if (page == null || page < 1 || page > pageList.getPageCount()) {
            pageList.setPage(0);
            mav.addObject("pageList", pageList.getPageList());
        } else if (page <= pageList.getPageCount()) {
            pageList.setPage(page - 1);
            mav.addObject("pageList", pageList.getPageList());
        }
        mav.addObject("sort", sort);
        mav.addObject("search", search);
        mav.addObject("name", name);
        return mav;
    }

}
