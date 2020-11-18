<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${admins==null}">

            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
<form  action="new.htm" method="post">
    <div class="form-group">
        <label for="exampleInputEmail1">Tên Danh Muc</label>
        <input required type="text" class="form-control" name="cateName" >
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Mô Tả </label>
        <input required type="text" class="form-control" name="cateTitle" >
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Độ Ưu Tiên </label>
        <input required type="text"  onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength="3"  class="form-control" name="prioritys" >
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Trạng Thái</label>
        <select  class="form-control" name="cateStatus">
            <option value="true">True</option>
            <option value="false">False</option>
        </select>
    </div>
    <button type="submit" class="btn btn-primary" >Submit</button>
</form>
