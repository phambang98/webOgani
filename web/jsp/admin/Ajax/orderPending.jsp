<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<c:if test="${admins==null}">

    <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
</c:if>
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <form action="1" method="post" id="form" class="form-inline">
            <div class="form-group mx-sm-3 mb-2">   
                <input type="text" name="search" placeholder="Tìm Theo Tên" value="${search}" class="form-control" id="search">
                <select id="name" class="form-control">
                    <option value="">Để Nguyên</option>
                    <option value="users.userName">Tên</option>
                    <option value="totalAmount">Tổng Tiền</option>
                    <option value="created">Ngày</option>
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
            <table class="table table-bordered"  width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Hình Người Mua</th>  
                        <th>Tên Người Mua</th>  
                        <th>Tổng Tiền</th>
                        <th>Ngày Mua<br></th>
                        <th>Chức Năng</th>
                        <th><input type="checkbox" id="checkall" value='1'>&nbsp;
                            <input type="button" id="delete" value='Duyệt'></th>

                    </tr>
                </thead> 
                <tbody>
                    <c:forEach items="${listPending}" varStatus="index" var="list">                        
                        <tr class="table-Light">
                            <td>${index.index+1}</td>
                            <td><h5><img src="${list.users.userImage}" height="30" width="30"></h5></td>
                            <td><h5>${list.users.userName}</h5></td>
                            <td>
                                <fmt:setLocale value = "en_US"/>
                                <fmt:formatNumber value = "${list.totalAmount}" type = "currency"/>
                            </td>
                            <td><fmt:formatDate type = "both" value = "${list.created}" />
                            <td><a title="Xem Chi Tiết" href="${list.orderId}" class="btn btn-success orderPending">Xem</a>
                                <a title="Từ Chối" href="${list.orderId}" class="btn btn-success orderFalse">Từ Chối</a>
                            </td>
                            <td align='center'><input type="checkbox" class='checkbox' name='checkhang' value='${list.orderId}' ></td>

                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="pagination">
                <input type="hidden" value="${page}" id="pagePending">
                <input type="hidden" value="${sort}" id="sortPending">
                <input type="hidden" value="${name}" id="namePending">
                <input type="hidden" value="${search}" id="searchPending">
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
            var search = $("#searchPending").val();
            var sort = $("#sortPending").val();
            var name = $("#namePending").val();
            var page = $(this).attr("href");
            $.ajax({
                url: '<%=request.getContextPath()%>/adminOrder/orderPending.htm',
                type: 'post',
                dataType: 'html',
                data: {page: page, search: search, sort: sort, name: name},
                success: function (response) {
                    $("#detailOrder").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });
        $('.orderPending').click(function (e) {
            e.preventDefault();
            var orderId = $(this).attr('href');
            $('.modal-body').load('<%=request.getContextPath()%>/adminOrder/orderView.htm', {orderId: orderId}, function () {

                $('#myModal').modal({show: true});

            });
        });

        $("#form").submit(function (e) {

            e.preventDefault();

            var search = $("#search").val();
            var sort = $("#sort :selected").val();
            var name = $("#name :selected").val();
            $.ajax({
                url: '<%=request.getContextPath()%>/adminOrder/orderPending.htm',
                type: 'post',
                dataType: 'html',
                data: {search: search, sort: sort, name: name},
                success: function (response) {
                    $("#detailOrder").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });
        $("#name option").each(function () {
            var namePending = $("#namePending").val();
            if (namePending === this.value)
            {
                $(this).attr('selected', 'selected');
            }
        });
        $("#sort option").each(function () {
            var sortPending = $("#sortPending").val();
            if (sortPending === this.value)
            {
                $(this).attr('selected', 'selected');
            }
        });
        $("#checkall").change(function () {

            var checked = $(this).is(':checked');
            if (checked) {
                $(".checkbox").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".checkbox").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });
        $('#delete').click(function () {
            var true_arr = [];
            $(".checkbox:checked").each(function () {
                var true_orderId = $(this).val();
                true_arr.push(true_orderId);
            });
            var search = $("#searchPending").val();
            var sort = $("#sortPending").val();
            var page = $("#pagePending").val();

            var name = $("#namePending").val();
            var length = true_arr.length;
            if (length > 0) {
                // AJAX request
                $.ajax({
                    url: '<%=request.getContextPath()%>/adminOrder/orderPending.htm',
                    type: 'post',
                    data: {true_arr: true_arr, sort: sort, search: search, name: name, page: page},
                    success: function (response) {
                        $("#detailOrder").html(response);

                    }, error: function (jqXHR, textStatus, errorThrown) {
                        alert('sai');
                    }
                });
            } else {
                alert('Chưa Chọn Gì Hết');
            }
        });
        $("#checkFalse").change(function () {

            var checked = $(this).is(':checked');
            if (checked) {
                $(".checkFalse").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".checkFalse").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });
        $('.orderFalse').click(function (e) {
            e.preventDefault();
            var orderId = $(this).attr('href');
            var search = $("#searchPending").val();
            var sort = $("#sortPending").val();
            var page = $("#pagePending").val();
            var name = $("#namePending").val();
            $.ajax({
                url: '<%=request.getContextPath()%>/adminOrder/orderPending.htm',
                type: 'post',
                data: {orderId: orderId, sort: sort, search: search, name: name, page: page},
                success: function (response) {
                    $("#detailOrder").html(response);

                }, error: function (jqXHR, textStatus, errorThrown) {
                    alert('sai');
                }
            });

        });
    });
</script>