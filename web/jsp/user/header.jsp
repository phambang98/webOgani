<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--<div id="preloder">
    <div class="loader"></div>
</div>-->
<!-- Moblie-->
<div class="humberger__menu__overlay"></div>
<div class="humberger__menu__wrapper">
    <div class="humberger__menu__logo">
        <a href="<%=request.getContextPath()%>/home/index.htm"><img src="../jsp/user/img/logo1.png" alt=""></a>
    </div>
    <div class="humberger__menu__cart">
        <ul>
            <c:if test="${sessionScope.users!=null}" >
                <li  data-toggle="tooltip" title="Đơn Hàng" > <a href="<%=request.getContextPath()%>/orders/myOrder.htm"><i class="fa fa-shopping-bag"></i></a></li>
                    </c:if>
                    <c:choose>
                        <c:when test = "${sessionScope.listCart==null}">

                    <li  data-toggle="tooltip" title="Giỏ Hàng"><a href="<%=request.getContextPath()%>/shoppingCart/myCart.htm">  <i class="fa fa-shopping-cart"></i> <span>0</span></a></li>
                    </c:when>
                    <c:when test = "${sessionScope.listCart!=null}">
                    <li data-toggle="tooltip" title="Giỏ Hàng"><a href="<%=request.getContextPath()%>/shoppingCart/myCart.htm">  <i class="fa fa-shopping-cart"></i> <span>${myCart}</span></a></li>
                    </c:when>

                <c:otherwise>
                </c:otherwise>
            </c:choose>
        </ul>
        <c:choose>
            <c:when test = "${sessionScope.users==null and sessionScope.tongtien==null}">
                <div class="header__cart__price">Tổng tiền:<span>0</span></div>
            </c:when>
            <c:when test = "${sessionScope.users==null and sessionScope.tongtien!=null}">
                <div class="header__cart__price">Tổng tiền: <span>${sessionScope.tongtien}</span></div>
            </c:when>
            <c:when test = "${users!=null and sessionScope.tongtien==null}">
                <div class="header__cart__price">Tổng tiền:<span>0</span></div>
            </c:when>
            <c:when test = "${users!=null and sessionScope.tongtien!=null}">
                <div class="header__cart__price">Tổng tiền: <span>${sessionScope.tongtien}</span></div>
            </c:when>
            <c:otherwise>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="humberger__menu__widget">
        <c:choose>
            <c:when test = "${sessionScope.users==null}">
                <div class="header__top__right__language">
                    <nav  class="main-nav">
                        <a class="signup" href="<%=request.getContextPath()%>/users/initSignup.htm"><i class="fa fa-user"></i>Sign up</a>
                    </nav>
                </div>
                <div class="header__top__right__auth">
                    <nav class="main-nav">
                        <a class="signin" href="<%=request.getContextPath()%>/users/initSignin.htm"><i class="fa fa-user"></i>Sign in</a>
                    </nav>
                </div>
            </c:when>
            <c:when test = "${sessionScope.users!=null}">
                <div class="header__top__right__language">
                    <nav  class="main-nav">

                        <span>Hello ${sessionScope.users.userName}</span>
                        <img src="${sessionScope.users.userImage}"  width="30px">
                    </nav>
                </div>
                <div class="header__top__right__auth">
                    <nav class="main-nav">
                        <a class="signin" href="<%=request.getContextPath()%>/users/logout.htm"><i class="fa fa-user"></i>Đăng Xuất</a>
                    </nav>
                </div>
            </c:when>

            <c:otherwise>
            </c:otherwise>
        </c:choose>
    </div>
    <nav class="humberger__menu__nav mobile-menu">
        <ul>
            <li class="active"><a href="<%=request.getContextPath()%>/home/index.htm">Home</a></li>
            <li><a href="<%=request.getContextPath()%>/shop/getAll.htm">Shop</a></li>
            <li><a href="<%=request.getContextPath()%>/blog/getAll.htm">Blog</a></li>
            <li><a href="<%=request.getContextPath()%>/contact/index.htm">Contact</a></li>
        </ul>
    </nav>
    <div id="mobile-menu-wrap"></div>

    <div class="humberger__menu__contact">
        <ul>
            <c:forEach items="${listContact}" var="listContact" begin="0" end="1">
                <li><i class="fa fa-envelope"></i>${listContact.email}</li>
                </c:forEach>
            <li> Free Shipping for all Order of $99</li>

        </ul>
    </div>
</div>
<!--PC-->
<header class="header">
    <div class="header__top">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="header__top__left">
                        <ul>
                            <c:forEach items="${listContact}" var="listContact" begin="0" end="0">
                                <li><i class="fa fa-envelope"></i>${listContact.email}</li>
                                </c:forEach>
<!--                            <li>Free Shipping for all Order of $199</li>-->
                        </ul>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="header__top__right">
                        <c:if test="${sessionScope.users==null}"> 
                            <div class="header__top__right__language">
                                <nav  class="main-nav">
                                    <a class="signup" href="<%=request.getContextPath()%>/users/initSignup.htm"><i class="fa fa-user"></i>Sign up</a>
                                </nav>
                            </div>
                            <div class="header__top__right__auth">
                                <nav class="main-nav">
                                    <a class="signin" href="<%=request.getContextPath()%>/users/initSignin.htm"><i class="fa fa-user"></i>Sign in</a>
                                </nav>
                            </div>
                        </c:if>
                        <c:if test="${sessionScope.users!=null}"> 
                            <div class="header__top__right__language">
                                <nav  class="main-nav">
                                    <a href="<%=request.getContextPath()%>/users/profile.htm" ><span>Hello ${sessionScope.users.userName}</span>
                                        <img src="${sessionScope.users.userImage}"  width="30px"></a>
                                </nav>
                            </div>
                            <div class="header__top__right__auth">
                                <nav class="main-nav">
                                    <a class="signin" href="<%=request.getContextPath()%>/users/logout.htm"><i class="fa fa-user"></i>Đăng Xuất</a>
                                </nav>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="header__logo">
                    <a href="<%=request.getContextPath()%>/home/index.htm"><img src="../jsp/user/img/logo.png" alt=""></a>
                </div>
            </div>
            <div class="col-lg-6">
                <nav class="header__menu">
                    <ul>
                        <li class="active"><a href="<%=request.getContextPath()%>/home/index.htm">Home</a></li>
                        <li><a href="<%=request.getContextPath()%>/shop/getAll.htm">Shop</a></li>
                        <li><a href="<%=request.getContextPath()%>/blog/getAll.htm">Blog</a></li>
                        <li><a href="<%=request.getContextPath()%>/contact/index.htm">Contact</a></li>
                    </ul>
                </nav>
            </div>
            <div class="col-lg-3">
                <div class="header__cart">
                    <ul>
                        <c:if test="${sessionScope.users!=null}" >
                            <li data-toggle="tooltip" title="Đơn Hàng" ><a href="<%=request.getContextPath()%>/orders/myOrder.htm"><i class="fa fa-shopping-bag"></i></a></li>
                                </c:if>
                                <c:choose>
                                    <c:when test = "${sessionScope.listCart==null}">
                                <li data-toggle="tooltip" title="Giỏ Hàng"><a href="<%=request.getContextPath()%>/shoppingCart/myCart.htm"><i class="fa fa-shopping-cart"></i> <span>0</span></a></li>
                                </c:when>

                            <c:when test = "${sessionScope.listCart!=null}">
                                <li data-toggle="tooltip" title="Giỏ Hàng"><a href="<%=request.getContextPath()%>/shoppingCart/myCart.htm"><i class="fa fa-shopping-cart"></i><span>${myCart}</span></a></li>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                    </ul>
                    <c:choose>
                        <c:when test = "${sessionScope.users==null and sessionScope.tongtien==null}">
                            <div class="header__cart__price">Tổng tiền:<span>0</span></div>
                        </c:when>
                        <c:when test = "${sessionScope.users==null and sessionScope.tongtien!=null}">
                            <div class="header__cart__price">Tổng tiền: <span>${tongtien}</span></div>
                        </c:when>
                        <c:when test = "${sessionScope.users!=null and sessionScope.tongtien==null}">
                            <div class="header__cart__price">Tổng tiền:<span>0</span></div>
                        </c:when>
                        <c:when test = "${sessionScope.users!=null and sessionScope.tongtien!=null}">
                            <div class="header__cart__price">Tổng tiền: <span>${tongtien}</span></div>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <div class="humberger__open">
            <i class="fa fa-bars"></i>
        </div>
    </div>
</header>