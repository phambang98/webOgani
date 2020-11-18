<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${admins==null}">

    <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
</c:if>
<div class="card shadow mb-4">
    <div class="card-header py-3">

        <form action="#" method="post" id="form" class="form-inline">
            <h6 class="m-0 font-weight-bold text-primary">Tổng Số:${countProduct}</h6>
            <div class="form-group mx-sm-3 mb-2">   
                <input type="text" name="search" placeholder="Tìm Theo Tên" value="${searchProduct}" class="form-control" id="search">
                <select id="name" class="form-control">
                    <option value="">Để nguyên</option>
                    <option value="prodName">Tên</option>
                    <option value="price">Giá</option>

                </select>
                <select id="sort" class="form-control">
                    <option value="">Để nguyên</option>
                    <option value="ASC">Tăng</option>
                    <option value="DESC">Giảm</option>
                </select>

            </div>
            <button class="form-group mx-sm-3 mb-2 btn btn-success">Tìm</button>

        </form>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <a class="btn btn-warning newProduct">Thêm Mới</a>
            <table class="table table-bordered" id="orderTrue" width="100%" cellspacing="0">
                <thead >
                    <tr >
                        <th>STT</th>
                        <th>Hình Ảnh</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Giá</th>
                        <th>Giảm Giá</th>
                         <th>Mô Tả</th>  
                        <th>Chi Tiết</th>
                        <th>Ngày tạo</th>
                        <th>Thuộc Danh Mục</th>
                        <th>Trạng Thái</th>
                        <th>Chức Năng</th>
                    </tr>
                </thead> 
                <tbody>
                    <c:forEach items="${listProduct}" varStatus="index" var="listProduct">                        
                        <tr class="table-Light">
                            <td>${index.index+1}</td>
                            <td><image src="${listProduct.imageLink}" width="100"></td>
                            <td>${listProduct.prodName}</td>
                            <td> <fmt:setLocale value = "en_US"/>
                                <fmt:formatNumber value = " ${listProduct.price}" type = "currency"/>
                            </td>
                            <td>${listProduct.discount} %</td>
                               <td>${listProduct.title}</td>
                            <td>${listProduct.descriptions}</td>
                            <td>${listProduct.created}</td>
                            <td>${listProduct.categories.cateName}</td>
                            <td>${listProduct.prodStatus} </td>
                            <td><a  href="${listProduct.prodId}" class="btn btn-success editProduct">Sửa</a>
<!--                                <a  href="${listProduct.prodId}" class="btn btn-danger deleteProduct">Xóa</a>-->
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="pagination">
                <input type="hidden" value="${sortProduct}" id="sortProduct">
                <input type="hidden" value="${searchProduct}" id="searchProduct">
                <input type="hidden" value="${nameProduct}" id="nameProduct">
                <input type="hidden" value="${pageProduct}" id="pageProduct">
                <c:if test="${pageProduct > 1}">
                    <a href="${pageProduct-1}" class="pagesProduct"><i class="fa fa-arrow-left"></i></a>
                    </c:if>
                    <c:forEach begin="1" end="${maxPagesProduct}" step="1" varStatus="i">
                        <c:choose>
                            <c:when test="${pageProduct == i.index}">
                            <span style="color: red;background-color: #0c5460">${i.index}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${i.index}" class="pagesProduct"><span>${i.index}</span></a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                <c:if test="${pageProduct + 1 <= maxPagesProduct}">
                    <a href="${pageProduct+1}" class="pagesProduct"><i class="fa fa-arrow-right"></i></a>
                    </c:if>
            </div>
        </div>
    </div>
</div>
<script>
    jQuery(document).ready(function ($) {
        $(".pagesProduct").click(function (e) {
            e.preventDefault();
            var search = $("#searchProduct").val();
            var sort = $("#sortProduct").val();
            var name = $("#nameProduct").val();
            var pageProduct = $(this).attr('href');
            $.ajax({
                url: "<%=request.getContextPath()%>/adminProduct/dataProduct.htm",
                type: 'POST',
                data: {pageProduct: pageProduct, search: search, name: name, sort: sort},
                success: function (response) {
                    $("#dataProduct").html(response);

                }, error: function (response) {
                    alert('sai');
                }
            });
        });
        $(".deleteProduct").click(function (e) {
            e.preventDefault();
            var prodId = $(this).attr('href');
            var search = $("#searchProduct").val();
            var sort = $("#sortProduct").val();
            var pageProduct = $("#pageProduct").val();
            var name = $("#nameProduct").val();
            $.ajax({
                url: "<%=request.getContextPath()%>/adminProduct/dataProduct.htm",
                type: 'POST',
                data: {pageProduct: pageProduct, name: name, search: search, sort: sort, prodId: prodId},
                success: function (response) {
                    alert('ok');
                    $("#dataProduct").html(response);
                }, error: function (response) {
                    alert('sai');
                }
            });
        });

        $(".newProduct").click(function (e) {
            e.preventDefault();
            $('.modal-body').load('<%=request.getContextPath()%>/adminProduct/initNew.htm', function () {

                $('#modalProduct').modal({show: true});

            });
        });
        $(".editProduct").click(function (e) {
            var prodId = $(this).attr('href');
            e.preventDefault();
            $('.modal-body').load('<%=request.getContextPath()%>/adminProduct/initEdit.htm', {prodId: prodId}, function () {

                $('#modalProduct').modal({show: true});

            });
        });
        $("#form").submit(function (e) {
            e.preventDefault();
            var search = $("#search").val();
            var name = $("#name :selected").val();
            var sort = $("#sort :selected").val();

            $.ajax({
                url: '<%=request.getContextPath()%>/adminProduct/dataProduct.htm',
                type: 'post',
                dataType: 'html',
                data: {search: search, name: name, sort: sort},
                success: function (response) {
                    $("#dataProduct").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });
        $("#name option").each(function () {
            var nameProduct = $("#nameProduct").val();
            if (nameProduct === this.value)
            {
                $(this).attr('selected', 'selected');
            }
        });
        $("#sort option").each(function () {
            var sortProduct = $("#sortProduct").val();
            if (sortProduct === this.value)
            {
                $(this).attr('selected', 'selected');
            }
        });
    });
</script>
