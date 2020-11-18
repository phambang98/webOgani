<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset=UTF-8">
        <meta name="description" content="Ogani Template">
        <meta name="keywords" content="Ogani, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Ogani</title>
        <jsp:include page="IncludeCss.jsp"/>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="banner.jsp"/>
        <section class="shoping-cart spad">
            <form action="updateCart.htm" method="post">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="shoping__cart__table">
                                <table>
                                    <thead>
                                        <tr>
                                            <th class="shoping__product">Products</th>
                                            <th>Price<br>(Đã Tính Giảm Giá)</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                            <th></th>
                                        </tr>
                                    </thead> 
                                    <tbody>
                                        <c:forEach items="${sessionScope.listCart}" var="listCart">                        
                                            <tr>
                                                <td class="shoping__cart__item">
                                                    <img src="${listCart.product.imageLink}" width="100" alt="">
                                                    <h5>${listCart.product.prodName}</h5>
                                                </td>
                                                <td class="shoping__cart__price">
                                                    <input readonly="true" type="text" class="shoping__cart__price"
                                                           name=""
                                                           value="${listCart.product.price-listCart.product.price*listCart.product.discount/100}">
                                                </td>
                                                <td class="shoping__cart__quantity">
                                                    <div class="quantity">
                                                        <div class="pro-qty">
                                                            <input type="text" name="quantity"
                                                                   onkeypress='return event.charCode >= 48 && event.charCode <= 57'
                                                                   class="soluong" value="${listCart.quantity}">
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="shoping__cart__total">
                                                    <input type="text"  class="shoping__cart__total" readonly="true" name=""
                                                           value="${listCart.product.price*listCart.quantity-listCart.product.price*listCart.quantity*listCart.product.discount/100}">
                                                </td>
                                                <td class="shoping__cart__item__close">
                                                    <a href="deleteCart.htm?prodId=${listCart.product.prodId}">
                                                        <span class="icon_close"></span></a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="shoping__cart__btns">
                                <a href="<%=request.getContextPath()%>/home/index.htm"
                                   class="primary-btn cart-btn">CONTINUE SHOPPING</a>
                                 
                                <input type="submit"  value="Upadate Cart" class="primary-btn cart-btn cart-btn-right"> 
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="shoping__checkout">
                                <h5>Cart Total</h5>
                                <ul>
                                    <li>Total
                                         
                                        <input id="sum" type="text" readonly="true" name="" value="${sessionScope.tongtien}"></li>
                                </ul>
                                <c:choose>
                                    <c:when test = "${sessionScope.listCart==null}">
                                        <a href="" 
                                           onclick="alert('Chưa Có Hàng Sao Thanh Toán?????');" class="primary-btn">PROCEED TO CHECKOUT</a>
                                    </c:when>
                                    
                                    <c:when test = "${sessionScope.users==null}">
                                        <a href=""  onclick="alert('Đăng Nhập Để Tính Tiền Nhé Bạn!');"
                                           class="primary-btn">PROCEED TO CHECKOUT</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="<%=request.getContextPath()%>/orders/initCheckOut.htm" class="primary-btn">PROCEED TO CHECKOUT</a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </section>
        <jsp:include page="footer.jsp"/>
        <jsp:include page="IncludeJs.jsp"/>
        <script type="text/javascript">
            jQuery(document).ready(function ($) {
                var proQty = $('.pro-qty');
                proQty.prepend('<span class="dec qtybtn">-</span>');
                proQty.append('<span class="inc qtybtn">+</span>');
                proQty.on('click', '.qtybtn', function () {
                    var $button = $(this);
                    var oldValue = $button.parent().find('input').val();
                    if ($button.hasClass('inc')) {
                        var newVal = parseFloat(oldValue) + 1;
                    } else {
                        // Don't allow decrementing below zero
                        if (oldValue > 0) {
                            var newVal = parseFloat(oldValue) - 1;
                        } else {
                            newVal = 0;
                        }
                    }
                    $button.parent().find('input').val(newVal);
                    calculateSum();
                });
                $(".soluong").each(function () {
                    $(this).keyup(function () {
                        batnhap();
                        calculateSum();
                    });
                });
            });
            function batnhap() {
                var soluong = parseInt($('.soluong').length);
                for (var i = 0; i < soluong; i++) {
                    if ($('tr:nth-child(' + (i + 1) + ')').find('td').find(".soluong").val() == "")
                    {
                        $(".soluong").eq(i).val(0);
                    }
                }
            }
            function calculateSum() {
                var sum = 0;
                var soluong = parseInt($('.soluong').length);
                var sumQ = [];
                var sumW = [];
                for (var i = 0; i < soluong; i++) {
                    $('tr:nth-child(' + (i + 1) + ')').find('td').find(".soluong").each(function () {
                        sumQ[i] = parseFloat(this.value);
                    });
                    $('tr:nth-child(' + (i + 1) + ')').find('td').find(".shoping__cart__price").each(function () {
                        sumW[i] = parseFloat(this.value);
                    });
                    $('tr').find('td').find(".shoping__cart__total").eq(i).val(sumQ[i] * sumW[i]);
                }
                ;
                $(".shoping__cart__total").each(function () {
                    //add only if the value is number
                    if (!isNaN(this.value) && this.value.length != 0) {
                        sum += parseFloat(this.value);
                    }
                });
                $("#sum").val(sum);
            }
        </script>
    </body>
</html>