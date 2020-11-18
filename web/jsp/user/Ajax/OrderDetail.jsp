<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<h2 style="color:green">Người Mua Hàng:${sessionScope.users.userName}</h2>
<table  class="table" border="1px">

    <thead class="thead-dark" >

        <tr>
            <th scope="col">STT</th>
            <th scope="col">Tên Sản Phẩm</th>
            <th scope="col">Hình Ảnh</th>
            <th scope="col">Số Lượng</th>
            <th scope="col">Đơn Giá</th>
            <th scope="col">Giảm Giá</th>
            <th scope="col">Giá bán</th>
            <th scope="col">Thành Tiền</th>

        </tr>
    </thead>


    <tbody>
        <c:forEach items="${listOds}"  var="od" varStatus="index">   
            <tr>
                <td>${index.index+1}</td>
                <td>${od.product.prodName}</td>
                <td><img src="${od.product.imageLink}" width="100px"> </td>
                <td>${od.quantity}</td>
                <td><fmt:setLocale value = "en_US"/>
                    <fmt:formatNumber value = " ${od.product.price}" type = "currency"/>
                </td>
                <td>${od.discount} %</td>
                 <td>
                    <fmt:setLocale value = "en_US"/>
                    <fmt:formatNumber value = "${od.product.price-(od.product.price*od.discount/100)}" 
                                      type = "currency"/>
                </td>
                <td><fmt:setLocale value = "en_US"/>
                    <fmt:formatNumber value = " ${od.amount}" type = "currency"/>

                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>


<div class="product__pagination">
    <input type="hidden" value="${orders.orderId}" id="viewOrderId">
    <c:if test="${page > 1}">
        <a href="${page-1}" class="orderPagination"><i class="fa fa-arrow-left"></i></a>
        </c:if>
        <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
            <c:choose>
                <c:when test="${page == i.index}">
                <a href="${i.index}" style="color: greenyellow" class="orderPagination"> ${i.index}</a>
            </c:when>
            <c:otherwise>
                <a href="${i.index}" class="orderPagination"><span>${i.index}</span></a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

    <c:if test="${page + 1 <= maxPages}">
        <a href="${page+1}" class="orderPagination"><i class="fa fa-arrow-right"></i></a>
        </c:if>
</div>

<script>
    jQuery(document).ready(function ($) {
        $(".orderPagination").click(function (e) {
            e.preventDefault();

            var page = $(this).attr('href');
            var orderId = $("#viewOrderId").val();
            $.ajax({
                url: "<%=request.getContextPath()%>/orders/view.htm",
                type: 'POST',
                data: {orderId: orderId, page: page},
                success: function (response) {
                    $('.modal-body').html(response);

                }, error: function (jqXHR, textStatus, errorThrown) {
                    alert('ok');
                }
            });

        });
    });
</script>

