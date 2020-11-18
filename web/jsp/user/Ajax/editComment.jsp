<%-- 
    Document   : editComment
    Created on : Sep 17, 2020, 9:17:52 AM
    Author     : Bang-GoD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<form method="post" >
    <label>Comment</label>
    <input type="hidden" value="${comment.commentId}" id="editCommentId">
    <input type="hidden" value="${comment.product.prodId}" id="editProductId">
      <input type="hidden" value="${comment.parentId}" id="editParentId">
    <textarea required class="form-control"  id="editContent">${comment.content}</textarea>
    <input type="submit" id="editSubmitComment"  class="btn btn-secondary" value="Update">
    <input type="reset" value="Reset" class="btn btn-primary">
</form>
<script src="../../ckfinder/ckfinder.js" type="text/javascript"></script>
<script src="../../ckeditor/ckeditor.js" type="text/javascript"></script>
<script>
//    var editTor = CKEDITOR.replace('editTor');
//    CKFinder.setupCKEditor(editTor, 'jsp/ckfinder');
</script>
<script>
    jQuery(document).ready(function ($) {
        $("#editSubmitComment").click(function (e) {
            e.preventDefault();
            var commentId = $("#editCommentId").val();
            var prodId = $("#editProductId").val();
            var content = $("#editContent").val();
             var parentId = $("#editParentId").val();
            $.ajax({
                url: 'editComment.htm',
                type: 'post',
                dataType: 'html',
                data: {prodId: prodId, commentId: commentId, content: content,parentId:parentId},
                success: function (response) {
               
                     $('#ModalEditComment').modal('hide');
                    $("#showAllComment").html(response);
                },
                error: function (response) {
                    alert('sai');
                }
            });

        });
    });
</script>