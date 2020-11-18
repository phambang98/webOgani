<%-- 
    Document   : contact
    Created on : Sep 17, 2020, 10:58:37 PM
    Author     : Bang-GoD
--%>

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
        <title>Contact</title>

        <jsp:include page="IncludeCss.jsp"/>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="banner.jsp"/>
        <section class="contact spad">
            <div class="container">
                <div class="row">
                    <c:forEach items="${listContact}" var="listContact" begin="0" end="0">
                        <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                            <div class="contact__widget">
                                <span class="icon_phone"></span>
                                <h4>Phone</h4>
                                <p>${listContact.phone}</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                            <div class="contact__widget">
                                <span class="icon_pin_alt"></span>
                                <h4>Address</h4>
                                <p>${listContact.contactAddress}</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                            <div class="contact__widget">
                                <span class="icon_clock_alt"></span>
                                <h4>Open time</h4>
                                <p>10:00 am to 23:00 pm</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 text-center">
                            <div class="contact__widget">
                                <span class="icon_mail_alt"></span>
                                <h4>Email</h4>
                                <p>${listContact.email}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        <!-- Contact Section End -->
        <!-- Map Begin -->
        <div class="map">
            
            
            <iframe width="600" height="500" id="gmap_canvas" src="https://maps.google.com/maps?q=sinh%20li%C3%AAn&t=&z=13&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
<!--            <iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d49116.39176087041!2d-86.41867791216099!3d39.69977417971648!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x886ca48c841038a1%3A0x70cfba96bf847f0!2sPlainfield%2C%20IN%2C%20USA!5e0!3m2!1sen!2sbd!4v1586106673811!5m2!1sen!2sbd"
                height="500" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>-->
            <div class="map-inside">
                <i class="icon_pin"></i>
                <div class="inside-widget">
                    <h4>Hà Nội</h4>
                    <ul>
                        <li>Phone: +12-345-6789</li>
                        <li>Add: 52 phố Quá Hay</li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- Map End -->

        <!-- Contact Form Begin -->
        <div class="contact-form spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="contact__form__title">
                            <h2>Leave Message</h2>
                        </div>
                    </div>
                </div>
                <form  id="formEmail" method="post" action="<%=request.getContextPath()%>/contact/sendEmail.htm">
                    <div class="row">
                        <div class="col-lg-6 col-md-6">
                            <input type="text" name="subject" id="subject" placeholder="Your name">
                        </div>
                        <div class="col-lg-6 col-md-6">
                            <input type="email" name="recipient" id="recipient"  placeholder="Your Email">
                        </div>
                        <div class="col-lg-12 text-center">
                            <textarea name="message" id="message" placeholder="Your message"></textarea>
                            <button type="submit" class="site-btn">SEND MESSAGE</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
        <jsp:include page="IncludeJs.jsp"/>
        <script>
            jQuery(document).ready(function ($) {
                $("#formEmail").submit(function (e) {
                    e.preventDefault();
                    var subject = $("#subject").val();
                    var recipient = $("#recipient").val();
                    var message = $("#message").val();
                    document.getElementById("formEmail").reset();
                    $.ajax({
                        url: '<%=request.getContextPath()%>/contact/sendEmail.htm',
                       type: 'post',
                      data: {subject:subject,recipient:recipient,message:message},
                      success: function (response) {
                         alert(response);
                          
                    },error: function (jqXHR, textStatus, errorThrown) {
                        alert('sai');
                    }
                    });
                });
            });
        </script>
    </body>
</html>
