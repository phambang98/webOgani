<%-- 
    Document   : all
    Created on : Sep 5, 2020, 9:46:23 PM
    Author     : Bang-GoD
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="row featured__filter">
    <c:forEach items="${lp}" var="lp">
        <div class="col-lg-3 col-md-4 col-sm-6 mix">
            <div class="featured__item">
                <div class="featured__item__pic">
                    <a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${lp.prodId}">
                        <img src="${lp.imageLink}"></a> 
                    <ul class="featured__item__pic__hover">
                        <li><a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${lp.prodId}">
                                <i class="fa fa-star"></i></a></li>
                        <li><a href="<%=request.getContextPath()%>/shop/details.htm?prodId=${lp.prodId}">
                                <i class="fa fa-comment"></i></a></li>
                        <li><a href="<%=request.getContextPath()%>/shoppingCart/addCart.htm?prodId=${lp.prodId}">
                                <i class="fa fa-shopping-cart"></i></a></li>
                    </ul>
                </div>
                <div class="featured__item__text">
                    <h6><a href="#">${lp.prodName}</a></h6>
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
                <input type="hidden" value="${pageCateId}" id="pageCateId" >
                <c:if test="${page > 1}">
                    <a href="${page-1}" class="ajaxpagination"><i class="fa fa-long-arrow-left"></i></a>
                    </c:if>
                    <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                        <c:choose>
                            <c:when test="${page ==i.index}">
                            <span style="color: red;background-color: #0c5460">${i.index}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${i.index}" class="ajaxpagination"><span>${i.index}</span></a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${page + 1 <= maxPages}">
                    <a href="${page+1}" class="ajaxpagination"><i class="fa fa-long-arrow-right"></i></a>
                    </c:if>
            </div>
        </div>
    </div>
</div>
<script>
    jQuery(document).ready(function ($) {
        $(".ajaxpagination").click(function (e) {
            var pageCateId = $('#pageCateId').val();
            e.preventDefault();
            var key = $(this).attr("href");
            $.ajax({
                url: 'ajaxGetAllProduct.htm',
                type: 'post',
                dataType: 'html',
                data: {cateId: pageCateId, page: key},
                success: function (response) {
                    $(".ajaxallproduct").html(response);
                },
                error: function (response) {
                    location.reload();
                }
            });
        });
    });
</script>
