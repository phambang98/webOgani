<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset=UTF-8">
        <meta name="description" content="Ogani Template">
        <meta name="keywords" content="Ogani, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Shop</title>
        <jsp:include page="IncludeCss.jsp"/>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="banner.jsp"/>
        <section class="product spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-5">
                        <div class="sidebar">
                            <div class="sidebar__item">
                                <input type="text" id="searchproduct" placeholder="Search...">
                                <button type="submit" onclick="alert('không đươc');"><span class="icon_search"></span></button>
                            </div>
                            <!--                            <div class="sidebar__item">
                                                            <a href="<%=request.getContextPath()%>/shop/saleOff.htm" ><h4>Giảm Giá</h4></a>
                                                        </div>-->
                            <div class="sidebar__item">
                                <h4>Tất Cả</h4>
                                <div class="sidebar__item__size">            
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <input type="radio" autofocus="true" class="sortPrice" name="inputradio" value="0">All
                                        </div>
                                    </div>   
                                </div>
                                <c:forEach items="${listCate}" var="listCate">
                                    <div class="sidebar__item__size">
                                        <div class="input-group-prepend">
                                            <div class="input-group-text">
                                                <input type="radio" class="sortPrice" name="inputradio" value="${listCate.cateId}">
                                                ${listCate.cateName}  
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="sidebar__item">
                                <h4>Sắp Xếp Theo Giá</h4>
                                 <div class="sidebar__item__size">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <input type="radio" class="sortPrice" name="sortPrice" value="">Không Sắp Xếp
                                        </div>
                                    </div>
                                </div>
                                <div class="sidebar__item__size">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <input type="radio" class="sortPrice" name="sortPrice" value="ASC">Tăng Dần
                                        </div>
                                    </div>
                                </div>
                                <div class="sidebar__item__size">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <input type="radio" class="sortPrice" name="sortPrice" value="DESC">Giảm Dần
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="sidebar__item">
                                <h4>Theo Giảm Giá</h4>
                                <div class="sidebar__item__size">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <input type="radio" class="sortPrice" name="sortDiscount" value="">Tất Cả
                                        </div>
                                    </div>
                                </div>
                                <div class="sidebar__item__size">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <input type="radio" class="sortPrice" name="sortDiscount" value=">0">Có Giảm Giá
                                        </div>
                                    </div>
                                </div>
                                <div class="sidebar__item__size">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <input type="radio" class="sortPrice" name="sortDiscount" value="=0">Không Giảm Giá
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-7" id="showShopAll">
                    </div>    
                </div>
                <div class="product__discount">
                    <div class="section-title product__discount__title">
                        <h2>Sale Off </h2>
                    </div>
                    <c:if test="${listDiscount.size()==0}">
                        <h2>Không Có Sản Phẩm nào Giảm Giá</h2>
                    </c:if>
                    <c:if test="${listDiscount.size()!=0}">   
                        <div class="row">
                            <div class="product__discount__slider owl-carousel">
                                <c:forEach items="${listDiscount}" var="listDiscount">
                                    <div class="col-lg-4">
                                        <div class="product__discount__item">
                                            <div class="product__discount__item__pic">
                                                <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${listDiscount.prodId}">
                                                    <img src="${listDiscount.imageLink}"></a>
                                                <div class="product__discount__percent">${listDiscount.discount}%</div>
                                                <ul class="product__item__pic__hover">
                                                    <li>  <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${listDiscount.prodId}">
                                                            <i class="fa fa-star"></i></a></li>
                                                    <li>  <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${listDiscount.prodId}">
                                                            <i class="fa fa-comment"></i></i></a></li>
                                                    <li>
                                                        <a href="<%=request.getContextPath()%>/shoppingCart/addCart.htm?prodId=${listDiscount.prodId}">
                                                            <i class="fa fa-shopping-cart"></i></a></li>
                                                </ul>
                                            </div>
                                            <div class="product__discount__item__text">

                                                <h5><a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${listDiscount.prodId}">${listDiscount.prodName}</a></h5>
                                                <div class="product__item__price">
                                                    <fmt:formatNumber currencySymbol="" value="${listDiscount.price-(listDiscount.price*listDiscount.discount/100)}"> 
                                                    </fmt:formatNumber> VND
                                                    <span>${listDiscount.price}</span></div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp"/>
        <jsp:include page="IncludeJs.jsp"/>
        <script>
            jQuery(document).ready(function ($) {
                $.get("ajaxShop.htm",function (response){
                     $("#showShopAll").html(response);
                });
                $('.sortPrice').on('change', function () {
                    var sortPrice = $('input[name=sortPrice]:checked').val();
                    var sortDiscount = $('input[name=sortDiscount]:checked').val();
                    var cateId = $('input[name=inputradio]:checked').val();
                    var search = $("#searchproduct").val().trim();
                    $.ajax({
                        url: 'ajaxShop.htm',
                        type: 'post',
                        dataType: 'html',
                        data: {cateId: cateId, search: search, sortPrice: sortPrice,sortDiscount:sortDiscount},
                        success: function (response) {
                            $("#showShopAll").html(response);
                        },
                        error: function (response) {
                            alert('sai');
                        }
                    });
                });
                
                $("#searchproduct").keyup(function () {
                    var sortPrice = $('input[name=sortPrice]:checked').val();   
                     var sortDiscount = $('input[name=sortDiscount]:checked').val();
                    var cateId = $('input[name=inputradio]:checked').val();
                    var search = $("#searchproduct").val().trim();     
                    $.ajax({
                        url: 'ajaxShop.htm',
                        type: 'post',
                        dataType: 'html',
                        data: {cateId: cateId, search: search, sortPrice: sortPrice,sortDiscount:sortDiscount},
                        success: function (response) {
                            $("#showShopAll").html(response);
                        },
                        error: function (response) {
                            alert('sai');
                        }
                    });
                });
            });
        </script>
    </body>
</html>