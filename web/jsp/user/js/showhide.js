/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {
//    $("#login").click(function () {
//        var userName = $('#userName').val();
//        var pass = $("#password").val();
//        var aaa = userName * 1000;
//        if (userName == "") {
//            $("#error_userName").text("Bạn chưa nhập tên đăng nhập").addClass('error');
//            $("#userName").addClass("errorInput");
//        } else if (pass == "") {
//            $("#error_password").text("Bạn chưa nhập mật khẩu").addClass('error');
//            $("#password").addClass("errorInput");
//        }
//    });
//
//    $('#userName').on('input', function () {
//        document.getElementById("loc").innerHTML = " " + document.getElementById("userName").value;
//    });
    var check = false;
    $('#login-remember').change(function () {
        if (check == false) {
            $('#textspan').text("Hide pass");
            $("#rePassword").attr('type', 'text');
            $("#password").attr('type', 'text');
            check = true;
            $("#showpass").text("Hidden");
        } else {
            $('#textspan').text("Show pass");
            $("#password").attr('type', 'password');
            $("#rePassword").attr('type', 'password');
            check = false;
            $("#showpass").text("Show");
        }
    });
});
