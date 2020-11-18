<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Tổng số bài viết:${countBanner}</h6>
      
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <a class="btn btn-warning newBanner">Thêm Mới</a>
            <table class="table table-bordered"  width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên Banner</th>
                        <th>Hình Ảnh</th>
                        <th>Độ Ưu Tiên</th>
                        <th>Trạng Thái</th>         
                        <th>Chức Năng</th>
                    </tr>
                </thead>
                <tfoot>
                    <c:forEach items="${listBanner}" var="listBanner" varStatus="index">
                        <tr>
                            <td>${index.index+1}</td>
                            <td>${listBanner.bannerName}</td>
                            <td><img src="${listBanner.imageLink}" width="150" height="150"></td>
                            <td>${listBanner.prioritys}</td>
                            <td>${listBanner.bannerStatus}</td>
                            <td><a title="Xem Chi Tiết" href="${listBanner.bannerId}" class="btn btn-info editBanner" >Sửa</a>
                                <a title="Xem Chi Tiết" href="${listBanner.bannerId}" class="btn btn-danger deleteBanner" >Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tfoot>
            </table>
        </div>
        <div class="pagination">
            <input type="hidden" value="${page}" id="pageBanner">
            <c:if test="${page > 1}">
                <a href="${page-1}" class="bannerPagination"><i class="fa fa-arrow-left"></i></a>
                </c:if>
                <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                    <c:choose>
                        <c:when test="${page == i.index}">
                        <span style="color: red;background-color: #0c5460">${i.index}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${i.index}" class="bannerPagination"><span>${i.index}</span></a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${page + 1 <= maxPages}">
                <a href="${page+1}" class="bannerPagination"><i class="fa fa-arrow-right"></i></a>
                </c:if>
        </div>
    </div>
</div>
<script>
    jQuery(document).ready(function ($) {
        $(".bannerPagination").click(function (e) {
            e.preventDefault();
            var pageBlog = $(this).attr('href');
            $.ajax({
                url: "<%=request.getContextPath()%>/adminBanner/dataBanner.htm",
                type: 'POST',
                data: {page: pageBlog},
                success: function (response) {
                    $("#dataBanner").html(response);
                }, error: function (response) {
                    alert('sai');
                }
            });
        });
        $(".deleteBanner").click(function (e) {
            e.preventDefault();
            var page = $("#pageBanner").val();
            var bannerId = $(this).attr('href');
            $.ajax({
                url: "<%=request.getContextPath()%>/adminBanner/dataBanner.htm",
                type: 'POST',
                data: {page: page,bannerId: bannerId},
                success: function (response) {
                    $("#dataBanner").html(response);
                }, error: function (response) {
                    alert('sai');
                }
            });
        });
        
        $(".newBanner").click(function (e) {
           e.preventDefault();
            $('.modal-body').load('<%=request.getContextPath()%>/adminBanner/initNew.htm', function () {
              
                $('#modalBanner').modal({show: true});
              
            });
        });
        $(".editBanner").click(function (e) {
           
            var bannerId=$(this).attr('href');
           e.preventDefault();
            $('.modal-body').load('<%=request.getContextPath()%>/adminBanner/initEdit.htm',{bannerId:bannerId}, function () {
              
                $('#modalBanner').modal({show: true});
              
            });
        });



    });
</script>