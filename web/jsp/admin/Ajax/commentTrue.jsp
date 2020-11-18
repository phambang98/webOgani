<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 <c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">Bình Luận Đã Duyệt</h6>
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
                    </tr>
                </thead> 
                <tbody>
                    <c:forEach items="${listCommentTrue}" varStatus="index" var="True">                        
                        <tr class="table-Light">
                            <td>${index.index+1}</td>
                            <td><h5><img src="${True.users.userImage}" height="30" width="30"></h5></td>
                            <td>${True.users.userName}</td>
                            <td><h5><img src="${True.product.imageLink}" height="30" width="30"></h5></td>
                            <td>${True.product.prodName} </td>
                            <td>${True.content}</td>
                            <td hidden class="commentId">${True.parentId}</td>
                            <td class="usersRep"></td>
                            <td class="contentRep"></td>
                            <td><a title="Xem Chi Tiết" href="${True.commentId}" class="btn btn-success deleteTrue">Xóa</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="pagination">
                <input type="hidden" id="pageCommentTrue" value="${pageCommentTrue}">
                <c:if test="${pageCommentTrue > 1}">
                    <a href="${pageCommentTrue-1}" class="pageCommentTrue"><i class="fa fa-arrow-left"></i></a>
                    </c:if>
                    <c:forEach begin="1" end="${maxTrue}" step="1" varStatus="i">
                        <c:choose>
                            <c:when test="${pageCommentTrue == i.index}">
                            <span style="color: red;background-color: #0c5460">${i.index}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${i.index}" class="pageCommentTrue"><span>${i.index}</span></a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                <c:if test="${pageCommentTrue + 1 <= maxTrue}">
                    <a href="${pageCommentTrue+1}" class="pageCommentTrue"><i class="fa fa-arrow-right"></i></a>
                    </c:if>
            </div>
        </div>

    </div>
</div>


<script>
    jQuery(document).ready(function ($) {
        $(".pageCommentTrue").click(function (e) {
            e.preventDefault();
            var pageCommentTrue = $(this).attr("href");
            $.ajax({
                url: '<%=request.getContextPath()%>/adminComment/commentTrue.htm',
                type: 'post',
                dataType: 'html',
                data: {pageCommentTrue: pageCommentTrue},
                success: function (response) {
                    $("#detailOrder").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });

        $('.deleteTrue').click(function (e) {
            e.preventDefault();
            var pageCommentTrue = $("#pageCommentTrue").val();
            var commentId = $(this).attr('href');

            $.ajax({
                url: '<%=request.getContextPath()%>/adminComment/commentTrue.htm',
                type: 'post',
                data: {commentId: commentId, pageCommentTrue: pageCommentTrue},
                success: function (response) {
                    $("#detailOrder").html(response);
                  
                }, error: function (jqXHR, textStatus, errorThrown) {
                    alert('sai');
                }
            });
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