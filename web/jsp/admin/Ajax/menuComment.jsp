<%-- 
    Document   : menuComment
    Created on : Oct 1, 2020, 10:40:25 AM
    Author     : Bang-GoD
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
<a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <i class="fas fa-comment-slash"></i>
    <!-- Counter - Messages -->
    <span class="badge badge-danger badge-counter">${count}</span>
</a>
<!-- Dropdown - Messages -->
<div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
    <h6 class="dropdown-header">
        Comemnt Chưa Duyệt
    </h6>
    <c:forEach items="${list}" var="list">

        <a class="dropdown-item d-flex align-items-center" href="">
            <div class="dropdown-list-image mr-3">

                <img class="rounded-circle" src="${list.product.imageLink}" alt="">
                <div class="status-indicator bg-success"></div>
            </div>
            <div class="font-weight-bold">
                <div class="text-truncate">${list.product.prodName}</div>
                <div class="small text-gray-500">${list.content}</div>
            </div>
        </a>
    </c:forEach>

   
</div>

