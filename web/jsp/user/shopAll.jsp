<%-- 
    Document   : shopAll
    Created on : Sep 11, 2020, 3:29:51 PM
    Author     : Bang-GoD
--%><%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--
<h2><c:if test="${empty idsearch  and rsCateName==null}"> Tất Cả Sản Phẩm:${countproduct}</c:if> 
<c:if test="${not empty idsearch  || rsCateName!=null}">
    Từ Khóa:${idsearch} <c:if test="${not empty idsearch  and rsCateName!=null}"> Và</c:if> 
    ${rsCateName}.Tìm Được ${countproduct}
</c:if>
<c:choose>
    <c:when test="${sortPrice=='ASC'}">
        (Sắp Xếp Theo Giá Tăng Dần)
    </c:when>
    <c:when test="${sortPrice=='DESC'}">
        (Sắp Xếp Theo Giá Giảm Dần)
    </c:when>
    <c:otherwise>
        (Chưa Sắp Xếp)
    </c:otherwise>
</c:choose>
</h2>-->
<div class="filter__item">
    <div class="row">
        <div class="col-lg-4 col-md-5">
            <div class="filter__sort">

            </div>
        </div>
        <div class="col-lg-4 col-md-3">
            <div class="filter__sort">

            </div>
        </div>
        <div class="col-lg-4 col-md-4">
            <div class="filter__found">

            </div>
        </div>
    </div>
</div>
<div class="row">
    <c:forEach items="${lp}" var="lp">
        <div class="col-lg-4 col-md-6 col-sm-6">
            <div class="product__item">
                <div class="product__item__pic">
                    <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${lp.prodId}">
                        <img src="${lp.imageLink}"></a> 
                    <ul class="product__item__pic__hover">
                        <li><a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${lp.prodId}">
                                <i class="fa fa-star"></i></a></li>
                        <li><a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${lp.prodId}">
                                <i class="fa fa-comment"></i></i></a></li>
                        <li> <c:if test="${lp.prodStatus==true&&lp.categories.cateStatus==true}">
                                <a href="<%=request.getContextPath()%>/shoppingCart/addCart.htm?prodId=${lp.prodId}">
                                    <i class="fa fa-shopping-cart"></i></a>
                                </c:if>
                                <c:if test="${lp.prodStatus==false||lp.categories.cateStatus==false}">
                                <a href="" class="addCart">
                                    <i class="fa fa-shopping-cart"></i>
                                </a>
                            </c:if>
                    </ul>
                </div>
                <div class="product__item__text">
                    <h6><a href="<%=request.getContextPath()%>/shoppingCart/addCart.htm?prodId=${lp.prodId}">${lp.prodName}</a></h6>
                    <h5><fmt:formatNumber currencySymbol="" value="${lp.price-(lp.price*lp.discount/100)}"> 
                        </fmt:formatNumber> VND
                        <c:if test="${lp.discount!=0}">
                            <span style="text-decoration: line-through; opacity: 0.4" >${lp.price}</span>
                        </c:if>
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
                <input type="hidden" value="${sortPrice}" id="sortPrice" >
                <input type="hidden" value="${cateIdPage}" id="cateIdPage" >
                <input type="hidden" value="${idsearch}" id="idsearch" >
                <input type="hidden" value="${idsearch}" id="sortDiscount" >
                <c:if test="${page > 1}">
                    <a href="${page-1}" class="shopPagintation"><i class="fa fa-long-arrow-left"></i></a>
                    </c:if>
                    <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                        <c:choose>
                            <c:when test="${page == i.index}">
                            <span style="color: red;background-color: #0c5460">${i.index}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${i.index}" class="shopPagintation"><span>${i.index}</span></a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                <c:if test="${page + 1 <= maxPages}">
                    <a href="${page+1}" class="shopPagintation"><i class="fa fa-long-arrow-right"></i></a>
                    </c:if>
            </div>
        </div>
    </div>
</div>

<script>
    jQuery(document).ready(function ($) {
        $(".shopPagintation").click(function (e) {
            var sortPrice = $('#sortPrice').val();
            var cateIdPage = $('#cateIdPage').val();
            var idsearch = $("#idsearch").val();
            var sortDiscount = $("#sortDiscount").val();
            e.preventDefault();
            var key = $(this).attr("href");
            $.ajax({
                url: 'ajaxShop.htm',
                type: 'post',
                dataType: 'html',
                data: {cateId: cateIdPage, page: key, search: idsearch, sortPrice: sortPrice, sortDiscount: sortDiscount},
                success: function (response) {
                    $("#showShopAll").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });
        $(".addCart").click(function (e) {
            e.preventDefault();
            alert('Hết Hàng. Ko Add Cart Được');
        });
    });
</script>
