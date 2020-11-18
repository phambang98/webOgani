<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <c:if test="${admins==null}">
            <c:redirect url="${request.contextPath}/adminController/initLogin.htm"/>     
        </c:if>
        <div id="wrapper">
            <jsp:include page="menu.jsp"/>
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <jsp:include page="header.jsp"/>
                    <div class="container-fluid">

                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <div id="chartContainer" style="height: 370px; width: 100%;"></div>
                                <button class="btn invisible" id="backButton">&lt; Back</button>
                            </div>

                        </div>
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <div id="chartContainer1" style="height: 370px; width: 100%;"></div>
                                <button class="btn invisible" id="backButton">&lt; Back</button>
                            </div>
                        </div>
                        <div  id="dataAdmin">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="IncludeJs.jsp"/>
        <script src="../jsp/admin/js/canvasjs-min.js"></script>
        <script type="text/javascript">
            window.onload = function () {
                product();
                Star();
            }
            function product() {
                var dps = [[]];
                var chart = new CanvasJS.Chart("chartContainer", {
                    animationEnabled: true,
                    theme: "light2", // "light1", "dark1", "dark2"
                    title: {
                        text: "Top 5 Sản Phẩm "
                    },
                    subtitles: [{
                            text: "Thống Kê"
                        }],
                    axisY: {
                        title: "Tổng Tiền",
                        suffix: "VNĐ"
                    },
                    data: [{
                            type: "column",
                            yValueFormatString: "#,##0 VNĐ",
                            dataPoints: dps[0]
                        }]
                });

                var yValue;
                var label;
            <c:forEach items="${dataPointsList}" var="dataPoints" varStatus="loop">
                <c:forEach items="${dataPoints}" var="dataPoint">
                yValue = parseFloat("${dataPoint.y}");
                label = "${dataPoint.label}";

                dps[parseInt("${loop.index}")].push({
                    label: label,

                    y: yValue,

                });
                </c:forEach>
            </c:forEach>
                chart.render();
            }
            function Star() {
                var dps = [[]];
                var chart = new CanvasJS.Chart("chartContainer1", {
                    animationEnabled: true,
                    exportEnabled: true,
                    title: {
                        text: "Bảng Đánh Giá"
                    },
                    data: [{
                            type: "pie",
                            yValueFormatString: "#,###\"%\"",
                            showInLegend: true,
                            indexLabel: "{y}",
                            indexLabelPlacement: "inside",
                            dataPoints: dps[0]
                        }]
                });
                var yValue;
                var name;
            <c:forEach items="${dataPointsList1}" var="dataPoints" varStatus="loop">
                <c:forEach items="${dataPoints}" var="dataPoint">
                yValue = parseFloat("${dataPoint.y}");
                name = "${dataPoint.name}";
                dps[parseInt("${loop.index}")].push({
                    name: name,
                    y: yValue
                });
                </c:forEach>
            </c:forEach>
                chart.render();
            }
        </script>
    </body>
</html>