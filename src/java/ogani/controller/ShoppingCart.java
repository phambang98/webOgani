/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import ogani.entity.Cart;
import ogani.entity.Product;
import ogani.model.ProductModel;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Bang-GoD
 */
@Controller
@RequestMapping(value = "/shoppingCart")
public class ShoppingCart {

    private ProductModel productModel;

    public ShoppingCart() {
        productModel = new ProductModel();
    }

    @RequestMapping(value = "/myCart")
    public String shopcart(HttpSession session,HttpServletRequest request) {
          session.setAttribute("reuqestURL", request.getServletPath());
          session.setAttribute("requestURL", request.getServletPath());
        List<Cart> listCart = (List<Cart>) session.getAttribute("listCart");
        if (listCart == null) {
            session.setAttribute("thongbao", 0);
        } else {
            int dem = 0;
            for (Cart object : listCart) {
                dem++;
            }
            session.setAttribute("myCart", dem);
            session.setAttribute("listCart", listCart);
            session.setAttribute("tongtien", tongtien(listCart));
        }
        return "user/shoppingCart";
    }

    @RequestMapping(value = "/addCart")
    public String addCart(@RequestParam("prodId") int prodId, @RequestParam(required = false) Integer quantity,
            HttpSession session) {
        Product product = productModel.findProduct(prodId);
        List<Cart> listCart = (List<Cart>) session.getAttribute("listCart");
        if (product.isProdStatus()== true&&product.getCategories().isCateStatus()==true) {
            if (quantity == null) {
                quantity = 1;
            }
            if (listCart == null) {
                listCart = new ArrayList<>();
                Cart cart = new Cart(product, quantity);
                listCart.add(cart);
            } else {
                boolean check = false;
                for (Cart cart : listCart) {
                    if (cart.getProduct().getProdId() == prodId) {
                        check = true;
                        cart.setQuantity(cart.getQuantity() + quantity);
                        break;
                    }
                }
                if (!check) {
                    Cart cart = new Cart(product, quantity);
                    listCart.add(cart);
                }
            }
            session.setAttribute("listCart", listCart);
            session.setAttribute("tongtien", tongtien(listCart));
        }
        return "redirect:myCart.htm";
    }

    public double tongtien(List<Cart> listCart) {
        double tongtien = 0;
        for (Cart object : listCart) {
            tongtien += object.getQuantity() * object.getProduct().getPrice() - object.getQuantity() * object.getProduct().getPrice() * object.getProduct().getDiscount() / 100;
        }
        return tongtien;
    }

    public double tienduocgiam(List<Cart> listCart) {
        double tongtien = 0;
        for (Cart object : listCart) {
            tongtien += object.getQuantity() * object.getProduct().getPrice() - object.getQuantity() * object.getProduct().getPrice() * object.getProduct().getDiscount() / 100;
        }
        return tongtien;
    }

    @RequestMapping(value = "/updateCart")
    public String updatecart(HttpSession session, HttpServletRequest request) {
        List<Cart> listCart = (List<Cart>) session.getAttribute("listCart");
        String[] arrQuantity = request.getParameterValues("quantity");
        for (int i = 0; i < listCart.size(); i++) {
            listCart.get(i).setQuantity(Integer.parseInt(arrQuantity[i]));
        }
        session.setAttribute("listCart", listCart);
        session.setAttribute("tongtien", tongtien(listCart));
        return "redirect:myCart.htm";
    }

    @RequestMapping(value = "/deleteCart")
    public String deletecart(HttpSession session, @RequestParam(value = "prodId") int prodId) {
        List<Cart> listCart = (List<Cart>) session.getAttribute("listCart");

        for (int i = 0; i < listCart.size(); i++) {
            if (listCart.get(i).getProduct().getProdId() == prodId) {
                listCart.remove(i);
            }
        }
        session.setAttribute("lc", listCart);
        session.setAttribute("tongtien", tongtien(listCart));
        return "redirect:myCart.htm";
    }

}
