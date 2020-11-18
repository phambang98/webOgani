<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <form action="#" method="post" id="form" class="form-inline">
            <div class="form-group mx-sm-3 mb-2">   
                <input type="text" value="${search}" name="search" placeholder="Tìm Theo Tên" class="form-control" id="search">
               
                <select id="sort" class="form-control">
                    <option value="">Mời Bạn Chọn(Tổng Tiền)</option>
                    <option value="ASC">Tăng</option>
                    <option value="DESC">Giảm</option>
                </select>
            </div>
            <button class="form-group mx-sm-3 mb-2 btn btn-success">Tìm</button>
        </form>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered"  width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Hình Ảnh</th>  
                        <th>Tên Người Mua</th>
                        <th>Tổng Tiền<br></th>
                    </tr>
                </thead> 
                <tbody>
                    <c:forEach items="${pageList}" varStatus="index" var="pageList">                        
                        <tr class="table-Light">
                            <td>${index.index+1}</td>
                            <td><h5><img src="${pageList.users.userImage}" height="30" width="30"></h5></td>
                            <td>${pageList.users.userName}</td>
                            <td>
                                <fmt:setLocale value = "en_US"/>
                                <fmt:formatNumber value = "${pageList.totalAmount}" type = "currency"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="pagination">
                <input type="hidden" value="${search}" id="searchUsers">
                <input type="hidden" value="${sort}" id="sortUsers">
                <c:if test="${page > 1}">
                    <a href="${page-1}" class="pagea"><i class="fa fa-arrow-left"></i></a>
                    </c:if>
                    <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                        <c:choose>
                            <c:when test="${pagea == i.index}">
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
            var sort = $("#sortUsers :selected").val();
            var search = $("#searchUsers").val();
            var page = $(this).attr("href");
            $.ajax({
                url: '<%=request.getContextPath()%>/adminOrder/topUsers.htm',
                type: 'post',
                dataType: 'html',
                data: {page: page, search: search, sort: sort},
                success: function (response) {
                    $("#detailOrder").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });
        $("#form").submit(function (e) {
            e.preventDefault();
            var search = $("#search").val();
            var sort = $("#sort :selected").val();
            $.ajax({
                url: '<%=request.getContextPath()%>/adminOrder/topUsers.htm',
                type: 'post',
                dataType: 'html',
                data: {search: search, sort: sort},
                success: function (response) {
                    $("#detailOrder").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });

        $("#sort option").each(function () {
            var sortUsers = $("#sortUsers").val();
            if (sortUsers === this.value)
            {
                $(this).attr('selected', 'selected');
            }
        });
    });
</script>