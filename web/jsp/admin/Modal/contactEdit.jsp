<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
<f:form  commandName="contactEdit" action="edit.htm" method="post">
    <div class="form-group">
        <label for="exampleInputEmail1">Email</label>
        <f:input path="id" hidden="true"  class="form-control"/>
        <f:input required="true" path="email"  class="form-control"/>
    </div>
    <div class="form-group">
        <label for="exampleInputEmail1">Phone</label>
        <f:input required="true"  path="phone"onkeypress='return event.charCode >= 48 && event.charCode <= 57'
                 maxlength="10" class="form-control" />
    </div>
    <div class="form-group">
        <label for="exampleInputEmail1">Địa Chỉ</label>
        <f:input required="true" path="contactAddress" class="form-control"/>
    </div>

    <button type="submit" class="btn btn-primary" id="submitNewBlog">Submit</button>
</f:form>
