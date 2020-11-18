/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import java.util.List;
import ogani.entity.Categories;
import ogani.model.CategoriesModel;
import ogani.model.ProductModel;
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
@RequestMapping(value = "/adminCategories")
public class AdminCategories {

    private CategoriesModel categoriesModel;
    private ProductModel productModel;

    public AdminCategories() {
        categoriesModel = new CategoriesModel();
        productModel = new ProductModel();
    }

    @RequestMapping(value = "/index")
    public ModelAndView index() {
        ModelAndView mav = new ModelAndView("admin/categories");

        return mav;
    }
    @RequestMapping(value = "/dataCategories")
    public ModelAndView dataBlog(@RequestParam(value = "pageCate", required = false) Integer pageCate,
            @RequestParam(value = "search",defaultValue = "") String search,
            @RequestParam(value = "sort", defaultValue = "") String sort,
            @RequestParam(value = "cateId", required = false) Integer cateId) {
        ModelAndView mav = new ModelAndView("admin/Ajax/dataCategories");
        if (cateId != null) {
            boolean check = categoriesModel.deleteCate(cateId);
        }
       
        List<Categories> lb = categoriesModel.getBySearch(search, sort);
        PagedListHolder<Categories> pagedListCate = new PagedListHolder<>(lb);
        pagedListCate.setPageSize(3);
        mav.addObject("maxPagesCate", pagedListCate.getPageCount());
        if (pageCate == null || pageCate < 1) {
            pageCate = 1;
        } else if (pageCate > pagedListCate.getPageCount()) {
            pageCate = pagedListCate.getPageCount();
        }
        mav.addObject("pageCate", pageCate);
        if (pageCate == null || pageCate < 1 || pageCate > pagedListCate.getPageCount()) {
            pagedListCate.setPage(0);
            mav.addObject("listCate", pagedListCate.getPageList());
        } else if (pageCate <= pagedListCate.getPageCount()) {
            pagedListCate.setPage(pageCate - 1);
            mav.addObject("listCate", pagedListCate.getPageList());
        }
        mav.addObject("sortCate", sort);
        mav.addObject("searchCate", search);
        mav.addObject("countCate", categoriesModel.countCate());

        return mav;
    }

    @RequestMapping("initNew")
    public ModelAndView initNew() {
        ModelAndView mav = new ModelAndView("admin/Modal/cateNew");
        return mav;
    }
    
    @RequestMapping(value = "new",method = RequestMethod.POST)
    public String New(@RequestParam(value = "cateName", required = false) String cateName,
            @RequestParam(value = "cateTitle", required = false) String cateTitle,
            @RequestParam(value = "prioritys", required = false) Integer prioritys,
            @RequestParam(value = "cateStatus", required = false) Boolean cateStatus) {
        Categories categories=new Categories();
        categories.setCateName(cateName);
        categories.setCateStatus(cateStatus);
        categories.setCateTitle(cateTitle);
        categories.setPrioritys(prioritys);
        boolean check=categoriesModel.createCate(categories);
        return "redirect:index.htm";
    }
    
    @RequestMapping("initEdit")
    public ModelAndView initEdit(@RequestParam("cateId") Integer cateId) {
        ModelAndView mav = new ModelAndView("admin/Modal/cateEdit");
        mav.addObject("cateEdit", categoriesModel.findCate(cateId));
        return mav;
    }
    
    @RequestMapping(value = "edit",method = RequestMethod.POST)
    public String edit(Categories cateEdit){
        boolean check=categoriesModel.updateCate(cateEdit);
        return "redirect:index.htm";
    }
    
    @RequestMapping("loadCount")
    public @ResponseBody String  loadCount(@RequestParam("cateId")Integer cateId){ 
       int count=productModel.countProductByCate(cateId);
        
       String s=String.valueOf(count);  
        return  s;
    }

}
