<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
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
                                Thông Tin Shop
                            </h1>
                            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
                        </div>
                        <div id="dataBlog">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Tổng số bài viết:${countBlog}</h6>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <a class="btn btn-warning newContact">Thêm Mới</a>
                                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>STT</th>
                                                    <th>Email </th>     
                                                    <th>Phone </th>     
                                                    <th>Địa Chỉ</th>         
                                                    <th>Chức Năng</th>
                                                </tr>
                                            </thead>
                                            <tfoot>
                                                <c:forEach items="${listContact}" var="listContact" varStatus="index">
                                                    <tr>
                                                        <td>${index.index+1}</td>
                                                        <td>${listContact.email}</td>
                                                        <td>${listContact.phone}</td>
                                                        <td>${listContact.contactAddress}</td>
                                                        <td><a title="Xem Chi Tiết" href="${listContact.id}" class="btn btn-info editContact" >Sửa</a>
                                                            <a title="Xem Chi Tiết" href="delete.htm?id=${listContact.id}" class="btn btn-danger" >Xóa</a>
                                                        </td>
<!--                                                        <td>
                                                            <a title="Xem Chi Tiết"  data-toggle="modal" href="${listContact.id}" class="btn btn-info editContact"  data-target="#modalContact" >Sửa1</a>
                                                        </td>-->
                                                    </tr>
                                                </c:forEach>
                                            </tfoot>
                                        </table>
                                    </div>
                                    <div class="pagination">
                                        <c:url value="View.htm" var="prev">
                                            <c:param name="page" value="${page-1}"/>
                                        </c:url>
                                        <c:if test="${page > 1}">
                                            <a href="<c:out value="${prev}" />" class="pn prev">Prev</a>
                                        </c:if>
                                        <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                                            <c:choose>
                                                <c:when test="${page == i.index}">
                                                    <span>${i.index}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:url value="View.htm" var="url">
                                                        <c:param name="page" value="${i.index}"/>
                                                    </c:url>
                                                    <a href='<c:out value="${url}" />'>${i.index}</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <c:url value="View.htm" var="next">
                                            <c:param name="page" value="${page + 1}"/>
                                        </c:url>
                                        <c:if test="${page + 1 <= maxPages}">
                                            <a href='<c:out value="${next}" />' class="pn next">Next</a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                <div class="modal fade bd-example-modal-lg" id="modalContact" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3 class="modal-title" style="color: red">Thông Tin Shop</h3>
        
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
                $(".newContact").click(function (e) {
                    e.preventDefault();
                    $('.modal-body').load('<%=request.getContextPath()%>/adminContact/initNew.htm', function () {

                        $('#modalContact').modal({show: true});
                    });
                });
                $(".editContact").click(function (e) {
                    var id = $(this).attr('href');
                    e.preventDefault();
                    $('.modal-body').load('<%=request.getContextPath()%>/adminContact/initEdit.htm', {id:id}, function () {

                        $('#modalContact').modal({show: true});
                    });
                });

            });
        </script>
    </body>
</html>