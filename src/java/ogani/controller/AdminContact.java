/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import ogani.entity.Contact;
import ogani.model.ContactModel;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Bang-GoD
 */
@Controller
@RequestMapping(value = "/adminContact")
public class AdminContact {

    private ContactModel contactModel;

    public AdminContact() {
        contactModel = new ContactModel();
    }

    @RequestMapping(value = "/View")
    public ModelAndView view(@RequestParam(value = "page", required = false) Integer page) {
        ModelAndView mav = new ModelAndView("admin/contact");
        PagedListHolder<Contact> pagedListProduct = new PagedListHolder<>(contactModel.getAllContact());
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
            mav.addObject("listContact", pagedListProduct.getPageList());
        } else if (page <= pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(page - 1);
            mav.addObject("listContact", pagedListProduct.getPageList());
        }

        mav.addObject("contact", new Contact());
        return mav;
    }

    @RequestMapping("initNew")
    public ModelAndView initNew() {
        ModelAndView mav = new ModelAndView("admin/Modal/contactNew");
        Contact contact = new Contact();
        mav.addObject("contactNew", contact);
        return mav;
    }

    @RequestMapping(value = "new",method = RequestMethod.POST)
    public String New(Contact contactNew) {
        boolean check = contactModel.createContact(contactNew);
        return "redirect:View.htm";
    }

    @RequestMapping("delete")
    public String detele(@RequestParam(value = "id") Integer id) {
        boolean check = contactModel.deleteContact(id);
        return "redirect:View.htm";
    }

    @RequestMapping("initEdit")
    public ModelAndView initEdit(@RequestParam("id")Integer id) {
        ModelAndView mav = new ModelAndView("admin/Modal/contactEdit");
        mav.addObject("contactEdit",contactModel.findContact(id) );
        return mav;
    }

    @RequestMapping(value = "edit",method = RequestMethod.POST)
    public String Update(Contact contactEdit){
        boolean check=contactModel.updateContact(contactEdit);
        return "redirect:View.htm";
    }


}
