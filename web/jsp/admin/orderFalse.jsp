<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>SB Admin 2 - Dashboard</title>

        <jsp:include page="IncludeCss.jsp"/>

        <link href="../jsp/admin/css/pagination.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" type="text/css" rel="stylesheet" />
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    </head>
    <body id="page-top">
        <c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
        <div id="wrapper">
            <jsp:include page="menu.jsp"/>
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <jsp:include page="header.jsp"/>
                    <div class="container-fluid">
                        <div class="row">
                        </div>
                        <!--Chi Tiết Đơn Hàng-->
                        <div  id="detailOrder">
                            <div class="card shadow mb-4">
                               <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Tổng số Đơn Hàng Từ Chối:${countOrderFalse}</h6>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="orderFalse" width="100%" cellspacing="0">
                                            <thead >
                                                <tr >
                                                    <th>STT</th>
                                                    <th>Hình Người Mua</th>  
                                                    <th>Tên Người Mua</th>  
                                                    <th>Tổng Tiền</th>
                                                    <th>Ngày Mua</th>
                                                    <th>Địa chỉ</th>
                                                    <th>Chi Tiết</th>
                                                </tr>
                                            </thead> 
                                            <tbody>
                                                <c:forEach items="${listFalse}" varStatus="index" var="list">                        
                                                    <tr class="table-Light">
                                                        <td>${index.index+1}</td>
                                                        <td><h5><img src="${list.users.userImage}" height="30" width="30"></h5></td>
                                                        <td><h5>${list.users.userName}</h5></td>
                                                        <td> <fmt:setLocale value = "en_US"/>
                                                            <fmt:formatNumber value = "${list.totalAmount}" type = "currency"/></td>
                                                        <td><fmt:formatDate type = "both" value = "${list.created}" /></td>
                                                        <td>${list.orderAddress}</td>
                                                        <td><a title="Xem Chi Tiết" href="${list.orderId}" class="btn btn-success orderFalse">Xem</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="pagination">
                                            <c:if test="${page > 1}">
                                                <a href="${page-1}" class="page"><i class="fa fa-arrow-left"></i></a>
                                                </c:if>
                                                <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                                                    <c:choose>
                                                        <c:when test="${page == i.index}">
                                                        <span style="color: red;background-color: #0c5460">${i.index}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${i.index}" class="page"><span>${i.index}</span></a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>

                                            <c:if test="${page + 1 <= maxPages}">
                                                <a href="${page+1}" class="page"><i class="fa fa-arrow-right"></i></a>
                                                </c:if>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade bd-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" style="color: red">Chi Tiết Đơn Hàng</h3>
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
        <jsp:include page="IncludeJs.jsp"/>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            jQuery(document).ready(function ($) {
                $(".page").click(function (e) {
                    e.preventDefault();
                    var page = $(this).attr("href");
                    $.ajax({
                        url: '<%=request.getContextPath()%>/adminOrder/orderFalse.htm',
                        type: 'post',
                        dataType: 'html',
                        data: {page: page},
                        success: function (response) {
                            $("#detailOrder").html(response);
                        },
                        error: function (response) {
                            alert('sai');
                        }
                    });
                });
                $('.orderFalse').click(function (e) {
                    e.preventDefault();
                    var orderId = $(this).attr('href');

                    $('.modal-body').load('<%=request.getContextPath()%>/adminOrder/orderView.htm', {orderId: orderId}, function () {

                        $('#myModal').modal({show: true});

                    });
                });
            });
        </script>
    </body>
</html>