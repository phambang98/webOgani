
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form"  prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${admins==null}">

    <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
</c:if>
<f:form  action="edit.htm" method="post" commandName="productEdit" enctype="multipart/form-data">
    <div class="form-group">
        <label for="exampleInputEmail1">Tên Sản Phẩm</label>
        <f:input required="true" type="hidden" class="form-control" path="prodId" />
        <f:input required="true" type="text" class="form-control" path="prodName" />
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1"> Giá</label>
        <f:input required="true" type="text"  class="form-control" path="price" />
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Mô Tả</label>
        <f:input required="true" type="text"  class="form-control" path="title" />
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Chi Tiết</label>
        <f:textarea required="true" class="form-control" rows="5" path="descriptions" ></f:textarea>
        </div>
        <div class="form-group">
            <label for="exampleInputPassword1"> Giảm Giá</label>
        <f:input required="true" type="text"  class="form-control" maxlength="2" path="discount" />
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1"> Thuộc Danh Mục</label>
        <f:select class="form-control" path="categories.cateId">
            <c:forEach items="${listCate}" var="listCate">
                <f:option value="${listCate.cateId}">${listCate.cateName}</f:option>
            </c:forEach>
        </f:select>
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1"> Trạng Thái</label>
        <f:select class="form-control" path="prodStatus">
            <f:option value="true">True</f:option>
            <f:option value="false">False</f:option>
        </f:select>
    </div>
    <div class="form-group">
        <label for="exampleFormControlFile1">Ảnh  Chính</label>
        <input  class="form-control-file" data-result="imageMainReview"  name="editImageLink" type="file">
        <img src="${productEdit.imageLink}"  height="150" >
       
    </div>
    <div class="form-group">
        <label for="exampleFormControlFile1">Ảnh  Phụ </label>
        <input  class="form-control-file" 
                data-result="imageOtherReview" multiple="multiple" name="editImageOther" type="file">
        <h4>Ảnh cũ</h4>
        <c:forEach items="${listImage}" var="edit">
            <img src="${edit.imageLink}"   height="150" >
        </c:forEach>
       
    </div>
  
    <button type="submit" class="btn btn-primary" >Submit</button>
</f:form>

