
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>SB Admin 2 - Dashboard</title>
        <jsp:include page="IncludeCss.jsp"/>
        <link href="../jsp/admin/css/pagination.css" rel="stylesheet">
    </head>
    <body id="page-top">
        <c:if test="${sessionScope.admins==null}">
            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
        <div id="wrapper">
            <jsp:include page="menu.jsp"/>
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <jsp:include page="header.jsp"/>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <h4>Hồ Sơ Admin</h4>
                                                <hr>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <f:form commandName="admins" action="updateUser.htm" enctype="multipart/form-data" method="post">
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
                                                            <img src="${sessionScope.admins.userImage}" id="blah"  width="150px">
                                                            <input type="file" name="image" onchange="document.getElementById('blah').src = window.URL.createObjectURL(this.files[0])"/>                                            </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="offset-4 col-8">
                                                            <button type="submit" class="btn btn-success">Update</button>
                                                            <input type="reset"  value="Reset" class="btn btn-danger">
                                                            <button type="button"  class="btn btn-warning" data-toggle="modal" data-target="#exampleModal">
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
                </div>
            </div>
        </div>
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


        <jsp:include page="IncludeJs.jsp"/>
        <script>
            jQuery(document).ready(function ($) {
                $("#submitModal").click(function (e) {
                    var old = $("#passwordOld").val();
                    var news = $("#passwordNew").val();
                    var con = $("#passwordCon").val();
                    $.ajax({
                        url: '<%=request.getContextPath()%>/adminController/changePassWord.htm',
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