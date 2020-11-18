
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<c:if test="${admins==null}">

    <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
</c:if>
<f:form commandName="bannerNew" action="new.htm" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label for="exampleInputEmail1">Tên Banner</label>
        <f:input required="true" class="form-control" path="bannerName"/>
    </div>
    <div class="form-group">
        <label  for="exampleInputEmail1">Trạng Thái</label>
        <f:select path="bannerStatus" class="form-control">
            <f:option value="true">True</f:option>
            <f:option value="false">False</f:option>
        </f:select>
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Độ ưu tiên </label>
        <input required class="form-control" name="prioritys" 
               onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength="3" type="text">
    </div>
    <div class="form-group">
        <label for="exampleFormControlFile1">Hình Ảnh</label>
        <input required class="form-control-file" name="newImageLink" type="file">
     
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
</f:form>
