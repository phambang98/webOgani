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
                            <div class="col-xl-3 col-md-6 mb-4">
                                <div class="card border-left-primary shadow h-100 py-2">
                                    <a href="#" id="AmountOrderTrue" style="text-decoration: none;">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Đơn Hàng Đã Duyệt(${countOrderTrue})</div>

                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                        <fmt:setLocale value = "en_US"/>
                                                        <fmt:formatNumber value = "${AmountOrderTrue}" type = "currency"/>
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-dollar-sign fa-2x"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                           
                             <div class="col-xl-3 col-md-6 mb-4">
                                <div class="card border-left-success shadow h-100 py-2">
                                    <a href="#" id="AmountOrderPending" style="text-decoration: none;">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Đơn Hàng Chờ Duyệt(${countOrderPending})</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                        <fmt:setLocale value = "en_VN"/>
                                                        <fmt:formatNumber value = "${AmountOrderPending}" type = "currency"/>
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-dollar-sign fa-2x"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>                       
                            <c:forEach items="${Top1Product}" var="Top1Product">
                                <div class="col-xl-3 col-md-6 mb-4">
                                    <div class="card border-left-warning shadow h-100 py-2">
                                        <a href="#" id="TopProduct" style="text-decoration: none;">
                                            <div class="card-body">
                                                <div class="row no-gutters align-items-center">
                                                    <div class="col mr-2">
                                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                            Sản Phẩm Top1:${Top1Product.product.prodName}</div>
                                                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                            <fmt:setLocale value = "en_US"/>
                                                            <fmt:formatNumber value = " ${Top1Product.totalAmount}" type = "currency"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-auto">
                                                        <i class="fas fa-trophy fa-2x"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:forEach items="${Top1Users}" var="Top1Users">
                                <div class="col-xl-3 col-md-6 mb-4">
                                    <div class="card border-left-danger shadow h-100 py-2">
                                        <a href="#" id="TopUsers" style="text-decoration: none;">
                                            <div class="card-body">
                                                <div class="row no-gutters align-items-center">
                                                    <div class="col mr-2">
                                                        <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Người Dùng Top1: ${Top1Users.users.userName}</div>
                                                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                            <fmt:setLocale value = "en_US"/>
                                                            <fmt:formatNumber value = " ${Top1Users.totalAmount}" type = "currency"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-auto">
                                                        <i class="fas fa-trophy fa-2x"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </div>  
                            </c:forEach>
                        </div>
                        <!--Chi Tiết Đơn Hàng-->
                        <div  id="detailOrder">

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

                $("#AmountOrderTrue").click(function (e) {
                    e.preventDefault();
                    $.ajax({
                        url: "<%=request.getContextPath()%>/adminOrder/orderTrue.htm",
                        type: 'POST',
                        data: {},
                        success: function (response) {
                            $("#detailOrder").html(response);
                        },
                        error: function (response) {
                            alert('sai');
                        }
                    });
                });
                $("#AmountOrderPending").click(function (e) {
                    e.preventDefault();
                    $.ajax({
                        url: "<%=request.getContextPath()%>/adminOrder/orderPending.htm",
                        type: 'POST',
                        data: {},
                        success: function (response) {
                            $("#detailOrder").html(response);
                        },
                        error: function (response) {
                            alert('sai');
                        }
                    });
                });

                $("#TopProduct").click(function (e) {
                    e.preventDefault();
                    $.ajax({
                        url: "<%=request.getContextPath()%>/adminOrder/topProduct.htm",
                        type: 'POST',
                        data: {},
                        success: function (response) {
                            $("#detailOrder").html(response);
                        },
                        error: function (response) {
                            alert('sai');
                        }
                    });
                });
                $("#TopUsers").click(function (e) {
                    e.preventDefault();
                    $.ajax({
                        url: "<%=request.getContextPath()%>/adminOrder/topUsers.htm",
                        type: 'POST',
                        data: {},
                        success: function (response) {
                            $("#detailOrder").html(response);
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