<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<section class="hero">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="hero__categories">
                    <div class="hero__categories__all">
                        <i class="fa fa-bars"></i>
                        <span>All departments</span>
                    </div>
                    <ul>
                        <c:forEach items="${listCate}" var="listCate">
                            <li data-toggle="tooltip" title="${listCate.cateName}">
                                <a href="#">${listCate.cateName}</a></li>
                            </c:forEach>
                    </ul>
                </div>
            </div> 
            <div class="col-lg-9">
                <div class="hero__search">
                    <div class="hero__search__form">
                        <form action="" method="post">
                            <div class="hero__search__categories">
                                All Categories
                                <span class="arrow_carrot-down"></span>
                            </div>
                            <input type="text" name="search" id="autocomplete" >
                            <button type="submit"  class="site-btn">SEARCH</button>
                        </form>
                    </div>
                    <div class="hero__search__phone">
                        <div class="hero__search__phone__icon">
                            <i class="fa fa-phone"></i>
                        </div>
                        <div class="hero__search__phone__text">
                            <h5>0866933258</h5>
                            <span>support 24/7 time</span>
                        </div>
                    </div>
                </div>
                <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#carouselExampleCaptions" style="background-color:red" data-slide-to="0" class="active"></li>
                        <li data-target="#carouselExampleCaptions" style="background-color:red" data-slide-to="1"></li>
                        <li data-target="#carouselExampleCaptions" style="background-color:red" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                        <c:forEach begin="0" end="0" items="${listBanner}" var="listBanner">
                            <div class="carousel-item active">
                                <img src="${listBanner.imageLink}" class="d-block w-100" alt="...">
                                <div class="carousel-caption d-none d-md-block">
                                    <p style="color: orange">Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                                    <a href="#" class="primary-btn">SHOP NOW</a>
                                </div>
                            </div>
                        </c:forEach>
                        <c:forEach begin="1" end="2"  items="${listBanner}" var="listBanner">
                            <div class="carousel-item">
                                <img src="${listBanner.imageLink}" class="d-block w-100" alt="...">

                            </div>
                        </c:forEach>
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true" style="background-color: red"></span>
                        <span class="sr-only" >Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true" style="background-color: red"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    $(document).ready(function () {
    });
</script>