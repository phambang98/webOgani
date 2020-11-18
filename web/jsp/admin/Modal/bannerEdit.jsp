
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
<f:form  action="edit.htm" commandName="bannerEdit" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <f:input path="bannerId" hidden="true"/>
        <label for="exampleInputEmail1">Tên Blog</label>
        <f:input required="true" class="form-control" path="bannerName"/>
    </div>
   
    <div class="form-group">
        <label for="exampleInputEmail1">Độ Ưu Tiên</label>
        <f:input required="true"  onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength="3"
                 class="form-control" path="prioritys"/>
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Trạng Thái </label>
        <f:select class="form-control" path="bannerStatus"> 
            <f:option value="true">True</f:option>
            <f:option value="false">False</f:option>
        </f:select>
    </div>
     <div class="form-group">
        <label for="exampleFormControlFile1">Hình Ảnh</label>
        <input  class="form-control-file" type="file" name="editImageLink">
        <img src="${bannerEdit.imageLink}" height="150">
    </div>
    <button type="submit" class="btn btn-primary" >Submit</button>
</f:form>
