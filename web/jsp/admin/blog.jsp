
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
                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-0 text-gray-800">
                                <input type="text" class="form-control border-0 small" id="searchBlog" placeholder="Search for...">
                            </h1>
                            <h1><select id="sortBlog" class="form-control">
                                    <option value="">Chưa Sắp Xếp</option>
                                    <option value="ASC">Tên Tăng Dần</option>
                                    <option value="DESC">Tên Giảm Dần</option>
                                </select></h1>
                            <a href="" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
                        </div>
                        <div id="dataBlog">

                        </div>

                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade bd-example-modal-lg" id="modalBlog" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" style="color: red">Blog</h3>

                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">

                    </div>
                    <!--                    <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>   
                                        </div>-->
                </div>
            </div>
        </div>


        <jsp:include page="IncludeJs.jsp"/>
       
        <script>
            jQuery(document).ready(function ($) {
                $("#dataBlog").load("<%=request.getContextPath()%>/adminBlog/dataBlog.htm", function () {
                });
                $("#searchBlog").keyup(function () {
                    var search = $("#searchBlog").val().trim();
                    var sort = $("#sortBlog option:selected").val();
                    var pageBlog = $("#pageBlog").val();
                    $.ajax({
                        url: "<%=request.getContextPath()%>/adminBlog/dataBlog.htm",
                        type: 'POST',
                        data: {search: search, sort: sort, page: pageBlog},
                        success: function (response) {
                            $("#dataBlog").html(response);
                        }, error: function (response) {
                            alert('sai');
                        }
                    });
                });

                $('#sortBlog').on('change', function () {
                    var search = $("#searchBlog").val().trim();
                    var sort = $("#sortBlog option:selected").val();
                    var pageBlog = $("#pageBlog").val();
                    $.ajax({
                        url: '<%=request.getContextPath()%>/adminBlog/dataBlog.htm',
                        type: 'post',
                        dataType: 'html',
                        data: {search: search, sort: sort, page: pageBlog},
                        success: function (response) {
                            $("#dataBlog").html(response);
                        }, error: function (response) {
                            alert('sai');
                        }
                    });
                });
            });
        </script>
    </body>
</html>