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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.css">

    </head>
    <body id="page-top">
        <c:if test="${sessionScope.admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
        <div id="wrapper">
            <jsp:include page="menu.jsp"/>
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <jsp:include page="header.jsp"/>
                    <div class="container-fluid">
                        <div class="row">
                            <c:forEach items="${Top1Star}" var="Top1Star">
                                <div class="col-xl-3 col-md-6 mb-4">
                                    <div class="card border-left-danger shadow h-100 py-2">
                                        <a href="#" id="TopProduct" style="text-decoration: none;">
                                            <div class="card-body">
                                                <div class="row no-gutters align-items-center">
                                                    <div class="col mr-2">
                                                        <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Sản Phẩm Top1:${Top1Star.product.prodName}</div>
                                                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                            <h3 class="rateyo" data-rateyo-rating="${Top1Star.avgStar}" data-rateyo-num-stars="5" id="mainRate" data-rateyo-score="4"></h3>
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
        <jsp:include page="IncludeJs.jsp"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>
        <script>
            jQuery(document).ready(function ($) {
                $("#TopProduct").click(function (e) {
                    e.preventDefault();
                    $.ajax({
                        url: "<%=request.getContextPath()%>/adminStar/topProduct.htm",
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
                $(".rateyo").rateYo({
                    readOnly: "true",
                });
            });
        </script>
    </body>
</html>