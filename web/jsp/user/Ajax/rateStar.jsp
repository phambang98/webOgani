<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${avg!=0}">
    <h3 class="rateyo"data-rateyo-rating="${avg}" data-rateyo-num-stars="5" data-rateyo-score="4"></h3>
</c:if> 
<input type="hidden" value="${product.prodId}" id="prodIdStart2" name="prodId" >
<input type="hidden" value="${users.userId}"  id="userIdStart2" name="userId" >
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
<input type="submit" id="rateSubmit2" value="Submit">
<script>
    jQuery(document).ready(function ($) {
        $(".rateyo").rateYo({
            readOnly: "true",
        });
        $("#rateStar").hide();
        $('#rateSubmit2').click(function (e) {
            e.preventDefault();

            var rateSubmit = $('input[name=rateSubmit2]:checked').val();
            var prodId = $("#prodIdStart2").val();
            var userId = $("#userIdStart2").val();
            if (rateSubmit == null)
            {
                rateSubmit = 0;
            }
            $.ajax({
                url: 'rate.htm',
                type: 'post',
                dataType: 'html',
                data: {rateSubmit: rateSubmit, prodId: prodId, userId: userId},
                success: function (response) {
                    $("#rateStar").hide();
                    $("#resultStar1").hide();
                    $("#resultStar2").show();
                    $("#resultStar2").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });
    });
</script>