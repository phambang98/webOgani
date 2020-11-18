/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import java.util.List;

import ogani.entity.Users;
import ogani.entityMore.UserGroup;
import ogani.model.CommentModel;
import ogani.model.OrderModel;
import ogani.model.StarModel;
import ogani.model.UsersModel;
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
@RequestMapping(value = "adminUsers")
public class AdminUsers {

    private UsersModel usersModel;
    private CommentModel commentModel;
    private StarModel starModel;
    private OrderModel orderModel;

    public AdminUsers() {
        usersModel = new UsersModel();
        commentModel = new CommentModel();
        starModel = new StarModel();
        orderModel = new OrderModel();
    }

    @RequestMapping(value = "/View")
    public ModelAndView index() {
        ModelAndView mav = new ModelAndView("admin/users");

        return mav;
    }

    @RequestMapping(value = "/dataUsers")
    public ModelAndView dataBlog(@RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "search", defaultValue = "", required = false) String search,
            @RequestParam(value = "name", defaultValue = "", required = false) String name,
            @RequestParam(value = "sort", defaultValue = "", required = false) String sort,
            @RequestParam(value = "userId", required = false) Integer userId,
            @RequestParam(value = "userStatus", required = false) Boolean userStatus) {
        ModelAndView mav = new ModelAndView("admin/Ajax/dataUsers");

        if (userId != null && userStatus == null) {
            boolean check = usersModel.DeleteUsers(userId);
        } else if (userId != null && userStatus != null) {
            Users users = usersModel.findUsers(userId);
            users.setUserStatus(userStatus);
            boolean check = usersModel.updateUsers(users);
        }
        List<UserGroup> lb = usersModel.allUsersGroup(search, name, sort);
        PagedListHolder<UserGroup> pagedListUsers = new PagedListHolder<>(lb);
        pagedListUsers.setPageSize(3);
        mav.addObject("maxPages", pagedListUsers.getPageCount());
        if (page == null || page < 1) {
            page = 1;
        } else if (page > pagedListUsers.getPageCount()) {
            page = pagedListUsers.getPageCount();
        }
        mav.addObject("page", page);
        if (page == null || page < 1) {
            pagedListUsers.setPage(0);
            mav.addObject("list", pagedListUsers.getPageList());
        } else if (page > pagedListUsers.getPageCount()) {
            page = pagedListUsers.getPageCount();
        } else if (page <= pagedListUsers.getPageCount()) {
            pagedListUsers.setPage(page - 1);
            mav.addObject("list", pagedListUsers.getPageList());
        }
        mav.addObject("search", search);
        mav.addObject("sort", sort);
        mav.addObject("name", name);
        mav.addObject("count", usersModel.countUsers());

        return mav;
    }

}
