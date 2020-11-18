<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Tổng số bài viết:${countBlog}</h6>
      
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <a class="btn btn-warning newBlog">Thêm Mới</a>
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên Blog</th>
                        <th>Nội Dung</th>
                        <th>Hình Ảnh</th>
                        <th>Ngày Tạo</th>
                        <th>Trạng Thái</th>         
                        <th>Chức Năng</th>
                    </tr>
                </thead>
                <tfoot>
                    <c:forEach items="${listBlog}" var="listBlog" varStatus="index">
                        <tr>
                            <td>${index.index+1}</td>
                            <td>${listBlog.blogName}</td>
                            <td>${listBlog.content}</td>
                            <td><img src="${listBlog.imageLink}" width="200" height="200"></td>
                            <td>${listBlog.created}</td>
                            <td>${listBlog.blogStatus}</td>
                            <td><a title="Xem Chi Tiết" href="${listBlog.blogId}" class="btn btn-info editBlog" >Sửa</a>
                                <a title="Xem Chi Tiết" href="${listBlog.blogId}" class="btn btn-danger deleteBlog" >Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tfoot>
            </table>
        </div>
        <div class="pagination">
            <input type="hidden" value="${sortBlog}" id="sortBlogs">
            <input type="hidden" value="${searchBlog}" id="searchBlog">
            <input type="hidden" value="${page}" id="pageBlog">
            <c:if test="${page > 1}">
                <a href="${page-1}" class="blogPagination"><i class="fa fa-arrow-left"></i></a>
                </c:if>
                <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                    <c:choose>
                        <c:when test="${page == i.index}">
                        <span style="color: red;background-color: #0c5460">${i.index}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${i.index}" class="blogPagination"><span>${i.index}</span></a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${page + 1 <= maxPages}">
                <a href="${page+1}" class="blogPagination"><i class="fa fa-arrow-right"></i></a>
                </c:if>
        </div>
    </div>
</div>
<script>
    jQuery(document).ready(function ($) {
        $(".blogPagination").click(function (e) {
            e.preventDefault();
            var search = $("#searchBlog").val();
            var sort = $("#sortBlogs").val();
            var pageBlog = $(this).attr('href');
            $.ajax({
                url: "<%=request.getContextPath()%>/adminBlog/dataBlog.htm",
                type: 'POST',
                data: {page: pageBlog, search: search, sort: sort},
                success: function (response) {
                    $("#dataBlog").html(response);
                }, error: function (response) {
                    alert('sai');
                }
            });
        });
        $(".deleteBlog").click(function (e) {
            e.preventDefault();
            var search = $("#searchBlog").val();
            var sort = $("#sortBlogs").val();
            var page = $("#pageBlog").val();
            var blogId = $(this).attr('href');
            $.ajax({
                url: "<%=request.getContextPath()%>/adminBlog/dataBlog.htm",
                type: 'POST',
                data: {page: page, search: search, sort: sort, blogId: blogId},
                success: function (response) {
                    $("#dataBlog").html(response);
                }, error: function (response) {
                    alert('sai');
                }
            });
        });
        
        $(".newBlog").click(function (e) {
           e.preventDefault();
            $('.modal-body').load('<%=request.getContextPath()%>/adminBlog/initNew.htm', function () {
              
                $('#modalBlog').modal({show: true});
              
            });
        });
        $(".editBlog").click(function (e) {
            var blogId=$(this).attr('href');
           e.preventDefault();
            $('.modal-body').load('<%=request.getContextPath()%>/adminBlog/initEdit.htm',{blogId:blogId}, function () {
              
                $('#modalBlog').modal({show: true});
              
            });
        });



    });
</script>
