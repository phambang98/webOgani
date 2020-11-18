/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import ogani.entity.Banner;
import ogani.model.BannerModel;
import ogani.upfile.UpFileBanner;
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
@RequestMapping(value = "adminBanner")
public class AdminBanner {

    private BannerModel bannerModel;

    public AdminBanner() {
        bannerModel = new BannerModel();
    }

    @RequestMapping(value = "/View")
    public ModelAndView view() {
        ModelAndView mav = new ModelAndView("admin/banner");
        return mav;
    }

    @RequestMapping(value = "/dataBanner")
    public ModelAndView dataBlog(@RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "bannerId", required = false) Integer bannerId) {
        ModelAndView mav = new ModelAndView("admin/Ajax/dataBanner");
        if (bannerId != null) {
            boolean check = bannerModel.deleteBanner(bannerId);
        }
        List<Banner> lb = bannerModel.getAllBanner();
        PagedListHolder<Banner> pagedListProduct = new PagedListHolder<>(lb);
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
            mav.addObject("listBanner", pagedListProduct.getPageList());
        } else if (page <= pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(page - 1);
            mav.addObject("listBanner", pagedListProduct.getPageList());
        }
        mav.addObject("countBanner", bannerModel.countBanner());
        return mav;
    }

    @RequestMapping("initNew")
    public ModelAndView initNew() {
        ModelAndView mav = new ModelAndView("admin/Modal/bannerNew");
        mav.addObject("bannerNew", new Banner());
        return mav;
    }

    @RequestMapping(value = "new",method = RequestMethod.POST)
    public String New(HttpServletRequest request, Banner bannerNew,
            @RequestParam(value = "newImageLink", required = false) MultipartFile imageLink) {
        bannerNew.setImageLink(new UpFileBanner().saveImageToFolder(request, imageLink));
        boolean check = bannerModel.createBanner(bannerNew);
        return "redirect:View.htm";
    }

    @RequestMapping("initEdit")
    public ModelAndView initEdit(@RequestParam("bannerId") Integer bannerId) {
        ModelAndView mav = new ModelAndView("admin/Modal/bannerEdit");
        mav.addObject("bannerEdit", bannerModel.findBanner(bannerId));
        return mav;
    }

    @RequestMapping(value = "edit",method = RequestMethod.POST)
    public String Update(Banner bannerEdit, HttpServletRequest request,
            @RequestParam(value = "editImageLink", required = false) MultipartFile imageLink) {
        if (!imageLink.isEmpty()) {
            bannerEdit.setImageLink(new UpFileBanner().saveImageToFolder(request, imageLink));
        } else {
            Banner banner = bannerModel.findBanner(bannerEdit.getBannerId());
            bannerEdit.setImageLink(banner.getImageLink());
        }
        boolean check = bannerModel.updateBanner(bannerEdit);
        return "redirect:View.htm";
    }

}
