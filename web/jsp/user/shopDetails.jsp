<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <link rel="stylesheet" href="../jsp/user/css/comment.css" type="text/css">
        <link rel="stylesheet" href="../jsp/user/css/rating.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.css">
        <jsp:include page="IncludeCss.jsp"/>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="banner.jsp"/>
        <section class="product-details spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="product__details__pic">
                            <div class="product__details__pic__item">
                                <img class="product__details__pic__item--large"
                                     src="${product.imageLink}" alt="">
                            </div>
                            <div class="product__details__pic__slider owl-carousel">
                                <img data-imgbigurl="${product.imageLink}"
                                     src="${product.imageLink}" data-toggle="tooltip" title="Main Image">
                                <c:if test="${listImage!=null}">
                                    <c:forEach items="${listImage}" var="listImage">
                                        <img data-imgbigurl="${listImage.imageLink}"
                                             src="${listImage.imageLink}" alt="">
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="product__details__text">
                            <h3>${product.prodName}</h3>

                            <div class="stars" id="rateStar">
                                <c:if test="${avg!=0}">
                                    <h3 class="rateyo" data-rateyo-rating="${avg}" data-rateyo-num-stars="5"  data-rateyo-score="4"></h3>
                                </c:if> 
                                <c:if test="${avg==0}">
                                    <h4>Chưa Ai Đánh Giá</h4>
                                </c:if>
                                <c:choose>
                                    <c:when test = "${users.userId!=null and star==null}">
                                        <form method="rate.htm" method="post" id="formRate">
                                            <input type="hidden" value="${product.prodId}" id="prodIdStart" name="prodId" >
                                            <input class="star star-5" id="star-5" value="5" type="radio" name="rateSubmit"/>
                                            <label class="star star-5" for="star-5"></label>
                                            <input class="star star-4" id="star-4" value="4" type="radio" name="rateSubmit"/>
                                            <label class="star star-4" for="star-4"></label>
                                            <input class="star star-3" id="star-3" value="3" type="radio" name="rateSubmit"/>
                                            <label class="star star-3" for="star-3"></label>
                                            <input class="star star-2" id="star-2" value="2" type="radio" name="rateSubmit"/>
                                            <label class="star star-2" for="star-2"></label>
                                            <input class="star star-1" id="star-1" value="1" type="radio" name="rateSubmit"/>
                                            <label class="star star-1" for="star-1"></label>
                                            <input type="submit" id="rateSubmit" value="Submit">
                                        </form>
                                    </c:when>
                                    <c:when test = "${users.userId!=null and star!=null}">
                                        <input type="hidden" value="${product.prodId}" id="prodIdStart" name="prodId" >
                                        <span> Rate của bạn trước đó là ${star.mark}<i class="fa fa-star" style="color: red"></i>
                                            <input id="deleteRate" type="submit" value="Xóa">
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>Bạn Phải Đăng Nhập Để Bình Chọn</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="stars" id="resultStar">
                            </div>
                            <div class="product__details__price">
                                <fmt:formatNumber currencySymbol="" value="${product.price-(product.price*product.discount/100)}"> 
                                </fmt:formatNumber> VND
                            </div>
                            <p>${product.title}
                            </p>
                            <form action="<%=request.getContextPath()%>/shoppingCart/addCart.htm?prodId=${product.prodId}"
                                  method="post">
                                <div class="product__details__quantity">
                                    <div class="quantity">
                                        <div class="pro-qty">
                                            <input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' id="quantity" name="quantity" value="1">
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${product.prodStatus==true&&product.categories.cateStatus==true}">
                                    <input type="submit" class="primary-btn" value="ADD TO CARD">
                                </c:if>
                                <c:if test="${product.prodStatus==false||product.categories.cateStatus==false}">
                                    <input type="submit" class="primary-btn" value="ADD TO CARD" id="addCart">
                                </c:if>
                            </form>
                            <ul>
                                <li><b>Thuộc Danh Mục</b> <span>${product.categories.cateName}</span></li>
                                <li><b>Giảm Giá</b> <span>${product.discount}%</span></li>
                                <li><b>Trạng Thái</b> <span>
                                        <c:if test="${product.prodStatus==true&&product.categories.cateStatus==true}">
                                            Còn Hàng
                                        </c:if>
                                        <c:if test="${product.prodStatus==false||product.categories.cateStatus==false}">
                                            Hết Hàng
                                        </c:if>
                                    </span></li>
                                <li><b>Share on</b>
                                    <div class="share">
                                        <a href=""><i class="fa fa-facebook"></i></a>
                                        <a href=""><i class="fa fa-twitter"></i></a>
                                        <a href=""><i class="fa fa-instagram"></i></a>
                                        <a href=""><i class="fa fa-pinterest"></i></a>
                                    </div>
                                </li>
                            </ul>
                        </div>

                    </div>
                    <div class="col-lg-12">
                        <div class="product__details__tab">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab" aria-selected="true">Bình Luận <span></span></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab" aria-selected="false">Title</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab" aria-selected="false">Description</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                    <div class="product__details__tab__desc">
                                        <div class="row" id="showAllComment">

                                        </div>
                                        <div class="row">
                                            <div class="container">
                                                <form method="post" id="commentForm" action="#" >
                                                    <div class="form-group">
                                                        <label for="comment">Comment:</label>
                                                        <label id="ReplyComment"></label>
                                                        <input type="hidden" id="commentProdId" value="${product.prodId}" name="prodId"> 
                                                        <textarea required class="form-control" name="content" id="commentContent"></textarea>
                                                        <input  name="commentStatus" id="commentStatus" type="hidden"value="false">
                                                        <input  name="commentParentId" id="commentParentId" type="hidden" value="0">
                                                        <input type="hidden" id="commentUserId" value="${sessionScope.users.userId}">
                                                        <input type="submit" value="Gửi">
                                                        <a class="btn" id="NoReply"><i class="fa fa-trash"></i> Không Trả lời nữa</a>

                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tabs-2" role="tabpanel">
                                    <div class="product__details__tab__desc">
                                        <h6>${product.title}</h6>
                                        <p></p>
                                        <p></p>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tabs-3" role="tabpanel">
                                    <div class="product__details__tab__desc">
                                        <h6>${product.descriptions}</h6>
                                        <p>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div class="modal fade bd-example-modal-lg" id="ModalEditComment" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" style="color: red">Edit Comment</h3>

                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>   
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
        <jsp:include page="IncludeJs.jsp"/>
        <script src="../jsp/ckeditor/ckeditor.js" type="text/javascript"></script>
        <script src="../jsp/ckfinder/ckfinder.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>
        <script>
                                                jQuery(document).ready(function ($) {
                                                    var proQty = $('.pro-qty');
                                                    proQty.prepend('<span class="dec qtybtn">-</span>');
                                                    proQty.append('<span class="inc qtybtn">+</span>');
                                                    proQty.on('click', '.qtybtn', function () {
                                                        var $button = $(this);
                                                        var oldValue = $button.parent().find('input').val();
                                                        if ($button.hasClass('inc')) {
                                                            var newVal = parseFloat(oldValue) + 1;
                                                        } else {
                                                            // Don't allow decrementing below zero
                                                            if (oldValue > 0) {
                                                                var newVal = parseFloat(oldValue) - 1;
                                                            } else {
                                                                newVal = 0;
                                                            }
                                                        }
                                                        $button.parent().find('input').val(newVal);
                                                    });
                                                    $("#quantity").keyup(function () {

                                                        if ($("#quantity").val() == "")
                                                        {
                                                            $("#quantity").val(1);
                                                        }
                                                    });

                                                    $("#resultStar").hide();
                                                    $('#deleteRate').click(function (e) {
                                                        e.preventDefault();
                                                        var prodId = $("#prodIdStart").val();
                                                        $.ajax({
                                                            url: 'deleteRate.htm',
                                                            type: 'post',
                                                            dataType: 'html',
                                                            data: {prodId: prodId},
                                                            success: function (response) {
                                                                $("#rateStar").hide();
                                                                $("#resultStar").show();
                                                                $("#resultStar").html(response);
                                                            },
                                                            error: function (response) {
                                                                location.reload();
                                                            }
                                                        });
                                                    });
                                                    $('#formRate').submit(function (e) {
                                                        e.preventDefault();
                                                        var rateSubmit = $('input[name=rateSubmit]:checked').val();
                                                        var prodId = $("#prodIdStart").val();

                                                        if (rateSubmit == null)
                                                        {
                                                            rateSubmit = 0;
                                                        }
                                                        $.ajax({
                                                            url: 'rate.htm',
                                                            type: 'post',
                                                            dataType: 'html',
                                                            data: {rateSubmit: rateSubmit, prodId: prodId},
                                                            success: function (response) {
                                                                $("#rateStar").hide();
                                                                $("#resultStar").show();
                                                                $("#resultStar").html(response);
                                                            },
                                                            error: function (response) {
                                                                location.reload();
                                                            }
                                                        });
                                                    });
                                                    $.get("loadAllComment.htm?prodId=${product.prodId}", function (data) {
                                                        $("#showAllComment").html(data);
                                                    });
                                                    //thêm mới
                                                    $("#commentForm").submit(function (e) {
                                                        e.preventDefault();
                                                        var userId = $("#commentUserId").val();
                                                        if (userId == "")
                                                        {
                                                            alert('Đăng Nhập đi Rồi Bình luận');
                                                        } else {
                                                            var commentProdId = $("#commentProdId").val();
                                                            var commentContent = $("#commentContent").val();
                                                            var commentParentId = $("#commentParentId").val();
                                                            $.ajax({
                                                                url: 'createComment.htm',
                                                                type: 'post',
                                                                dataType: 'html',
                                                                data: {prodId: commentProdId, content: commentContent, parentId: commentParentId},
                                                                success: function (response) {
                                                                    $("#commentContent").val("");
                                                                    $("#showAllComment").show();
                                                                    $("#showAllComment").html(response);
                                                                    var id = parseInt("0");
                                                                    $("#commentParentId").val(id);
                                                                    alert('Vui Lòng Chờ Admin Duyệt');
                                                                    $("#ReplyComment").hide();
                                                                },
                                                                error: function (response) {
                                                                    alert('sai');
                                                                }
                                                            });
                                                        }
                                                    });
                                                    $("#NoReply").hide();
                                                    $("#NoReply").click(function ()
                                                    {
                                                        var id = parseInt("0");
                                                        $("#commentParentId").val(id);
                                                        $("#ReplyComment").hide();
                                                        $("#NoReply").hide();
                                                    });
                                                    //Trả lời bình luận
                                                    $(".replyComment").click(function (e) {
                                                        e.preventDefault();
                                                        $("#NoReply").show();
                                                        $("#commentForm").focus();
                                                        var parentId = $(this).attr("href");
                                                        $("#commentParentId").val(parentId);
                                                        $("#ReplyComment").load("repComment.htm", {commentId: parentId}, function (response) {

                                                            $("#ReplyComment").show();
                                                            $("#ReplyComment").val(response);
                                                        });
                                                    });

                                                    $(".rateyo").rateYo({
                                                        readOnly: "true",
                                                    });

                                                    $("#addCart").click(function (e) {
                                                        e.preventDefault();
                                                        alert('Hết Hàng Rồi');
                                                    });

                                                });
        </script>
    </body>
</html>