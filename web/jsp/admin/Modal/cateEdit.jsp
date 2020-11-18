
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
<f:form  action="edit.htm" commandName="cateEdit" method="post">
    <div class="form-group">
        <f:input path="cateId" hidden="true"/>
        <label for="exampleInputEmail1">Tên Danh Mục</label>
        <f:input required="true" class="form-control" path="cateName"/>
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Mô Tả </label>
        <f:input class="form-control" rows="3"  required="true" path="cateTitle" />
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Độ Ư Tiên </label>
        <f:input  onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength="3" class="form-control" rows="3"  required="true" path="prioritys" />
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Trạng Thái </label>
        <f:select class="form-control" path="cateStatus"> 
            <f:option value="true">True</f:option>
            <f:option value="false">False</f:option>
        </f:select>
    </div>
    <button type="submit" class="btn btn-primary" >Submit</button>
</f:form>
