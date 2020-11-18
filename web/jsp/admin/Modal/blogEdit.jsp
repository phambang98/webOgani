
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${admins==null}">

    <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
</c:if>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<f:form  action="edit.htm" commandName="blogEdit" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <f:input path="blogId" hidden="true"/>
        <label for="exampleInputEmail1">Tên Blog</label>
        <f:input required="true" class="form-control" path="blogName"/>
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Nội dung </label>
        <f:textarea class="form-control" rows="3" path="content" ></f:textarea>
        </div>
        <div class="form-group">
            <label for="exampleFormControlFile1">Hình Ảnh</label>
            <input class="form-control-file" type="file" name="editImageLink">
            <img src="${blogEdit.imageLink}" height="150" id="blah">
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Trạng Thái </label>
        <f:select class="form-control" path="blogStatus"> 
            <f:option value="true">True</f:option>
            <f:option value="false">False</f:option>
        </f:select>
    </div>
    <button type="submit" class="btn btn-primary" >Submit</button>
</f:form>
