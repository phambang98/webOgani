<%-- 
    Document   : allComment
    Created on : Sep 17, 2020, 9:40:43 PM
    Author     : Bang-GoD
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<c:if test="${listComment.size()>=0}">
    <c:forEach var="lc" items="${listComment}">
        <div class="col-md-1 ">
            <img src="${lc.users.userImage}" height="100" width="100" class="img img-rounded img-fluid">
        </div>
        <div class="col-md-11" style="border-bottom: 1px solid black;">
            <p><strong>${lc.users.userName}</strong> </p>
            <p> ${lc.content}</p>
            <p>
                <c:if test="${sessionScope.users.userId==lc.users.userId}">
                    <a href="${lc.commentId}" class="float-right btn btn-outline-primary ml-2"><i class="fa fa-trash"></i> Delete</a>
                    <a href="${lc.commentId}" class=" float-right btn btn-success openBtn">Sửa</a>
                </c:if>
            </p>
        </div>
    </c:forEach>

</c:if>--%>

<div class="col-md-12">
    <c:if test="${listComment.size()>=0}">
        <c:forEach var="lc" items="${listComment}">
            <div class="comments">
                <div class="comment-box">

                    <span class="commenter-pic">
                        <img src="${lc.users.userImage}" class="img-fluid">
                    </span>

                    <span class="commenter-name">
                        <span>${lc.users.userName}</span> 
                    </span>       
                    <p class="comment-txt more">${lc.content}</p>
                    <div class="comment-meta">
                        <a href="${lc.commentId}" class=" float-right btn replyComment"><i class="fa fa-reply"></i>Reply</a>

                        <c:if test="${sessionScope.users.userId==lc.users.userId}">
                            <a href="${lc.commentId}" class="float-right btn btn-outline-primary ml-2 DeleteCmt"><i class="fa fa-trash"></i> Delete</a>
                            <a href="${lc.commentId}" class=" float-right btn btn-success openBtn EditCmt">Sửa</a>

                        </c:if>
                    </div>
                    <c:forEach items="${listRepComment}" var="rep">
                        <c:if test="${rep.parentId==lc.commentId}">


                            <div class="comment-box replied">
                                <span class="commenter-pic">
                                    <img src="${rep.users.userImage}" class="img-fluid">
                                </span>
                                <span class="commenter-name">
                                    <span>${rep.users.userName}</span>
                                </span>       
                                <p class="comment-txt more">${rep.content}</p>
                                <div class="comment-meta">
                                    <c:if test="${sessionScope.users.userId==rep.users.userId}">
                                        <a href="${rep.commentId}" class="float-right btn btn-outline-primary DeleteRepCmt"><i class="fa fa-trash"></i> Delete</a>
                                        <a href="${rep.commentId}" class=" float-right btn btn-success EditRepCmt">Sửa</a>
                                        <input type="hidden" value="${lc.commentId}" class="RepEditComment">
                                    </c:if>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>

                </div>
            </div>
        </c:forEach>
    </c:if>
</div>




<script>
    jQuery(document).ready(function ($) {
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

        //xoa binh luan
        $(".DeleteCmt").click(function (e) {
            e.preventDefault();
            var prodId=$("#commentProdId").val();
            var commentId = $(this).attr("href");
            $.ajax({
                url: 'deleteComment.htm',
                type: 'post',
                dataType: 'html',
                data: {commentId: commentId,prodId:prodId},
                success: function (response) {
                    $("#showAllComment").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });
        //sua binh luan
        $(".EditCmt").click(function (e) {
            e.preventDefault();
            var commentId = $(this).attr("href");

            $('.modal-body').load('initEditComment.htm', {commentId: commentId}, function () {

                $('#ModalEditComment').modal({show: true});
            });
        });
        //sủa trả lời bình luận
        $(".EditRepCmt").click(function (e) {
            e.preventDefault();
            var commentId = $(this).attr("href");

            $('.modal-body').load('initEditComment.htm', {commentId: commentId}, function () {

                $('#ModalEditComment').modal({show: true});
            });
        });

        //xoa trả loi binh luan
        $(".DeleteRepCmt").click(function (e) {
            e.preventDefault();
            var commentId = $(this).attr("href");
             var prodId=$("#commentProdId").val();
            $.ajax({
                url: 'deleteComment.htm',
                type: 'post',
                dataType: 'html',
                data: {commentId: commentId,prodId:prodId},
                success: function (response) {
                    
                    $("#showAllComment").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });
        });
    });
</script>
