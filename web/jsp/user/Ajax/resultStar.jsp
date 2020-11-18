<%-- 
    Document   : loadStar
    Created on : Oct 19, 2020, 1:06:58 PM
    Author     : Bang-GoD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<c:if test="${avg!=0}">
    <h3 class="rateyo"data-rateyo-rating="${avg}" data-rateyo-num-stars="5"  data-rateyo-score="4"></h3>
</c:if> 
<c:if test="${avg==0}">
    <h4>Chưa Ai Đánh Giá</h4>
</c:if>
<c:choose>
    <c:when test = "${users.userId!=null and star==null}">
        <form method="rate.htm" method="post" id="formResult">
            <input type="hidden" value="${product.prodId}" id="prodIdResult" name="prodId" >
            <input class="star star-5" id="star-10" value="5" type="radio" name="rateSubmit2"/>
            <label class="star star-5"  for="star-10"></label>
            <input class="star star-4" id="star-9" value="4" type="radio" name="rateSubmit2"/>
            <label class="star star-4" for="star-9"></label>
            <input class="star star-3" id="star-8" value="3" type="radio" name="rateSubmit2"/>
            <label class="star star-3" for="star-8"></label>
            <input class="star star-2" id="star-7" value="2" type="radio" name="rateSubmit2"/>
            <label class="star star-2" for="star-7"></label>
            <input class="star star-1" id="star-6"  value="1" type="radio" name="rateSubmit2"/>
            <label class="star star-1" for="star-6"></label>
            <input type="submit" id="rateSubmit" value="Submit">
        </form>
    </c:when>
    <c:when test = "${users.userId!=null and star!=null}">
        <input type="hidden" value="${product.prodId}" id="prodIdResult" name="prodId" >
        <span> Rate của bạn trước đó là ${star.mark}<i class="fa fa-star" style="color: red"></i>
            <input id="deleteResult" type="submit" value="Xóa">
        </span>
    </c:when>
    <c:otherwise>
        <span>Bạn Phải Đăng Nhập Để Bình Chọn</span>
    </c:otherwise>
</c:choose>
<script>
    jQuery(document).ready(function ($) {
        $(".rateyo").rateYo({
            readOnly: "true",
        });
        $('#deleteResult').click(function (e) {
            e.preventDefault();
            var prodId = $("#prodIdResult").val();
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
                    alert('sai');
                }
            });
        });
        $('#formResult').submit(function (e) {
            e.preventDefault();
            var rateSubmit = $('input[name=rateSubmit2]:checked').val();
            var prodId = $("#prodIdResult").val();
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
                    alert('sai');
                }
            });
        });
    });
</script>
