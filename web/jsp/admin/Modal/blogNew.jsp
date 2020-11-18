
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<c:if test="${admins==null}">

    <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
</c:if>
<f:form commandName="blogNew" action="new.htm" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label for="exampleInputEmail1">Tên Blog</label>
        <f:input required="true" type="text" class="form-control" path="blogName"/>
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Nội dung </label>
        <f:textarea required="true" class="form-control" rows="5" path="content"></f:textarea>
        </div>
        <div class="form-group">
            <label  for="exampleInputEmail1">Trạng Thái</label>
        <f:select path="blogStatus" class="form-control">
            <f:option value="true">True</f:option>
            <f:option value="false">False</f:option>
        </f:select>
    </div>
    <div class="form-group">
        <label for="exampleFormControlFile1">Hình Ảnh</label>
        <input required class="form-control-file" name="newBlogImg" id="newBlogImg" type="file" onchange="document.getElementById('blah').src = window.URL.createObjectURL(this.files[0])">
        <img id="blah" alt="your image" width="100" height="100" />
    </div>
    <button type="submit" class="btn btn-primary" id="submitNewBlog">Submit</button>
</f:form>
