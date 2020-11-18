<%-- 
    Document   : deleteStar
    Created on : Sep 13, 2020, 1:15:25 PM
    Author     : Bang-GoD
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${avg!=0}">
    <h3 class="rateyo" data-rateyo-rating="${avg}" data-rateyo-num-stars="5" data-rateyo-score="4"></h3>
</c:if> 
<input type="hidden" value="${product.prodId}" id="prodIdStart1" name="prodId" >
<input type="hidden" value="${users.userId}"  id="userIdStart1" name="userId" >
<span> Rate của bạn trước đó là ${star.mark}<i class="fa fa-star" style="color: red"></i>
    <input id="deleteRate1" type="submit" value="Xóa">
</span>
<script>
    jQuery(document).ready(function ($) {
        $(".rateyo").rateYo({
            readOnly: "true",
        });
        $("#rateStar").hide();
        $('#deleteRate1').click(function (e) {

            e.preventDefault();
            var prodId = $("#prodIdStart1").val();
            var userId = $("#userIdStart1").val();
            $.ajax({
                url: 'deleteRate.htm',
                type: 'post',
                dataType: 'html',
                data: {prodId: prodId, userId: userId},
                success: function (response) {
                    $("#rateStar").hide();
                    $("#resultStar2").hide();
                    $("#resultStar1").show();
                    $("#resultStar1").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });

    });
</script>