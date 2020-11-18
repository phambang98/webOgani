<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 <c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Bình Luận Chưa Duyệt</h6>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="orderFalse" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Hình Người Mua</th>  
                        <th>Tên Người Mua</th>  
                        <th>Hình Sản Phẩm</th>
                        <th>Tên Sản Phẩm<br></th>
                        <th>Nội Dung</th>
                        <th>Đang Trả Lời</th>
                        <th>Nội Dung Trả Lời</th>
                        <th>Chức Năng</th>
                        <th><input type="checkbox" id="checkall" value='1'>&nbsp;
                            <input type="button" id="delete" value='Duyệt'></th>
                    </tr>
                </thead> 
                <tbody>
                    <c:forEach items="${listCommentFalse}" varStatus="index" var="False">                        
                        <tr class="table-Light">
                            <td>${index.index+1}</td>
                            <td><h5><img src="${False.users.userImage}" height="30" width="30"></h5></td>
                            <td>${False.users.userName}</td>
                            <td><h5><img src="${False.product.imageLink}" height="30" width="30"></h5></td>
                            <td>${False.product.prodName} </td>
                            <td>${False.content}</td>
                            <td hidden class="commentId">${False.parentId}</td>
                            <td class="usersRep"></td>
                            <td class="contentRep"></td>
                            <td><a title="Xem Chi Tiết" href="${False.commentId}" class="btn btn-success deleteFalse">Xóa</a></td>
                            <td align='center'><input type="checkbox" class='checkbox' name='checkhang' value='${False.commentId}' ></td>

                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="pagination">
                <input type="hidden" id="pageCommentFalse" value="${pageCommentFalse}">
                <c:if test="${pageCommentFalse > 1}">
                    <a href="${pageCommentFalse-1}" class="pageCommentFalse"><i class="fa fa-arrow-left"></i></a>
                    </c:if>
                    <c:forEach begin="1" end="${maxFalse}" step="1" varStatus="i">
                        <c:choose>
                            <c:when test="${pageCommentFalse == i.index}">
                            <span style="color: red;background-color: #0c5460">${i.index}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${i.index}" class="pageCommentFalse"><span>${i.index}</span></a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                <c:if test="${pageCommentFalse + 1 <= maxFalse}">
                    <a href="${pageCommentFalse+1}" class="pageCommentFalse"><i class="fa fa-arrow-right"></i></a>
                    </c:if>
            </div>
        </div>

    </div>
</div>


<script>
    jQuery(document).ready(function ($) {
        $(".pageCommentFalse").click(function (e) {
            e.preventDefault();
            var pageCommentFalse = $(this).attr("href");
            $.ajax({
                url: '<%=request.getContextPath()%>/adminComment/commentFalse.htm',
                type: 'post',
                dataType: 'html',
                data: {pageCommentFalse: pageCommentFalse},
                success: function (response) {
                    $("#detailOrder").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });

        $('.deleteFalse').click(function (e) {
            e.preventDefault();
            var pageCommentFalse = $("#pageCommentFalse").val();
            var commentId = $(this).attr('href');
            $.ajax({
                url: '<%=request.getContextPath()%>/adminComment/commentFalse.htm',
                type: 'post',
                data: {commentId: commentId, pageCommentFalse: pageCommentFalse},
                success: function (response) {
                    $("#detailOrder").html(response);
                     dataAll(response.view_data);
                }, error: function (jqXHR, textStatus, errorThrown) {
                    alert('sai');
                }
            });
        });
        $("#checkall").change(function () {

            var checked = $(this).is(':checked');
            if (checked) {
                $(".checkbox").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".checkbox").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });
        
        $('#delete').click(function () {
            var false_arr = [];
            $(".checkbox:checked").each(function () {
                var false_commentId = $(this).val();
                false_arr.push(false_commentId);
            });
            var pageCommentFalse=$("#pageCommentFalse").val();
            var length = false_arr.length;
            if (length > 0) {
                // AJAX request
                $.ajax({
                    url: '<%=request.getContextPath()%>/adminComment/commentFalse.htm',
                    type: 'post',
                    data: {false_arr: false_arr,pageCommentFalse:pageCommentFalse},
                    async: false,
                    success: function (response) {
                         
                        $("#detailOrder").html(response);
                 

                    }, error: function (jqXHR, textStatus, errorThrown) {
                        alert('sai');
                    }
                });
            } else {
                alert('Chưa Chọn Gì Hết');
            }
        });
        
         $(".commentId").each(function (index) {
            var commentId = $(this).text();
            loadUser(commentId, index);
            loadContent(commentId, index);
           
        });
        function loadUser(commentId, index) {
            $.ajax({
                url: "<%=request.getContextPath()%>/adminComment/loadUser.htm",
                type: 'POST',
//                async: false,
                data: {commentId: commentId},
                success: function (response) {

                    $('.usersRep:eq(' + (index) + ')').text(response);

                }, error: function (response) {
                    alert('sai');
                }
            });
        }
         function loadContent(commentId, index) {
            $.ajax({
                url: "<%=request.getContextPath()%>/adminComment/loadContent.htm",
                type: 'POST',
//                async: false,
                data: {commentId: commentId},
                success: function (response) {

                    $('.contentRep:eq(' + (index) + ')').text(response);

                }, error: function (response) {
                    alert('sai');
                }
            });
        }
        

    });
</script>