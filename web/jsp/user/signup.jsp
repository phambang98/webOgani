<%@page contentType="text/html"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Ogani Template">
        <meta name="keywords" content="Ogani, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Đăng Kí</title>
        <link rel="stylesheet" href="../jsp/user/css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="../jsp/user/css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="../jsp/user/css/dangki.css" type="text/css">
    </head>
    <body>
        <div class="container">
            <div class="row py-5 mt-4 align-items-center">
                <!-- For Demo Purpose -->
                <div class="col-md-5 pr-lg-5 mb-5 mb-md-0">
                    <img src="../jsp/user/img/signup.jpg" alt="" class="img-fluid mb-3 d-none d-md-block">
                    <h1>Create an Account</h1>

                </div>
                <div class="col-md-7 col-lg-6 ml-auto">
                    <form action="<%=request.getContextPath()%>/users/signup.htm" method="post"  >
                        <div class="row">               
                            <div class="input-group col-lg-12 mb-4">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-white px-4 border-md border-right-0">
                                        <i class="fa fa-phone-square text-muted"></i>
                                    </span>
                                </div>
                                <input id="userName" required type="tel" name="userName" placeholder="User Name" class="form-control bg-white border-md border-left-0 pl-3">
                            </div>
                            <div class="input-group col-lg-12 mb-4" id="test">
                            </div>
                            <div class="input-group col-lg-6 mb-4">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-white px-4 border-md border-right-0">
                                        <i class="fa fa-envelope text-muted"></i>
                                    </span>
                                </div>
                                <input  required type="email" name="userEmail" placeholder="Email Address" class="form-control bg-white border-left-0 border-md">
                            </div>

                            <div class="input-group col-lg-6 mb-4">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-white px-4 border-md border-right-0">
                                        <i class="fa fa-phone-square text-muted"></i>
                                    </span>
                                </div>
                                <input  type="text" minlength="10" onkeypress='return event.charCode >= 48 && event.charCode <= 57' name="phone" placeholder="Phone Number" class="form-control bg-white border-md border-left-0 pl-3">
                            </div>

                            <div class="input-group col-lg-12 mb-4">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-white px-4 border-md border-right-0">
                                        <i class="fa fa-envelope text-muted"></i>
                                    </span>
                                </div>
                                <input  required type="text" name="userAddress" placeholder=" Address" class="form-control bg-white border-left-0 border-md">
                            </div>
                            <div class="input-group col-lg-12 mb-4">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-white px-4 border-md border-right-0">
                                        <i class="fa fa-phone-square text-muted"></i>
                                    </span>
                                </div>
                                <input id="password" required minlength="6" type="password" name="passWords" placeholder="Password" class="form-control bg-white border-left-0 border-md">
                            </div>
                            <div class="input-group col-lg-12 mb-4">

                                <div class="input-group">
                                    <div class="checkbox">
                                        <label>
                                            <input id="login-remember" type="checkbox" > <span style="color: red" id="textspan">Show Pass</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-lg-12 mx-auto mb-0">
                                <input value="Create" id="submitSignup" type="submit" class="btn btn-primary btn-block py-2" >
                            </div>
                            <div class="form-group col-lg-12 mx-auto d-flex align-items-center my-4">
                                <div class="border-bottom w-100 ml-5"></div>
                                <span class="px-2 small text-muted font-weight-bold text-muted">OR</span>
                                <div class="border-bottom w-100 mr-5"></div>
                            </div>
                            <div class="text-center w-100">
                                <p class="text-muted font-weight-bold">Đã Có Tài Khoản
                                    <a href="<%=request.getContextPath()%>/users/initSignin.htm" class="text-primary ml-2">Đăng Nhập</a></p>
                            </div>
                            <div class="text-center w-100">
                                <p class="text-muted font-weight-bold">Vê Trang Chủ
                                    <a href="<%=request.getContextPath()%>/home/index.htm" class="text-primary ml-2">Trang Chủ</a></p>
                            </div>
                            <input type="hidden" value="../jsp/user/img/users/unnamed.jpg" name="userImage">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="../jsp/user/js/jquery-3.3.1.min.js"></script>
        <script src="../jsp/user/js/bootstrap.min.js"></script>
        <script src="../jsp/user/js/showhide.js"></script>
        <script>
                                    jQuery(document).ready(function ($) {
                                        $("#test").hide();
                                        $("#submitSignup").attr('disabled', 'disabled');
                                        $("#userName").keyup(function () {
                                            var userName = $("#userName").val().trim();
                                            if (userName.length >= 6)
                                            {
                                                $("#test").show();
                                                $.ajax({
                                                    url: '<%=request.getContextPath()%>/users/checkUserName.htm',
                                                    type: 'post',
                                                    data: {userName: userName},
                                                    success: function (response) {
                                                        $("#test").html(response);
                                                        var test = $("#test").text();
                                                        if (test === "Được Sử Dụng")
                                                        {
                                                            $("#submitSignup").removeAttr('disabled');
                                                        } else {
                                                            $("#submitSignup").attr('disabled', 'disabled');
                                                        }
                                                    }
                                                });
                                            } else if (userName == "") {
                                                $("#test").hide();
                                            } else if (userName.length <= 6) {
                                                $("#test").show();
                                                document.getElementById("test").style.color = "red";
                                                $("#test").text('Tên Đăng Nhập Phải Hơn 6 Kí Tự');
                                            }
                                        });
                                    });
        </script>
    </body>
</html>