<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <jsp:include page="header.jsp"/>
        <jsp:include page="banner.jsp"/>
        <section class="blog-details spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-5 order-md-1 order-2">
                        <div class="blog__sidebar">
                            <div class="blog__sidebar__search">
                            </div>
                            <div class="blog__sidebar__item">
                            </div>
                            <div class="blog__sidebar__item">
                                <h4>Recent News</h4>
                                <c:forEach items="${newTimeBlog}" begin="0" end="1" var="newTimeBlog">
                                    <div class="blog__sidebar__recent">

                                        <a href="<%=request.getContextPath()%>/blog/details.htm?blogId=${newTimeBlog.blogId}" class="blog__sidebar__recent__item">
                                            <div class="blog__sidebar__recent__item__pic">
                                                <img src="${newTimeBlog.imageLink}" height="100" width="100" alt="">
                                            </div>
                                            <div class="blog__sidebar__recent__item__text">
                                                <h6>${newTimeBlog.blogName}</h6>
                                                <span>${newTimeBlog.created} </span>
                                            </div>
                                        </a>

                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-7 order-md-1 order-1">
                        <div class="blog__details__text">
                            <img src="${blog.imageLink}" alt="">
                            <h3>${blog.blogName}</h3>
                            <p>${blog.content}</p>
                        </div>
                        <div class="blog__details__content">
                            <div class="row">

                                <div class="col-lg-6">
                                    <div class="blog__details__widget">
                                        <ul>
                                            <li>${blog.created}</li>

                                        </ul>
                                        <div class="blog__details__social">
                                            <a href="#"><i class="fa fa-facebook"></i></a>
                                            <a href="#"><i class="fa fa-twitter"></i></a>
                                            <a href="#"><i class="fa fa-google-plus"></i></a>
                                            <a href="#"><i class="fa fa-linkedin"></i></a>
                                            <a href="#"><i class="fa fa-envelope"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </section>
        <!-- Blog Details Section End -->

        <!-- Related Blog Section Begin -->
        <section class="related-blog spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title related-blog-title">
                            <h2>Random Blog</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <c:forEach var="listRandom" begin="0" end="2" items="${listRandom}">
                        <div class="col-lg-4 col-md-4 col-sm-6">
                            <div class="blog__item">
                                <div class="blog__item__pic">
                                    <img src="${listRandom.imageLink}" alt="">
                                </div>
                                <div class="blog__item__text">
                                    <ul>
                                        <li><i class="fa fa-calendar-o"></i>${listRandom.created}</li>

                                    </ul>
                                    <h5><a href="<%=request.getContextPath()%>/blog/details.htm?blogId=${listRandom.blogId}">
                                            ${listRandom.blogName}</a></h5>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp"/>
        <jsp:include page="IncludeJs.jsp"/>
    </body>
</html>