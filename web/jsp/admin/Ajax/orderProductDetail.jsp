<%-- 
    Document   : OrderDetail
    Created on : Sep 16, 2020, 4:20:44 PM
    Author     : Bang-GoD
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${admins==null}">

    <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
</c:if>
<table  class="table" border="1px">

    <thead class="thead-dark" >

        <tr>
            <th scope="col">STT</th>
            <th scope="col">Tên Sản Phẩm</th>
            <th scope="col">Hình Ảnh</th>
            <th scope="col">Số Lượng</th>
            <th scope="col">Đơn Giá</th>
            <th scope="col">Giảm Giá</th>
            <th scope="col">Giá Bán</th>
            <th scope="col">Thành Tiền</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${viewProduct}"  var="vp" varStatus="index">   

            <tr>
                <td>${index.index+1}</td>
                <td>${vp.product.prodName}</td>
                <td><img src="${vp.product.imageLink}" width="100px"> </td>
                <td>${vp.quantity}</td>
                <td>
                    <fmt:setLocale value = "en_US"/>
                    <fmt:formatNumber value = "${vp.product.price}" type = "currency"/></td>
                <td>${vp.avgStar}%</td>
                <td>
                    <fmt:setLocale value = "en_US"/>
                    <fmt:formatNumber value = "${vp.product.price-(vp.product.price*vp.avgStar/100)}" 
                                      type = "currency"/>
                </td>
                <td>
                    <fmt:setLocale value = "en_US"/>
                    <fmt:formatNumber value = "${vp.totalAmount}" type = "currency"/></td>
            </tr>
        </c:forEach>

    </tbody>
</table>
<div class="pagination">
    <input type="hidden" value="${prodId}" id="vpProdId">
    <c:if test="${vpPage > 1}">
        <a href="${vpPage-1}" class="vpPagination"><i class="fa fa-arrow-left"></i></a>
        </c:if>
        <c:forEach begin="1" end="${vpMaxPages}" step="1" varStatus="i">
            <c:choose>
                <c:when test="${vpPage == i.index}">
                <span style="color: red;background-color: #0c5460">${i.index}</span>
            </c:when>
            <c:otherwise>
                <a href="${i.index}" class="vpPagination"><span>${i.index}</span></a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

    <c:if test="${vpPage + 1 <= vpMaxPages}">
        <a href="${vpPage+1}" class="vpPagination"><i class="fa fa-arrow-right"></i></a>
        </c:if>
</div>

<script>
    jQuery(document).ready(function ($) {
        $(".vpPagination").click(function (e) {
            e.preventDefault();
            var page = $(this).attr('href');
            var prodId = $("#vpProdId").val();
            $.ajax({
                url: "<%=request.getContextPath()%>/adminOrder/viewProduct.htm",
                type: 'POST',
                data: {page: page, prodId: prodId},
                success: function (response) {
                    $('.modal-body').html(response);
                }, error: function (response) {
                    alert('sai');
                }
            });
        });
    });
</script>

