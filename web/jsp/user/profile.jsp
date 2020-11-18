<%-- 
    Document   : proflie
    Created on : Sep 14, 2020, 8:20:58 AM
    Author     : Bang-GoD
--%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset=UTF-8">
        <meta name="description" content="Ogani Template">
        <meta name="keywords" content="Ogani, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>ProFile</title>
        <jsp:include page="IncludeCss.jsp"/>
    </head>
    <body>
        <c:if test="${sessionScope.users==null}">
            <c:redirect url="${request.contextPath}/home/index.htm"/>     
        </c:if>
        <jsp:include page="header.jsp"/>
        <jsp:include page="banner.jsp"/>
        <section class="checkout spad">
            <div class="container">
                <div class="row">
                    <div class="col-md-3 ">
                        <div class="list-group ">
                            <a href="<%=request.getContextPath()%>/users/profile.htm" class="list-group-item list-group-item-action active">Trang Cá Nhân</a>
                            <a href="<%=request.getContextPath()%>/shoppingCart/myCart.htm" class="list-group-item list-group-item-action">Xem Giỏ Hàng</a>
                            <a href="<%=request.getContextPath()%>/orders/myOrder.htm" class="list-group-item list-group-item-action">Xem Đơn Hàng</a>
                        </div> 
                    </div>
                    <div class="col-md-9">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4>Hồ Sơ Người Dùng</h4>
                                        <hr>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <f:form commandName="users" action="updateUser.htm" enctype="multipart/form-data" method="post">
                                            <f:input path="userId" hidden="true" />
                                            <f:input hidden="true"  path="passWords"/>
                                            <f:input hidden="true"  path="userStatus"/>
                                            <f:input hidden="true"  path="isAdmin"/>
                                            <div class="form-group row">
                                                <label for="username" class="col-4 col-form-label">User Name</label> 
                                                <div class="col-8">
                                                    <f:input  path="userName"  class="form-control here" readonly="true"/>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="email" class="col-4 col-form-label">Email</label> 
                                                <div class="col-8">
                                                    <f:input  path="userEmail"  class="form-control here"/>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="email" class="col-4 col-form-label">Số Điện Thoại</label> 
                                                <div class="col-8">
                                                    <f:input  path="phone"  class="form-control here"/>                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="email" class="col-4 col-form-label">Địa Chỉ</label> 
                                                <div class="col-8">
                                                    <f:input  path="userAddress"  class="form-control here"/>                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="email" class="col-4 col-form-label">Hình Đại Diện</label> 
                                                <div class="col-8">
                                                    <img src="${sessionScope.users.userImage}" id="blah"  width="150px">
                                                    <input type="file" name="image" onchange="document.getElementById('blah').src = window.URL.createObjectURL(this.files[0])"/>                                            </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="offset-4 col-8">
                                                    <button type="submit" class="site-btn">Update</button>
                                                    <input type="reset"  value="Reset" class="site-btn">
                                                    <button type="button" class="site-btn" data-toggle="modal" data-target="#exampleModal">
                                                        Đổi Mật Khẩu
                                                    </button>                                                    
                                                </div>
                                            </div>
                                        </f:form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Modal -->
        <form method="post" action="?" id="formUsers">
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Đổi Pass</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label>Mật Khẩu Cũ</label>
                            <input  class="form-control" id="passwordOld" type="password" >
                            <label>Mật Khẩu Mới</label>
                            <input  class="form-control" id="passwordNew" type="password">
                            <label>Nhập Lại</label>
                            <input class="form-control" id="passwordCon" type="password" >
                            <label id="label" style="color: red"></label>
                            <label id="labela" style="color: red"></label>

                        </div>
                        <div class="modal-footer">
                            <button type="button" id="closeModal" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" id="submitModal" class="btn btn-primary">Đổi</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <jsp:include page="footer.jsp"/>
        <jsp:include page="IncludeJs.jsp"/>
        <script>
            jQuery(document).ready(function ($) {
                $("#submitModal").click(function (e) {
                    var old = $("#passwordOld").val();
                    var news = $("#passwordNew").val();
                    var con = $("#passwordCon").val();
                    $.ajax({
                        url: '<%=request.getContextPath()%>/users/changePassWord.htm',
                        type: 'post',
                        data: {old: old, news: news, con: con},
                        success: function (response) {
                            var tb = JSON.stringify(response);
                            alert(tb);
//                            $('#exampleModal').modal('hide');
                            $("#formUsers")[0].reset();

                        }, error: function (response) {
                            alert('sai');
                        }
                    });
                });
                $("#closeModal").click(function () {
                    $("#formUsers")[0].reset();
                });

            });
        </script>
    </body>

</html>