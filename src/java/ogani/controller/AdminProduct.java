/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import ogani.entity.Product;
import ogani.model.CategoriesModel;
import ogani.model.ImageProductModel;
import ogani.model.ProductModel;
import ogani.upfile.UpFileProduct;
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
@RequestMapping(value = "/adminProduct")
public class AdminProduct {

    private ProductModel productModel;
    private CategoriesModel categoriesModel;
    private ImageProductModel imageProductModel;

    public AdminProduct() {
        productModel = new ProductModel();
        categoriesModel = new CategoriesModel();
        imageProductModel = new ImageProductModel();
    }

    @RequestMapping(value = "/View")
    public ModelAndView index() {
        ModelAndView mav = new ModelAndView("admin/product");

        return mav;
    }

    @RequestMapping(value = "/dataProduct")
    public ModelAndView dataBlog(@RequestParam(value = "pageProduct", required = false) Integer pageProduct,
            @RequestParam(value = "search", defaultValue = "") String search,
            @RequestParam(value = "sort", defaultValue = "") String sort,
            @RequestParam(value = "name", defaultValue = "") String name,
            @RequestParam(value = "prodId", required = false) Integer prodId) {
        ModelAndView mav = new ModelAndView("admin/Ajax/dataProduct");
//        if (prodId != null) {
//            boolean check = productModel.deleteProduct(prodId);
//        }
        List<Product> lb = productModel.adminAllProduct(search, name, sort);
        PagedListHolder<Product> pagedListProduct = new PagedListHolder<>(lb);
        pagedListProduct.setPageSize(3);
        mav.addObject("maxPagesProduct", pagedListProduct.getPageCount());
        if (pageProduct == null || pageProduct < 1) {
            pageProduct = 1;
        } else if (pageProduct > pagedListProduct.getPageCount()) {
            pageProduct = pagedListProduct.getPageCount();
        }
        mav.addObject("pageProduct", pageProduct);
        if (pageProduct == null || pageProduct < 1 || pageProduct > pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(0);
            mav.addObject("listProduct", pagedListProduct.getPageList());
        } else if (pageProduct <= pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(pageProduct - 1);
            mav.addObject("listProduct", pagedListProduct.getPageList());
        }
        mav.addObject("sortProduct", sort);
        mav.addObject("nameProduct", name);
        mav.addObject("searchProduct", search);
        mav.addObject("countProduct", productModel.count());

        return mav;
    }

    @RequestMapping("initNew")
    public ModelAndView initNew() {
        ModelAndView mav = new ModelAndView("admin/Modal/productNew");
        Product productNew = new Product();
        mav.addObject("productNew", productNew);
        mav.addObject("listCate", categoriesModel.getAllCateTrue());
        return mav;
    }

    @RequestMapping(value = "/new", method = RequestMethod.POST)
    public String New(@RequestParam(value = "newImageLink", required = false) MultipartFile imageLink,
            Product productNew,
            @RequestParam(value = "newImageOther") MultipartFile[] imageOther,
            HttpServletRequest request) throws IOException {
        Date date = new Date();
        productNew.setCreated(date);
        productNew.setImageLink(new UpFileProduct().saveImageToFolder(request, imageLink));
         boolean check=false;
        if (imageOther.length == 1) {
            for (MultipartFile multipartFile : imageOther) {
                if (multipartFile.isEmpty()) {
                     check = productModel.createProductNotMutil(productNew);
                } else {
                     check = productModel.createProduct(productNew, imageOther, request);
                }
            }
        } else {
             check = productModel.createProduct(productNew, imageOther, request);
        }
        if (check == true) {
            return "redirect:View.htm";
        } else {
            return "admin/error";
        }

    }

    @RequestMapping("initEdit")
    public ModelAndView initEdit(@RequestParam("prodId") Integer prodId) {
        ModelAndView mav = new ModelAndView("admin/Modal/productEdit");
        mav.addObject("productEdit", productModel.findProduct(prodId));
        mav.addObject("listImage", imageProductModel.getImageByProduct(productModel.findProduct(prodId)));
        mav.addObject("listCate", categoriesModel.getAllCateTrue());
        return mav;
    }

    @RequestMapping(value = "edit", method = RequestMethod.POST)
    public String edit(Product productEdit, @RequestParam(value = "editImageLink", required = false) MultipartFile imageLink,
            @RequestParam(value = "editImageOther", required = false) MultipartFile[] imageOther,
            HttpServletRequest request) {
        //lấy ra product
        Product product = productModel.findProduct(productEdit.getProdId());
        Date date = new Date();
        productEdit.setCreated(date);
        if (!imageLink.isEmpty()) {
            productEdit.setImageLink(new UpFileProduct().saveImageToFolder(request, imageLink));
        } else {
            //set ảnh nếu imageLink null
            productEdit.setImageLink(product.getImageLink());
        }
        //nếu mutil =null. thì ko thay đổi cái image
        if (imageOther.length == 1) {
            for (MultipartFile multipartFile : imageOther) {
                if (multipartFile.isEmpty()) {
                    boolean check = productModel.updateProductNotMutil(productEdit);
                } else {
                    boolean check = productModel.updateProduct(productEdit, imageOther, request);
                }
            }
        } else {
            boolean check = productModel.updateProduct(productEdit, imageOther, request);
        }
        return "redirect:View.htm";
    }

}
