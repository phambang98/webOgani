/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ogani.entity.OrderDetail;
import ogani.entity.Orders;
import ogani.entityMore.ProductGroup;
import ogani.entityMore.UserGroup;
import ogani.excel.Excel;
import ogani.model.ContactModel;
import ogani.model.OrderDetailModel;
import ogani.model.OrderModel;
import ogani.model.ProductModel;
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
@RequestMapping(value = "/adminOrder")
public class AdminOrder {

    private OrderModel orderModel;
    private OrderDetailModel orderDetailModel;
    private UsersModel usersModel;
    private ProductModel productModel;
    private ContactModel contactModel;

    public AdminOrder() {
        orderModel = new OrderModel();
        orderDetailModel = new OrderDetailModel();
        usersModel = new UsersModel();
        productModel = new ProductModel();
        contactModel = new ContactModel();
    }

    @RequestMapping("View")
    public ModelAndView view() {
        ModelAndView mav = new ModelAndView("admin/order");
        //Tính Tổng Tiền Đơn Hàng Đã Duyệt
        Float AmountOrderTrue = orderModel.AmountOrderTrue();
        if (AmountOrderTrue == null) {
            AmountOrderTrue = 0f;
        }
        mav.addObject("AmountOrderTrue", AmountOrderTrue);
        //tính số lượng đơn hàng đã duyệt
        Integer countOrderTrue = orderModel.countOrderTrue();
        if (countOrderTrue == null) {
            countOrderTrue = 0;
        }
        mav.addObject("countOrderTrue", countOrderTrue);
        //tính tổng tiền đơn hàng chờ duyệt
        Float AmountOrderPending = orderModel.AmountOrderPending();
        if (AmountOrderPending == null) {
            AmountOrderPending = 0f;
        }
        mav.addObject("AmountOrderPending", AmountOrderPending);
        //tính tổng số lượng đơn hàng chờ duyệt
        Integer countOrderPending = orderModel.countOrderPending();
        if (countOrderPending == null) {
            countOrderPending = 0;
        }
        mav.addObject("countOrderPending", countOrderPending);
        //Top 1 sản phẩm
        mav.addObject("Top1Product", orderDetailModel.top1Product());
        //Top1 người dùng
        mav.addObject("Top1Users", orderModel.top1Users());
        return mav;
    }

    @RequestMapping(value = "orderView")
    public ModelAndView viewOrder(int orderId, @RequestParam(value = "page", required = false) Integer page) {
        ModelAndView mav = new ModelAndView("admin/Ajax/orderView");
        List<OrderDetail> listOds = orderDetailModel.findOrderDetail(orderId);
//        mav.addObject("listOds", listOds);
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
        //min Date
        return mav;
    }

    @RequestMapping(value = "orderTrue")
    public ModelAndView orderTrue(@RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "search", defaultValue = "") String search,
            @RequestParam(value = "sort", defaultValue = "") String sort,
            @RequestParam(value = "name", defaultValue = "") String name) {
        ModelAndView mav = new ModelAndView("admin/Ajax/orderTrue");
        //lấy true
        List<Orders> orderTrue = orderModel.getAllTrueAndSearchSort(search, name, sort);
        //phân trang true
        PagedListHolder<Orders> pageListTrue = new PagedListHolder<>(orderTrue);
        pageListTrue.setPageSize(4);
        mav.addObject("maxPages", pageListTrue.getPageCount());
        if (page == null || page < 1) {
            page = 1;
        }
        if (page > pageListTrue.getPageCount()) {
            page = pageListTrue.getPageCount();
        }
        mav.addObject("page", page);
        if (page == null || page < 1 || page > pageListTrue.getPageCount()) {
            pageListTrue.setPage(0);
            mav.addObject("listTrue", pageListTrue.getPageList());
        } else if (page <= pageListTrue.getPageCount()) {
            pageListTrue.setPage(page - 1);
            mav.addObject("listTrue", pageListTrue.getPageList());
        }
        mav.addObject("search", search);
        mav.addObject("sort", sort);
        mav.addObject("name", name);
        mav.addObject("minDate", orderModel.minDate());
        mav.addObject("maxDate", orderModel.maxDate());
        return mav;
    }

    @RequestMapping(value = "/orderPending")
    public ModelAndView OrderPending(@RequestParam(value = "true_arr[]", required = false) Integer true_arr[],
            @RequestParam(value = "orderId", required = false) Integer orderId,
            @RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "search", defaultValue = "") String search,
            @RequestParam(value = "sort", defaultValue = "") String sort,
            @RequestParam(value = "name", defaultValue = "") String name) {
        ModelAndView mav = new ModelAndView("admin/Ajax/orderPending");
        if (true_arr != null) {
            for (Integer integer : true_arr) {
                Orders orders = orderModel.getOrdersById(integer);
                orders.setOrderStatus("actived");
                boolean check = orderModel.updateOrders(orders);
            }
        } else if (orderId != null) {
            Orders orders = orderModel.getOrdersById(orderId);
            orders.setOrderStatus("not actived");
            boolean check = orderModel.updateOrders(orders);
        }
        List<Orders> orderPending = orderModel.getAllPendingAndSearchSort(search, name, sort);
        PagedListHolder<Orders> pageList = new PagedListHolder<>(orderPending);
        pageList.setPageSize(5);
        mav.addObject("maxPages", pageList.getPageCount());
        if (page == null || page < 1) {
            page = 1;
        } else if (page > pageList.getPageCount()) {
            page = pageList.getPageCount();
        }
        mav.addObject("page", page);
        if (page == null || page < 1 || page > pageList.getPageCount()) {
            pageList.setPage(0);
            mav.addObject("listPending", pageList.getPageList());
        } else if (page <= pageList.getPageCount()) {
            pageList.setPage(page - 1);
            mav.addObject("listPending", pageList.getPageList());
        }
        mav.addObject("search", search);
        mav.addObject("sort", sort);
        mav.addObject("name", name);
        return mav;
    }

    @RequestMapping(value = "/orderFalse")
    public ModelAndView orderFalse(@RequestParam(value = "page", required = false) Integer page) {
        ModelAndView mav = new ModelAndView("admin/orderFalse");
        //tính tổng số lượng đơn hàng từ chối duyệt
        Integer countOrderFalse = orderModel.countOrderFalse();
        if (countOrderFalse == null) {
            countOrderFalse = 0;
        }
        mav.addObject("countOrderFalse", countOrderFalse);
        List<Orders> orderFalse = orderModel.getAllFalse();
        PagedListHolder<Orders> pageList = new PagedListHolder<>(orderFalse);
        pageList.setPageSize(5);
        mav.addObject("maxPages", pageList.getPageCount());
        if (page == null || page < 1) {
            page = 1;
        } else if (page > pageList.getPageCount()) {
            page = pageList.getPageCount();
        }
        mav.addObject("page", page);
        if (page == null || page < 1 || page > pageList.getPageCount()) {
            pageList.setPage(0);
            mav.addObject("listFalse", pageList.getPageList());
        } else if (page <= pageList.getPageCount()) {
            pageList.setPage(page - 1);
            mav.addObject("listFalse", pageList.getPageList());
        }
        return mav;
    }

    @RequestMapping(value = "topProduct")
    public ModelAndView topProduct(@RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "search", defaultValue = "") String search,
            @RequestParam(value = "sort", defaultValue = "") String sort,
            @RequestParam(value = "name", defaultValue = "") String name) {
        ModelAndView mav = new ModelAndView("admin/Ajax/orderProduct");

        List<ProductGroup> listGroup = orderDetailModel.productGroup(search, sort, name);
        PagedListHolder<ProductGroup> pageList = new PagedListHolder<>(listGroup);
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
        mav.addObject("search", search);
        mav.addObject("sort", sort);
        mav.addObject("name", name);
        return mav;
    }

    @RequestMapping(value = "topUsers")
    public ModelAndView topUsers(@RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "search", defaultValue = "") String search,
            @RequestParam(value = "sort", defaultValue = "") String sort) {
        ModelAndView mav = new ModelAndView("admin/Ajax/orderUsers");

        List<UserGroup> list = usersModel.userGroup(search, sort);
        PagedListHolder<UserGroup> pageList = new PagedListHolder<>(list);
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
        return mav;
    }

    @RequestMapping(value = "viewProduct")
    public ModelAndView viewProduct(@RequestParam(value = "page", required = false) Integer page,
            @RequestParam(value = "prodId") Integer prodId) {
        ModelAndView mav = new ModelAndView("admin/Ajax/orderProductDetail");
        List<ProductGroup> list = orderDetailModel.viewProduct(prodId);
        PagedListHolder<ProductGroup> pageList = new PagedListHolder<>(list);
        pageList.setPageSize(1);
        mav.addObject("vpMaxPages", pageList.getPageCount());
        if (page == null || page < 1) {
            page = 1;
        } else if (page > pageList.getPageCount()) {
            page = pageList.getPageCount();
        }
        mav.addObject("vpPage", page);
        if (page == null || page < 1 || page > pageList.getPageCount()) {
            pageList.setPage(0);
            mav.addObject("viewProduct", pageList.getPageList());
        } else if (page <= pageList.getPageCount()) {
            pageList.setPage(page - 1);
            mav.addObject("viewProduct", pageList.getPageList());
        }
        mav.addObject("prodId", prodId);
        return mav;
    }

    @RequestMapping(value = "inHoaDon")
    public ModelAndView inHoaDon(@RequestParam(value = "orderId") Integer orderId) {
        ModelAndView mav = new ModelAndView("admin/Ajax/InHoaDon");
        mav.addObject("order", orderModel.getOrdersById(orderId));
        mav.addObject("list", orderDetailModel.findOrderDetail(orderId));
        mav.addObject("contact", contactModel.top1Contact());
        return mav;
    }

    @RequestMapping("/inFileExcel")
    public void inFileExcel(HttpServletRequest request, @RequestParam(value = "month") Integer month,
            @RequestParam(value = "year") Integer year, HttpServletResponse response) {
        List<ProductGroup> list = orderDetailModel.writeExcelToMonth(year, month);
        try {
            new Excel().writeExcel(list, month, year, response);
        } catch (IOException ex) {
            Logger.getLogger(AdminOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
