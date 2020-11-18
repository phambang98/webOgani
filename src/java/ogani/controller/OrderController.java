/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import java.util.ArrayList;
import java.util.Date;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import ogani.entity.Cart;
import ogani.entity.OrderDetail;
import ogani.entity.OrderDetailId;
import ogani.entity.Orders;
import ogani.entity.Users;
import ogani.model.OrderDetailModel;
import ogani.model.OrderModel;
import ogani.model.ProductModel;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Bang-GoD
 */
@Controller
@RequestMapping(value = "/orders")
public class OrderController {

    private OrderModel orderModel;
    private ProductModel productModel;
    private OrderDetailModel orderDetailModel;

    public OrderController() {
        orderModel = new OrderModel();
        productModel = new ProductModel();
        orderDetailModel = new OrderDetailModel();

    }

    @RequestMapping(value = "myOrder")
    public ModelAndView myOrder(HttpSession session, @RequestParam(required = false) Integer page, Model model) {
        ModelAndView mav = new ModelAndView("user/order");

        Users users = (Users) session.getAttribute("users");
        if (users == null) {
            ModelAndView view = new ModelAndView("user/error");
            return view;
        }
        List<Orders> listOrder = orderModel.findOrders(users.getUserId());
        if (listOrder == null) {
            return mav;
        }

        PagedListHolder<Orders> pagedListProduct = new PagedListHolder<>(listOrder);
        pagedListProduct.setPageSize(5);
        mav.addObject("maxPages", pagedListProduct.getPageCount());
        if (page == null || page < 1 || page > pagedListProduct.getPageCount()) {
            page = 1;
        }
        mav.addObject("page", page);
        if (page == null || page < 1 || page > pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(0);
            mav.addObject("listOrder", pagedListProduct.getPageList());
        } else if (page <= pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(page - 1);
            mav.addObject("listOrder", pagedListProduct.getPageList());
        }

        return mav;
    }

    @RequestMapping("/initCheckOut")
    public ModelAndView checkOut() {
        ModelAndView mav = new ModelAndView("user/checkout");
        Orders orders = new Orders();
        mav.addObject("orders", orders);

        return mav;
    }

    @RequestMapping("/checkOut")
    public String checkOut(HttpSession session, Orders orders, Model model, HttpServletRequest request) {

        Users users = (Users) session.getAttribute("users");
        List<Cart> listCart = (List<Cart>) session.getAttribute("listCart");
        if (users == null) {
            return "user/error";
        }
        Double tongtien = (Double) session.getAttribute("tongtien");
        Date date = new Date();
        orders.setCreated(date);
        orders.setOrderStatus("pending");
        orders.setTotalAmount(tongtien);
        boolean check = orderModel.createOrders(orders);
        List<OrderDetail> ods = new ArrayList<>();
        for (Cart cart : listCart) {
            double total = cart.getQuantity() * cart.getProduct().getPrice()
                    - cart.getQuantity() * cart.getProduct().getPrice() * cart.getProduct().getDiscount() / 100;
            OrderDetailId detailId = new OrderDetailId(orders.getOrderId(), cart.getProduct().getProdId());
            OrderDetail od = new OrderDetail(detailId, orders, cart.getProduct(), cart.getQuantity(), total, cart.getProduct().getDiscount());
            ods.add(od);
        }
        boolean listcheck = orderDetailModel.createOrderDetail(ods);
        if (check == true && listcheck == true) {
            listCart = null;
            tongtien = null;
            session.setAttribute("tongtien", tongtien);
            session.setAttribute("listCart", listCart);
            return "redirect:myOrder.htm";
        } else {
            return "user/error";
        }

    }

    @RequestMapping(value = "view")
    public ModelAndView view(int orderId, @RequestParam(value = "page", required = false) Integer page) {
        ModelAndView mav = new ModelAndView("user/Ajax/OrderDetail");
        List<OrderDetail> listOds = orderDetailModel.findOrderDetail(orderId);
        Orders orders = orderModel.getOrdersById(orderId);
        mav.addObject("orders", orders);

        PagedListHolder<OrderDetail> pagedListProduct = new PagedListHolder<>(listOds);
        pagedListProduct.setPageSize(1);
        mav.addObject("maxPages", pagedListProduct.getPageCount());
        if (page == null || page < 1 || page > pagedListProduct.getPageCount()) {
            page = 1;
        }
        mav.addObject("page", page);
        if (page == null || page < 1 || page > pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(0);
            mav.addObject("listOds", pagedListProduct.getPageList());
        } else if (page <= pagedListProduct.getPageCount()) {
            pagedListProduct.setPage(page - 1);
            mav.addObject("listOds", pagedListProduct.getPageList());
        }
        return mav;
    }

}
