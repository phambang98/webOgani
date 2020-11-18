/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import ogani.entity.Categories;
import ogani.entity.Contact;
import ogani.model.CategoriesModel;
import ogani.model.ContactModel;
import ogani.util.EmailUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Bang-GoD
 */
@Controller
@RequestMapping(value = "/contact")
public class ContactController {

    private ContactModel contactModel;
    private CategoriesModel categoriesModel;

    public ContactController() {
        contactModel = new ContactModel();
        categoriesModel = new CategoriesModel();
    }

    @RequestMapping(value = "/index")
    public ModelAndView Contact(HttpServletRequest request, HttpSession session) {
        session.setAttribute("reuqestURL", request.getServletPath());
        ModelAndView mav = new ModelAndView("user/contact");
        List<Categories> listCate = categoriesModel.getAllCateTrue();
        mav.addObject("listCate", listCate);
        List<Contact> listContact = contactModel.getAllContact();
        mav.addObject("listContact", listContact);
        return mav;
    }

    @RequestMapping(value = "/sendEmail")
    public @ResponseBody
    String doSendEmail(String recipient, String subject, String message)
            throws MessagingException, UnsupportedEncodingException {

        EmailUtil.sendEmail(recipient, subject, message);
        String abc = "Gửi Thành Công";
        return abc;
    }

}
