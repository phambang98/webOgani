<%@taglib  uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset=UTF-8">
        <meta name="description" content="Ogani Template">
        <meta name="keywords" content="Ogani, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Ogani</title>
        <jsp:include page="IncludeCss.jsp"/>
    </head>
    <body>
        <c:if test="${listCart==null||users==null}">
            <c:redirect url="${request.contextPath}/home/index.htm"/>  
        </c:if>
        <jsp:include page="header.jsp"/>
        <jsp:include page="banner.jsp"/>

        <section class="checkout spad">
            <div class="container">

                <div class="checkout__form">
                    <h4>Billing Details</h4>
                    <f:form action="${pageContext.request.contextPath}/orders/checkOut.htm" commandName="orders" method="post">
                        <div class="row">
                            <div class="col-lg-8 col-md-6">

                                <div class="checkout__input">
                                    <p>User Name<span>*</span></p>
                                    <f:input type="hidden" readonly="true" path="users.userId" value="${sessionScope.users.userId}"/>
                                    <f:input type="hidden" readonly="true" path="orderStatus" value=""/>
                                    <input readonly="true" required="true" type="text" value="${users.userName}" 
                                           placeholder="Nhập Tên" class="checkout__input__add"> 
                                </div>


                                <div class="checkout__input">
                                    <p>Address<span>*</span></p>
                                    <f:input required="true" type="text" value="${sessionScope.users.userAddress}" 
                                             path="orderAddress" placeholder="Street Address" class="checkout__input__add"/>         
                                </div>       
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Phone<span>*</span></p>
                                            <f:input type="text" value="${sessionScope.users.phone}" path="phone"/>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Email<span>*</span></p>
                                            <f:input required="true"  path="email" value="${sessionScope.users.userEmail}" />
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="checkout__order">
                                    <h4>Your Order</h4>
                                    <div class="checkout__order__products">Products<span>Total</span></div>
                                    <ul>
                                        <c:forEach items="${listCart}" var="lc">
                                            <li>${lc.product.prodName} <span>
                                                    <fmt:formatNumber currencySymbol="" 
                                                    value="${lc.quantity*lc.product.price-lc.quantity*lc.product.price*lc.product.discount/100}"> 
                                                    </fmt:formatNumber> VND

                                                </span></li>
                                            </c:forEach>
                                    </ul>

                                    <div class="checkout__order__total">Tổng Tiền phải trả <span>
                                            <input type="hidden" name="totalAmount" value="${tongtien}">
                                            <fmt:formatNumber currencySymbol="" value="${tongtien}"> 
                                            </fmt:formatNumber> VND</span></div>

                                    <div class="checkout__input__checkbox">
                                        <label for="payment">
                                            Check Payment
                                            <input type="checkbox" id="payment">
                                            <span class="checkmark"></span>
                                        </label>
                                    </div>

                                    <button type="submit" class="site-btn">PLACE ORDER</button>
                                </div>
                            </div>
                        </div>
                    </f:form>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp"/>
        <jsp:include page="IncludeJs.jsp"/>
    </body>
</html>