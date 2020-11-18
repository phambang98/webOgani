/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import ogani.entity.Users;
import ogani.model.UsersModel;
import ogani.upfile.UpFileProfile;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Bang-GoD
 */
@Controller
@RequestMapping(value = "/users")
public class UserController {

    private UsersModel usersModel;

    public UserController() {
        usersModel = new UsersModel();
    }

    @RequestMapping("/profile")
    public ModelAndView profile(HttpSession session) {
        ModelAndView mav = new ModelAndView("user/profile");
        mav.addObject("users", session.getAttribute("users"));
        return mav;
    }

    @RequestMapping(value = "/checkUserName")
    public @ResponseBody
    String checkUserName(String userName) {
        boolean check = usersModel.checkUserName(userName);
        if (check == true) {

            return "<span style='color: red;'>Tên Tài Khoản Đã Tồn Tại</span>";
        } else {

            return "<span style='color: green;'>Được Sử Dụng</span>";
        }
    }

    @RequestMapping(value = "/changePassWord")
    public @ResponseBody
    String changePass(@RequestParam(value = "old") String old, @RequestParam(value = "news") String news,
            @RequestParam(value = "con") String con, HttpSession session) {
        String thongbao = "";

        Users users = (Users) session.getAttribute("users");
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
                        session.setAttribute("users", users);
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

    @RequestMapping(value = "/updateUser",method = RequestMethod.POST)
    public String updateUser(Users users, HttpServletRequest request, HttpSession session,
            @RequestParam(value = "image") MultipartFile image) {

        if (image.isEmpty()) {
            Users userNew = (Users) session.getAttribute("users");
            users.setUserImage(userNew.getUserImage());
        } else {
            users.setUserImage(new UpFileProfile().saveImageToFolder(request, image));
        }
        boolean check = usersModel.updateUsers(users);
        if (check == true) {
            session.setAttribute("users", users);
            return "redirect:profile.htm";
        } else {
            return "user/error";
        }
    }

    @RequestMapping("/initSignin")
    public ModelAndView initSignin() {
        ModelAndView mav = new ModelAndView("user/signin");
        Users users = new Users();
        mav.addObject("users", users);
        return mav;
    }

    @RequestMapping("/signin")
    public String signin(String userName, String passWords, HttpSession session, Model model) {

        boolean check = usersModel.checkUserName(userName);
        String requestURL = (String) session.getAttribute("requestURL");
        if (check == true) {
            Users users = usersModel.login(userName, passWords);
            if (users != null) {
                if (users.isUserStatus()== true) {
                    session.setAttribute("users", users);
                    if (requestURL == null) {

                        return "redirect:/home/index.htm";
                    } else {
                        return "redirect:" + requestURL;
                    }
                } else {
                    model.addAttribute("userName", userName);
                    model.addAttribute("thongbao", "Tài Khoản của Bạn Đã Bị Vô Hiệu Hóa");
                    return "user/signin";
                }
            } else {
                model.addAttribute("userName", userName);
                model.addAttribute("thongbao", "Mật Khâu Không Đúng");
                return "user/signin";
            }
        } else {
            model.addAttribute("userName", userName);
            model.addAttribute("thongbao", "Sai tên Đăng Nhập Hoặc Tài Khoản");
            return "user/signin";
        }

    }

    @RequestMapping("/initSignup")
    public ModelAndView initSignUp() {
        ModelAndView mav = new ModelAndView("user/signup");

        return mav;
    }

    @RequestMapping("/signup")
    public String signup(Users users, HttpSession session) {
        users.setIsAdmin(false);
        users.setUserStatus(true);
        boolean check = usersModel.createUsers(users);
        if (check == true) {
            session.setAttribute("users", users);
            return "redirect:/home/index.htm";
        } else {

            return "user/signup";
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/home/index.htm";
    }

}
