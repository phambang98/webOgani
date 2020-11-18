<%-- 
    Document   : login
    Created on : Oct 1, 2020, 8:22:34 AM
    Author     : Bang-GoD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>SB Admin  - Login</title>

        <jsp:include page="IncludeCss.jsp"/>
        <link href="../jsp/admin/css/moreCss.css" rel="stylesheet">
    </head>

    <body class="bg-gradient-primary">

        <div class="container">

            <!-- Outer Row -->
            <div class="row justify-content-center">

                <div class="col-xl-10 col-lg-12 col-md-9">

                    <div class="card o-hidden border-0 shadow-lg my-5">
                        <div class="card-body p-0">
                            <!-- Nested Row within Card Body -->
                            <div class="row">
                                <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                                <div class="col-lg-6">
                                    <div class="p-5">
                                        <div class="text-center">
                                            <h1 class="h4 text-gray-900 mb-4">Welcome Admin!</h1>
                                        </div>
                                        <form class="user" action="login.htm"  method="post">
                                            <div class="form-group">
                                                <input type="text" name="name" class="form-control form-control-user" id="exampleInputEmail" placeholder="Name">
                                            </div>
                                            <div class="form-group">
                                                <input type="password" name="pass" class="form-control form-control-user" id="exampleInputPassword" placeholder="Password">
                                            </div>

                                            <div class="form-group abc">
                                                <input type="text" readonly="true" id="loadCapcha" style="color: red" class="form-control form-control-user"  >
                                                <span id="load"> 
                                                    <image src="../jsp/admin/img/61444.png" widt="30" height="30"/>
                                                </span>
                                            </div>
                                            <div class="form-group">
                                                <input type="text"  name="capcha" style="color: red" class="form-control form-control-user"  >

                                            </div>
                                            <input type="submit" value="Login" class="btn btn-primary btn-user btn-block">

                                        </form>
                                        <hr>
                                        <div class="text-center">
                                            <a class="small" href="forgot-password.html">Forgot Password?</a>
                                            <p id="thongbao" style="color: red">${thongbao}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </div>

        <jsp:include page="IncludeJs.jsp"/>
        <script>
            $(document).ready(function () {
                $('#thongbao').fadeOut(10000);

                $.get("<%=request.getContextPath()%>/adminController/loadCapcha.htm", function (response) {
                    $("#loadCapcha").val(response);
                });
                $("#load").click(function () {
                    $.get("<%=request.getContextPath()%>/adminController/loadCapcha.htm", function (response) {
                        $("#loadCapcha").val(response);
                    });
                });
                $('#loadCapcha').bind('copy cut', function (e) {
                    e.preventDefault();
                    alert('cut,copy Không Được nhé !!');
                });

            });
        </script>
    </body>

</html>

