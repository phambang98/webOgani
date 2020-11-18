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
        <title>SB Admin 2 - Comment</title>
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
                            <div class="col-xl-6 col-md-6 mb-6">
                                <div class="card border-left-warning shadow h-100 py-2">
                                    <a href="<%=request.getContextPath()%>/adminComment/commentTrue.htm" id="ViewCommentTrue" style="text-decoration: none;">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                        Bình luận được đã được duyệt(${countCommentTrue})</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800"></div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-comments fa-2x"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <div class="col-xl-6 col-md-6 mb-6">
                                <div class="card border-left-danger shadow h-100 py-2">
                                    <a href="<%=request.getContextPath()%>/adminComment/commentFalse.htm" id="ViewCommentFalse" style="text-decoration: none;">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                                        Bình luận chưa đc duyệt(${countCommentFalse})</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800"></div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-comment-slash fa-2x"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                           
                        </div>
                        <!--Chi Tiết Đơn Hàng-->
                        <div  id="detailOrder">

                        </div>
                    </div>
                </div>
            </div>
        </div>
       
        <jsp:include page="IncludeJs.jsp"/>
        <script>
            jQuery(document).ready(function ($) {
                


                $("#ViewCommentFalse").click(function (e) {
                    e.preventDefault();
                    $.ajax({
                        url: "<%=request.getContextPath()%>/adminComment/commentFalse.htm",
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


                $("#ViewCommentTrue").click(function (e) {
                    e.preventDefault();
                    $.ajax({
                        url: "<%=request.getContextPath()%>/adminComment/commentTrue.htm",
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