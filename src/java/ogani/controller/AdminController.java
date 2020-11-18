/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpSession;
import ogani.entity.Users;
import ogani.model.CommentModel;
import ogani.model.OrderModel;
import ogani.model.UsersModel;
import ogani.upfile.UpFileProfile;
import ogani.util.ChartAdmin;
import ogani.util.ChartAdmin1;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Bang-GoD
 */
@Controller
@RequestMapping(value = "/adminController")
public class AdminController {

    private UsersModel usersModel;
    private OrderModel orderModel;
    private CommentModel commentModel;

    public AdminController() {
        usersModel = new UsersModel();
        orderModel = new OrderModel();
        commentModel = new CommentModel();
    }

    @RequestMapping(value = "/View")
    public ModelAndView index() {
        ModelAndView mav = new ModelAndView("admin/index");
        ChartAdmin nc = new ChartAdmin();
        List<List<Map<Object, Object>>> canvasjsDataList = nc.getCanvasjsDataList();
        mav.addObject("dataPointsList", canvasjsDataList);

        ChartAdmin1 nc1 = new ChartAdmin1();
        List<List<Map<Object, Object>>> canvasjsDataList1 = nc1.getCanvasjsDataList();
        mav.addObject("dataPointsList1", canvasjsDataList1);
        return mav;
    }

    @RequestMapping(value = "initLogin")
    public String initLogin(HttpSession session, Model model) {

        if (session.getAttribute("admins") != null) {
            return "redirect:View.htm";
        } else {
            return "admin/login";
        }
    }

    @RequestMapping(value = "login")
    public String login(Model model, HttpSession session, HttpServletRequest request,
            @RequestParam(value = "name") String name, @RequestParam(value = "pass") String pass,
            @RequestParam(value = "capcha") String reCapcha) {
        Users users = usersModel.loginAdmin(name, pass);
        String capcha = (String) session.getAttribute("capcha");
        if (users != null) {
            if (users.isIsAdmin()== true) {
                if (reCapcha.equals(capcha)) {
                    session.setAttribute("admins", users);
                    return "redirect:View.htm";
                } else {
                      model.addAttribute("thongbao", "Mã CapCha Không Đúng");
                return "admin/login";
                }

            } else {
                model.addAttribute("thongbao", "Tài Khoản của Bạn Không Đủ Quyền");
                return "admin/login";
            }
        } else {
            model.addAttribute("thongbao", "Sai Tên Đăng Nhập Hoặc Mật Khẩu");
            return "admin/login";
        }

    }

    @RequestMapping(value = "exit")
    public String exit(HttpServletRequest request, HttpSession session) {

        session.removeAttribute("admins");
        session.invalidate();
        return "redirect:initLogin.htm";
    }

    @RequestMapping(value = "loadOrder")
    public ModelAndView loadOrder() {
        ModelAndView mav = new ModelAndView("admin/Ajax/menuOrder");
        mav.addObject("list", orderModel.top3OrderPending());
        mav.addObject("count", orderModel.countOrderPending());
        return mav;
    }

    @RequestMapping(value = "loadComment")
    public ModelAndView loadComment() {
        ModelAndView mav = new ModelAndView("admin/Ajax/menuComment");
        mav.addObject("list", commentModel.top3CommentFalse());
        mav.addObject("count", commentModel.countCommentByFalse());
        return mav;
    }

    @RequestMapping(value = "profile")
    public ModelAndView profile(HttpSession session) {
        ModelAndView mav = new ModelAndView("admin/profileAdmin");
        mav.addObject("admins", session.getAttribute("admins"));
        return mav;
       
    }

    @RequestMapping(value = "loadCapcha")
    public @ResponseBody
    String loadCapcha(HttpSession session) {
        String capcha = RandomStringUtils.randomAlphanumeric(4).toUpperCase();
        session.setAttribute("capcha", capcha);
        return capcha;
    }
    @RequestMapping(value = "/changePassWord")
    public @ResponseBody
    String changePass(@RequestParam(value = "old") String old, @RequestParam(value = "news") String news,
            @RequestParam(value = "con") String con, HttpSession session) {
        String thongbao = "";

        Users users = (Users) session.getAttribute("admins");
        if (users.getPassWords().equals(old)) {
            if (news.equals(con)) {
                if (news.length() < 3) {
                    thongbao = "Mật Khẩu Mới Phải Trên 3 Kí Tự";
                    return thongbao;
                }
                if (old.equals(news)) {
                    thongbao = "Mật Khẩu Mới Phải Khác Mật Khẩu Cũ";
                    return thongbao;
                } else {
                    users.setPassWords(news);
                    boolean check = usersModel.updateUsers(users);
                    if (check == true) {
                        thongbao = "Đổi Mật Khẩu Thành Công";
                        session.setAttribute("admins", users);
                        return thongbao;
                    } else {
                        thongbao = "Đổi Mật Khẩu Thất Bại";
                        return thongbao;
                    }
                }
            } else {
                thongbao = "Mật Khẩu Nhập Lại Không Chính Xác";
                return thongbao;
            }
        } else {
            thongbao = "Mật Khẩu Không Chính Xác";
            return thongbao;
        }
    }

    @RequestMapping(value = "/updateUser")
    public String updateUser(Users users, HttpServletRequest request, HttpSession session,
            @RequestParam(value = "image") MultipartFile image) {

        if (image.isEmpty()) {
            Users userNew = (Users) session.getAttribute("admins");
            users.setUserImage(userNew.getUserImage());
        } else {
            users.setUserImage(new UpFileProfile().saveImageToFolder(request, image));
        }
        boolean check = usersModel.updateUsers(users);
        if (check == true) {
            session.setAttribute("admins", users);
            return "redirect:profile.htm";
        } else {
            return "user/error";
        }
    }

}
