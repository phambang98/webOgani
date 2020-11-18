<%-- 
    Document   : menuOrder
    Created on : Oct 1, 2020, 10:40:34 AM
    Author     : Bang-GoD
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
<!DOCTYPE html>
<a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <i class="fas fa-shopping-bag"></i>
    <!-- Counter - Alerts -->
    <span class="badge badge-danger badge-counter">${count}</span>
</a>
<!-- Dropdown - Alerts -->
<div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">

    <h6 class="dropdown-header">
        Đơn Hàng Chưa Duyệt
    </h6>
    <c:forEach items="${list}" var="list">
        <a class="dropdown-item d-flex align-items-center" href="">
            <div class="mr-3">
                <div class="icon-circle bg-primary">
                   <i class="fas fa-luggage-cart text-white"></i>
                    
                </div>
            </div>
            <div>
                <div class="small " style="color: red">Tên Người Mua: ${list.users.userName}</div>
                <span class="font-weight-bold">
                    <fmt:setLocale value = "en_US"/>
                    <fmt:formatNumber value = "${list.totalAmount}" type = "currency"/>
                </span>
            </div>
        </a>
    </c:forEach>

   
</div>