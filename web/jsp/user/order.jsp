<%-- 
    Document   : order
    Created on : Sep 14, 2020, 9:12:20 AM
    Author     : Bang-GoD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset=UTF-8">
        <meta name="description" content="Ogani Template">
        <meta name="keywords" content="Ogani, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Order</title>
        <jsp:include page="IncludeCss.jsp"/>

    </head>
    <body>
        <c:if test="${sessionScope.users==null}">
            <c:redirect url="${request.contextPath}/home/index.htm"/>     
        </c:if>
        <jsp:include page="header.jsp"/>
        <jsp:include page="banner.jsp"/>
        <section class="shoping-cart spad">
            <form action="updateCart.htm" method="post">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="shoping__cart__table">
                                <table class="table">
                                    <thead >
                                        <tr class="table-primary">
                                            <th scope="col">Tên Người Mua</th>
                                            <th scope="col"> Phone<br></th>
                                            <th scope="col">Email<br></th>
                                            <th scope="col">Tổng Tiền</th>
                                            <th scope="col">Địa Chỉ</th>
                                            <th scope="col">Ngày Mua<br></th>
                                            <th scope="col">Trạng Thái</th>
                                            <th scope="col"></th>
                                        </tr>
                                    </thead> 
                                    <tbody>
                                        <c:forEach items="${listOrder}" var="listOrder">                        
                                            <tr class="table-warning">
                                                <td>
                                                    <h5>${listOrder.users.userName}</h5>
                                                </td>
                                                <td>
                                                    ${listOrder.phone}
                                                </td>
                                                <td>
                                                    ${listOrder.email}
                                                </td>
                                                <td>
                                                    <fmt:setLocale value = "en_US"/>
                                                    <fmt:formatNumber value = "  ${listOrder.totalAmount}" type = "currency"/>
                                                </td>
                                                <td>
                                                    ${listOrder.orderAddress}
                                                </td>
                                                <td>
                                                    ${listOrder.created}
                                                </td>
                                                <c:choose>
                                                    <c:when test = "${listOrder.orderStatus=='pending'}">
                                                        <td>
                                                            Chờ Duyệt
                                                        </td>
                                                    </c:when>
                                                    <c:when test = "${listOrder.orderStatus=='actived'}">
                                                        <td>
                                                            Đã Xác Nhận
                                                        </td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>
                                                            Bị Từ Chối
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>                                             
                                                <td>
                                                    <a data-toggle="tooltip" title="Xem Chi Tiết" href="${listOrder.orderId}" class="btn btn-success openBtn">Xem Chi Tiết</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="product__pagination">
                                <c:url value="myOrder.htm" var="prev">
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
                                            <c:url  value="myOrder.htm" var="url">
                                                <c:param name="page" value="${i.index}"/>
                                            </c:url>
                                            <!--                                            1 số đầu-->                                 
                                            <a href='<c:out value="${url}" />'><span>${i.index}</span></a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <c:url  value="myOrder.htm" var="next">
                                            <c:param name="page" value="${page + 1}"/>
                                        </c:url>
                                        <c:if test="${page + 1 <= maxPages}">
                                    <a href='<c:out value="${next}" />'><i class="fa fa-long-arrow-right"></i></a>
                                    </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <!-- Modal -->


            <div class="modal fade bd-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title" style="color: red">Chi Tiết Hóa Đơn</h3>

                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>   
                        </div>
                    </div>
                </div>
            </div>

        </section>
        <jsp:include page="footer.jsp"/>
        <jsp:include page="IncludeJs.jsp"/>
        <script>
            jQuery(document).ready(function ($) {
                $('.openBtn').click(function (e) {
                    e.preventDefault();
                    var orderId = $(this).attr('href');
                    $('.modal-body').load('view.htm', {orderId: orderId}, function () {
                        $('#myModal').modal({show: true});
                    });
                });
            });
        </script>
    </body>
</html>
