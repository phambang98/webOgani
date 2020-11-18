<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>In Hóa Đơn</title>
        <link href="../jsp/admin/css/InHoaDon.css" rel="stylesheet">
    </head>
    
    <body onload="window.print();">
       <c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
        <div id="page" class="page">
            <div class="header">
                <div class="logo"><img src="../jsp/user/img/logo.png"/></div>
                <div class="company">Công Ti TNHH 1 Thành Viên<br/>
                    Địa Chỉ Shop: ${contact.contactAddress}
                    <br/>
                    Email: ${contact.email}<br/>
                    Phone: ${contact.phone}</div>
            </div>
            <br/>
            <div class="title">
                HÓA ĐƠN THANH TOÁN
                <br/>
                -------oOo-------
            </div>
            <br/>
            <br/>
            <table class="TableData">
                <tr>
                    <th>STT</th>
                    <th>Tên</th>
                    <th>Đơn giá</th>
                    <th>Số Lượng</th>
                    <th>Thành tiền</th>
                </tr>
                <c:forEach varStatus="index" items="${list}" var="list">
                    <tr>
                        <td>${index.index+1}</td>
                        <td>${list.product.prodName}</td>
                        <td>
                            <fmt:setLocale value = "en_US"/>
                            <fmt:formatNumber value = " ${list.product.price}" type = "currency"/>
                        </td>
                        <td>
                            ${list.quantity}
                        </td>
                        <td>
                            <fmt:setLocale value = "en_US"/>
                            <fmt:formatNumber value = "${list.amount}" type = "currency"/>
                        </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="4" class="tong" style="color: red">Tổng cộng</td>
                    <td class="cotSo" style="color: red">
                        <fmt:setLocale value = "en_US"/>
                        <fmt:formatNumber value = " ${order.totalAmount}" type = "currency"/>
                    </td>
                </tr>
            </table>
            <div class="footer-left">Hà Nội,Ngày Mua :<br/> <fmt:formatDate type = "both" value = "${order.created}" /> <br/>
                Khách hàng <br/>${order.users.userName}
            </div>
            <div class="footer-right"> Ngày Xuất Hóa Đơn :
                <div id="MyClockDisplay" style="color: red" class="clock" onload="showTime()">
                </div>


                Nhân viên<br/>${isAdmin.name} </div>
        </div>
        <script>


            function showTime() {
                var date = new Date();
                var h = date.getHours();
                var m = date.getMinutes();
                var s = date.getSeconds();
                var session = "AM";
                var today =date.getDate() +'-'+(date.getMonth()+1)+'-'+date.getFullYear();
                if (h == 0) {
                    h = 12;
                }

                if (h > 12) {
                    h = h - 12;
                    session = "PM";
                }

                h = (h < 10) ? "0" + h : h;
                m = (m < 10) ? "0" + m : m;
                s = (s < 10) ? "0" + s : s;

                var time = h + ":" + m + ":" + s + " " + session;
                document.getElementById("MyClockDisplay").innerText =today+' .' + time;
                document.getElementById("MyClockDisplay").textContent =today+' .'+ time;

                setTimeout(showTime, 1000);

            }

            showTime();
        </script>
    </body>
</html>
