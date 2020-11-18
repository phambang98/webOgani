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
                <input type="text" name="search" value="${search}" placeholder="Tìm Theo Tên" class="form-control" id="search">
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
        <form >
            <div class="form-group mx-sm-3 mb-2">                
                <input type="month" required="true" id="orderDate" min="${minDate}" max="${maxDate}">
                <button class="form-group mx-sm-3 mb-2 btn btn-warning" id="submitDate">In File Excel</button>
            </div>
        </form>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="orderTrue" width="100%" cellspacing="0">
                <thead >
                    <tr >
                        <th>STT</th>
                        <th>Hình Người Mua</th>  
                        <th>Tên Người Mua</th>  
                        <th>Tổng Tiền</th>
                        <th>Ngày Mua</th>
                        <th>Địa chỉ</th>
                        <th>Chi Tiết</th>

                    </tr>
                </thead> 
                <tbody>
                    <c:forEach items="${listTrue}" varStatus="index" var="list">                        
                        <tr class="table-Light">
                            <td>${index.index+1}</td>
                            <td><h5><img src="${list.users.userImage}" height="30" width="30"></h5></td>
                            <td><h5>${list.users.userName}</h5></td>
                            <td> <fmt:setLocale value = "en_US"/>
                                <fmt:formatNumber value = "${list.totalAmount}" type = "currency"/></td>
                            <td><fmt:formatDate type = "both" value = "${list.created}" /></td>
                            <td>${list.orderAddress}</td>
                            <td><a title="Xem Chi Tiết" href="${list.orderId}" class="btn btn-success orderTrue">Xem</a>
                                <a  href="<%=request.getContextPath()%>/adminOrder/inHoaDon.htm?orderId=${list.orderId}" 
                                    class="btn btn-danger inhoadon" >In Hoá Đơn</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="pagination">
                <input type="hidden" value="${sort}" id="sortTrue">
                <input type="hidden" value="${name}" id="nameTrue">
                <input type="hidden" value="${search}" id="searchTrue">
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
            var sort = $("#sortTrue").val();
            var search = $("#searchTrue").val();
            var name = $("#nameTrue").val();
            e.preventDefault();
            var page = $(this).attr("href");
            $.ajax({
                url: '<%=request.getContextPath()%>/adminOrder/orderTrue.htm',
                type: 'post',
                dataType: 'html',
                data: {search: search, sort: sort, name: name, page: page},
                success: function (response) {
                    $("#detailOrder").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });
        $('.orderTrue').click(function (e) {
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
                url: '<%=request.getContextPath()%>/adminOrder/orderTrue.htm',
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
            var nameTrue = $("#nameTrue").val();
            if (nameTrue === this.value)
            {
                $(this).attr('selected', 'selected');
            }
        });
        $("#sort option").each(function () {
            var sortTrue = $("#sortTrue").val();
            if (sortTrue === this.value)
            {
                $(this).attr('selected', 'selected');
            }
        });

        $(".inhoadon").click(function () {
            window.open(this.href);
            return false;
        });
        $("#submitDate").click(function (e) {
//            var orderDate = $("#orderDate").val();
            e.preventDefault();
            var date = $('#orderDate').val().split("-");
            var year = parseInt(date[0]);
            var month = parseInt(date[1]);
         
            window.open("<%=request.getContextPath()%>/adminOrder/inFileExcel.htm?month=" + month + "&year="+year+"");
            return false;

        });

    });
</script>