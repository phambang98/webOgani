<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                        <div class="row" id="dataUsers">

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade bd-example-modal-lg" id="modalUsers" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" style="color: red">Chi tiết Người Dùng</h3>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">

                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="IncludeJs.jsp"/>
        <script>
            jQuery(document).ready(function ($) {
                $("#dataUsers").load("dataUsers.htm", function () {

                });
                $("#productSearch").keyup(function () {
                    var search = $("#productSearch").val();
                    var productSort = $("#productSort option:selected").val();
                     var pageUsers = $("#pageUsers").val();
                    $.ajax({
                        url: "<%=request.getContextPath()%>/adminUsers/dataUsers.htm",
                        type: 'POST',
                        data: {search: search, sort: productSort,pageUsers:pageUsers},
                        success: function (response) {
                            $("#dataUsers").html(response);
                        }, error: function (response) {
                            alert('sai');
                        }
                    });
                });
                $('#productSort').on('change', function () {
                    var search = $("#productSearch").val().trim();
                    var productSort = $("#productSort option:selected").val();
                    var pageUsers = $("#pageUsers").val();
                    $.ajax({
                        url: '<%=request.getContextPath()%>/adminUsers/dataUsers.htm',
                        type: 'post',
                        dataType: 'html',
                        data: {search: search, sort: productSort,pageUsers:pageUsers},
                        success: function (response) {
                            $("#dataUsers").html(response);
                        }, error: function (response) {
                            alert('sai');
                        }
                    });
                });
            });
        </script>
    </body>
</html>