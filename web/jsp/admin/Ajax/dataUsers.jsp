<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${admins==null}">

    <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
</c:if>
<div class="card shadow mb-4">
    <div class="card-header py-3">

        <form action="#" method="post" id="form" class="form-inline">
            <h6 class="m-0 font-weight-bold text-primary">Tổng Số:${count}</h6>
            <div class="form-group mx-sm-3 mb-2">   
                <input type="text" name="search" value="${search}" placeholder="Tìm Theo Tên" class="form-control" id="search">
                <select id="name" class="form-control">
                    <option value="">Để Nguyên</option>
                    <option value="u.userName">Tên</option>
                    <option value="countStar">Luợt Đánh Giá</option>
                    <option value="countComment">Lượt Comment</option>
                    <option value="countBuy">Lượt Mua Hàng</option>
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
            <table class="table table-bordered" id="tableUsers" width="100%" cellspacing="0">
                <thead >
                    <tr >
                        <th>STT</th>
                        <th>Hình Ảnh</th>
                        <th>Tên Người Dùng</th>
                        <th>Email</th>
                        <th>Phone</th>  
                        <th>Địa chỉ</th>
                        <th>Trạng Thái</th>
                        <th>Lượt Đánh Giá</th>
                        <th>Lượt Comemnt</th>
                        <th>Lượt Mua Hàng</th>
                        <th>Chức Năng</th>
                    </tr>
                </thead> 
                <tbody>
                    <c:forEach items="${list}" varStatus="index" var="list">                        
                        <tr class="table-Light">
                            <td>${index.index+1}</td>
                            <td><image src="${list.users.userImage}" width="100"></td>
                            <td>${list.users.userName}</td>
                            <td>${list.users.userEmail}</td>
                            <td>${list.users.phone}</td>
                            <td>${list.users.userAddress}</td>
                            <td>${list.users.userStatus} </td>
                            <td class="loadStar">${list.countStar}</td>
                            <td class="loadComment">${list.countComment}</td>
                            <td class="loadBuy">${list.countBuy}</td>
                            <td>
                                <c:if test="${list.users.userStatus==true}">
                                    <a  href="${list.users.userId}" class="btn btn-success FalseUsers">Fasle</a>
                                </c:if>
                                <c:if test="${list.users.userStatus==false}">
                                    <a  href="${list.users.userId}" class="btn btn-success TrueUsers">True</a>
                                </c:if>
                                <a  href="${list.users.userId}" class="btn btn-danger deleteUsers">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="pagination">
                <input type="hidden" value="${sort}" id="sortUsers">
                <input type="hidden" value="${search}" id="searchUsers">
                <input type="hidden" value="${name}" id="nameUsers">
                <input type="hidden" value="${page}" id="pageUsers">
                <c:if test="${page > 1}">
                    <a href="${page-1}" class="page"><i class="fa fa-arrow-left"></i></a>
                    </c:if>
                    <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                        <c:choose>
                            <c:when test="${page == i.index}">
                            <span style="color: red;background-color: #0c5460">${i.index}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${i.index}" class="page"><span>${i.index}</span></a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                <c:if test="${page + 1 <= maxPages}">
                    <a href="${page+1}" class="page"><i class="fa fa-arrow-right"></i></a>
                    </c:if>
            </div>
        </div>
    </div>
</div>
<script>
    jQuery(document).ready(function ($) {
        $(".page").click(function (e) {
            e.preventDefault();
            var search = $("#searchUsers").val();
            var sort = $("#sortUsers").val();
            var name = $("#nameUsers").val();
            var page = $(this).attr('href');
            $.ajax({
                url: "<%=request.getContextPath()%>/adminUsers/dataUsers.htm",
                type: 'POST',
                data: {page: page, search: search, sort: sort, name: name},
                success: function (response) {
                    $("#dataUsers").html(response);

                }, error: function (response) {
                    alert('sai');
                }
            });
        });

        $(".deleteUsers").click(function (e) {
            e.preventDefault();
            var userId = $(this).attr('href');
            var search = $("#searchUsers").val();
            var sort = $("#sortUsers").val();
            var name = $("#nameUsers").val();
            var page = $("#pageUsers").val();
            var row = $(this).closest("tr");
            var star = row.find(".loadStar").text();
            var comment = row.find(".loadComment").text();
            var buy = row.find(".loadBuy").text();
            if (star === "0" && comment === "0" && buy === "0")
            {
                $.ajax({
                    url: "<%=request.getContextPath()%>/adminUsers/dataUsers.htm",
                    type: 'POST',
                    data: {page: page, search: search, name: name, sort: sort, userId: userId},
                    success: function (response) {
                        $("#dataUsers").html(response);
                    }, error: function (response) {
                        alert('sai');
                    }
                });
            } else {
                alert('3 chỉ số chưa bằng 0 kìa');
            }
        });

        $(".FalseUsers").click(function (e) {
            e.preventDefault();
            var search = $("#searchUsers").val();
            var sort = $("#sortUsers").val();
            var name = $("#nameUsers").val();
            var page = $("#pageUsers").val();
            var userId = $(this).attr('href');
            $.ajax({
                url: "<%=request.getContextPath()%>/adminUsers/dataUsers.htm",
                type: 'POST',
                data: {userId: userId, userStatus: false, page: page, search: search, name: name, sort: sort},
                success: function (response) {
                    $("#dataUsers").html(response);
                }, error: function (response) {
                    alert('sai');
                }
            });
        });
        $(".TrueUsers").click(function (e) {
            e.preventDefault();
            var userId = $(this).attr('href');
            var search = $("#searchUsers").val();
            var sort = $("#sortUsers").val();
            var name = $("#nameUsers").val();
            var page = $("#pageUsers").val();
            $.ajax({
                url: "<%=request.getContextPath()%>/adminUsers/dataUsers.htm",
                type: 'POST',
                data: {userId: userId, userStatus: true, page: page, search: search, name: name, sort: sort},
                success: function (response) {
                    $("#dataUsers").html(response);
                }, error: function (response) {
                    alert('sai');
                }
            });
        });
        $("#form").submit(function (e) {
            e.preventDefault();
            var search = $("#search").val();
            var sort = $("#sort :selected").val();
            var name = $("#name :selected").val();
            $.ajax({
                url: '<%=request.getContextPath()%>/adminUsers/dataUsers.htm',
                type: 'post',
                dataType: 'html',
                data: {search: search, sort: sort, name: name},
                success: function (response) {

                    $("#dataUsers").html(response);

                },
                error: function (response) {
                    alert('sai');
                }
            });
        });
        $("#name option").each(function () {
            var nameTrue = $("#nameUsers").val();
            if (nameTrue === this.value)
            {

                $(this).attr('selected', 'selected');
            }
        });
        $("#sort option").each(function () {
            var sortTrue = $("#sortUsers").val();
            if (sortTrue === this.value)
            {
                $(this).attr('selected', 'selected');
            }
        });

      
    });
</script>
