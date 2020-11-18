<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Danh Mục Sản Phẩm</h6>
        <h6 class="m-0 font-weight-bold text-primary">Tổng Số:${countCate}</h6>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <a class="btn btn-warning newCate">Thêm Mới</a>
            <table class="table table-bordered" id="orderTrue" width="100%" cellspacing="0">
                <thead >
                    <tr >
                        <th>STT</th>
                        <th>Tên Danh Mục</th>  
                        <th>Mô Tả</th>  
                        <th>Độ Ưu Tiên</th>
                        <th>Trạng Thái</th>
                        <th>Số sản phẩm</th>
                        <th>Chức Năng</th>
                    </tr>
                </thead> 
                <tbody>
                    <c:forEach items="${listCate}" varStatus="index" var="listCate">                        
                        <tr class="table-Light">
                            <td>${index.index+1}</td>
                            <td>${listCate.cateName}</td>
                            <td>${listCate.cateTitle}</td>
                            <td>${listCate.prioritys}</td>
                            <td>${listCate.cateStatus} </td>
                            <td hidden class="cateIda">${listCate.cateId}</td>
                            <td class="loadCateId"></td>
                            <td><a  href="${listCate.cateId}" class="btn btn-success editCate">Sửa</a>
                                <a  href="${listCate.cateId}" class="btn btn-success deleteCate">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="pagination">
                <input type="hidden" value="${sortCate}" id="sortCategories">
                <input type="hidden" value="${searchCate}" id="searchCate">
                <input type="hidden" value="${pageCate}" id="pageCategories">
                <c:if test="${pageCate > 1}">
                    <a href="${pageCate-1}" class="pageCate"><i class="fa fa-arrow-left"></i></a>
                    </c:if>
                    <c:forEach begin="1" end="${maxPagesCate}" step="1" varStatus="i">
                        <c:choose>
                            <c:when test="${pageCate == i.index}">
                            <span style="color: red;background-color: #0c5460">${i.index}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${i.index}" class="pageCate"><span>${i.index}</span></a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                <c:if test="${pageCate + 1 <= maxPagesCate}">
                    <a href="${pageCate+1}" class="pageCate"><i class="fa fa-arrow-right"></i></a>
                    </c:if>
            </div>
        </div>
    </div>
</div>
<script>
    jQuery(document).ready(function ($) {
        $(".pageCate").click(function (e) {
            e.preventDefault();
            var search = $("#searchCate").val();
            var sort = $("#sortCategories").val();
            var pageCate = $(this).attr('href');
            $.ajax({
                url: "<%=request.getContextPath()%>/adminCategories/dataCategories.htm",
                type: 'POST',
                data: {pageCate: pageCate, search: search, sort: sort},
                success: function (response) {
                    $("#dataCategories").html(response);

                }, error: function (response) {
                    alert('sai');
                }
            });
        });
        $(".deleteCate").click(function (e) {
            e.preventDefault();
            var cateId = $(this).attr('href');
            var row = $(this).closest("tr");
            var td = row.find(".loadCateId").text();
            var search = $("#searchCate").val();
            var sort = $("#sortCategories").val();
            var pageCate = $("#pageCategories").val();
            if (td === "0") {
                $.ajax({
                    url: "<%=request.getContextPath()%>/adminCategories/dataCategories.htm",
                    type: 'POST',
                    data: {pageCate: pageCate, search: search, sort: sort, cateId: cateId},
                    success: function (response) {
                        $("#dataCategories").html(response);
                    }, error: function (response) {
                        alert('sai');
                    }
                });
            } else {
                alert("Xóa "+td+" sản phẩm trước đi");
            }
        });

        $(".newCate").click(function (e) {
            e.preventDefault();
            $('.modal-body').load('<%=request.getContextPath()%>/adminCategories/initNew.htm', function () {

                $('#modalCate').modal({show: true});

            });
        });
        $(".editCate").click(function (e) {
            var cateId = $(this).attr('href');
            e.preventDefault();
            $('.modal-body').load('<%=request.getContextPath()%>/adminCategories/initEdit.htm', {cateId: cateId}, function () {

                $('#modalCate').modal({show: true});

            });
        });
        $(".cateIda").each(function (index) {
            var cateId = $(this).text();
            ajax(cateId, index);
        });
        function ajax(cateId, index) {
            $.ajax({
                url: "<%=request.getContextPath()%>/adminCategories/loadCount.htm",
                type: 'POST',
//                async: false,
                data: {cateId: cateId},
                success: function (response) {

                    $('.loadCateId:eq(' + (index) + ')').text(response);

                }, error: function (response) {
                    alert('sai');
                }
            });
        }
    });
</script>
