<%-- 
    Document   : index
    Created on : Sep 8, 2020, 9:09:39 AM
    Author     : Bang-GoD
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <jsp:include page="banner1.jsp"/>
        <section class="categories">
            <div class="container">
                <div class="row">
                    <div class="categories__slider owl-carousel">
                        <c:forEach var="listRandom" begin="1" end="5" items="${listRandom}">
                            <div class="col-lg-3">
                                <div class="categories__item ">
                                    <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${listRandom.prodId}">
                                        <img src="${listRandom.imageLink}"></a>
                                    <h5> <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${listRandom.prodId}">
                                            ${listRandom.prodName}</a></h5>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </section>
        <section class="featured spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title">
                            <h2>Featured Product</h2>
                        </div>
                        <div class="featured__controls">
                            <ul>
                                <li id="0">All</li>                            
                                    <c:forEach items="${listCate}" var="listCate">
                                    <li id="${listCate.cateId}">${listCate.cateName}</li>
                                    </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container allproduct">
                <div class="row featured__filter">
                    <c:forEach items="${lp}" var="lp">
                        <div class="col-lg-3 col-md-4 col-sm-6 mix">
                            <div class="featured__item">
                                <div class="featured__item__pic">
                                    <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${lp.prodId}">
                                        <img src="${lp.imageLink}"></a> 
                                    <ul class="featured__item__pic__hover">
                                        <li>  <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${lp.prodId}">
                                                <i class="fa fa-star"></i></a></li>
                                        <li>  <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${lp.prodId}">
                                                <i class="fa fa-comment"></i></i></a></li>
                                        <li>
                                            <c:if test="${lp.prodStatus==true&&lp.categories.cateStatus==true}">
                                                <a href="<%=request.getContextPath()%>/shoppingCart/addCart.htm?prodId=${lp.prodId}">
                                                    <i class="fa fa-shopping-cart"></i></a>
                                                </c:if>
                                                <c:if test="${lp.prodStatus==false||lp.categories.cateStatus==false}">
                                                <a href="" class="addCart">
                                                    <i class="fa fa-shopping-cart"></i>
                                                </a>
                                            </c:if>
                                        </li>
                                    </ul>
                                </div>
                                <div class="featured__item__text">
                                    <h6><a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${lp.prodId}">
                                            ${lp.prodName}</a></h6>
                                    <h5>
                                        <fmt:formatNumber currencySymbol="" value="${lp.price-(lp.price*lp.discount/100)}"> 
                                        </fmt:formatNumber> VND
                                    </h5>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="section-title">
                            <div class="product__pagination">
                                <c:url value="index.htm" var="prev">
                                    <c:param name="page" value="${page-1}" />
                                </c:url>
                                <c:if test="${page > 1}">
                                    <a href="<c:out value="${prev}" />"><i class="fa fa-long-arrow-left"></i></a>
                                    </c:if>
                                    <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                                        <c:choose>
                                            <c:when test="${page == i.index}">
                                            <span style="color: red;background-color: #0c5460">${i.index}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <c:url  value="index.htm" var="url">
                                                <c:param name="page" value="${i.index}"/>
                                            </c:url>                                               
                                            <a href='<c:out value="${url}" />'>${i.index}</a>                      
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:url  value="index.htm" var="next">
                                    <c:param name="page" value="${page + 1}"/>
                                </c:url>
                                <c:if test="${page + 1 <= maxPages}">
                                    <a href='<c:out value="${next}" />'><i class="fa fa-long-arrow-right"></i></a>
                                    </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container ajaxallproduct">
            </div>
        </section>
        <section class="latest-product spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6">
                        <div class="latest-product__text">
                            <h4>Top Buy Products</h4>
                            <div class="latest-product__slider owl-carousel">
                                <c:forEach items="${Top3Buy}" varStatus="index" var="Top3Buy">
                                    <div class="latest-prdouct__slider__item">
                                        <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${Top3Buy.product.prodId}" class="latest-product__item">
                                            <div class="latest-product__item__pic">
                                                <img src="${Top3Buy.product.imageLink}" width="30px" height="30px" alt="">
                                            </div>
                                            <div class="latest-product__item__text">
                                                <h6>${Top3Buy.product.prodName}</h6>
                                                <span>Top ${index.index+1}</span>
                                            </div>
                                        </a>
                                    </div>
                                </c:forEach>

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="latest-product__text">
                            <h4>Top Rated Products</h4>
                            <div class="latest-product__slider owl-carousel">
                                <c:forEach items="${Top3Star}" varStatus="index" var="Top3Star">
                                    <div class="latest-prdouct__slider__item">

                                        <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${Top3Star.product.prodId}" class="latest-product__item">
                                            <div class="latest-product__item__pic">
                                                <img src="${Top3Star.product.imageLink}" width="30px" height="30px" alt="">
                                            </div>
                                            <div class="latest-product__item__text">
                                                <h6>${Top3Star.product.prodName}</h6>

                                                <span>Top ${index.index+1}</span>
                                            </div>
                                        </a>

                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="latest-product__text">
                            <h4> Top Comment Products</h4>
                            <div class="latest-product__slider owl-carousel">
                                <c:forEach items="${Top3Cmt}" var="Top3Cmt" varStatus="index">
                                    <div class="latest-prdouct__slider__item">
                                        <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${Top3Cmt.product.prodId}" class="latest-product__item">
                                            <div class="latest-product__item__pic">
                                                <img src="${Top3Cmt.product.imageLink}" width="30px" height="30px" alt="">
                                            </div>
                                            <div class="latest-product__item__text">
                                                <h6>${Top3Cmt.product.prodName}</h6>

                                                <span>Top ${index.index+1}</span>
                                            </div>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp"/>
        <jsp:include page="IncludeJs.jsp"/>
        <script>
            jQuery(document).ready(function ($) {
                $('.ajaxallproduct').hide();
                $(".featured__controls ul li").click(function () {
                    var cateId = this.id;
                    if (cateId == 0)
                    {
                        location.reload();
                    } else {
                        $.ajax({
                            url: 'ajaxGetAllProduct.htm',
                            type: 'post',
                            dataType: 'html',
                            data: {cateId: cateId},
                            success: function (response) {
                                $(".allproduct").hide();
                                $('.ajaxallproduct').show();
                                $(".ajaxallproduct").html(response);
                            },
                            error: function (response) {
                                location.reload();
                            }
                        });
                    }
                });
                $(".addCart").click(function (e) {
                    e.preventDefault();
                    alert('Hết Hàng. Ko Add Cart Được');
                });
            });
        </script>
    </body>
</html>
