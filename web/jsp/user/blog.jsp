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
        <section class="blog spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-5">
                        <div class="blog__sidebar">
                            <div class="blog__sidebar__search">
                            </div>
                            <div class="blog__sidebar__item">
                            </div>
                            <h4>Recent News</h4>
                            <c:forEach items="${newTimeBlog}" begin="0" end="1" var="newTimeBlog">
                                <div class="blog__sidebar__item">
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
                                </div>
                            </c:forEach>
                            <div class="blog__sidebar__item">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-7">
                        <div class="row">
                            <c:forEach items="${lp}" var="lp">
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="blog__item">
                                        <div class="blog__item__pic">
                                            <img src="${lp.imageLink}" alt="">
                                        </div>
                                        <div class="blog__item__text">
                                            <ul>
                                                <li><i class="fa fa-calendar-o"></i>${lp.created}</li>
                                            </ul>
                                            <h5><a href="#">${lp.blogName}</a></h5>
                                            <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam
                                                quaerat </p>
                                            <a href="<%=request.getContextPath()%>/blog/details.htm?blogId=${lp.blogId}" class="blog__btn">
                                                READ MORE <span class="arrow_right"></span></a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="col-lg-12">
                                <div class="product__pagination blog__pagination">
                                    <c:url value="getAll.htm" var="prev">
                                        <c:param name="page" value="${page-1}" />
                                    </c:url>
                                    <c:if test="${page > 1}">
                                        <a href="<c:out value="${prev}" />"><i class="fa fa-long-arrow-left"></i></a>
                                        </c:if>
                                        <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                                            <c:choose>
                                                <c:when test="${page == i.index}">
                                                <span style="color: red;background-color: #0c5460">${i.index}</span>
                                            </c:when>

                                            <c:otherwise>
                                                <c:url  value="getAll.htm" var="url">
                                                    <c:param name="page" value="${i.index}"/>
                                                </c:url>
                                                <a href='<c:out value="${url}" />'><span>${i.index}</span></a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <c:url  value="getAll.htm" var="next">
                                                <c:param name="page" value="${page + 1}"/>
                                            </c:url>
                                            <c:if test="${page + 1 <= maxPages}">
                                        <a href='<c:out value="${next}" />'><i class="fa fa-long-arrow-right"></i></a>
                                        </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
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
            </div>
        </section>
        <jsp:include page="footer.jsp"/>
        <jsp:include page="IncludeJs.jsp"/>
    </body>
</html>