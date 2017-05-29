<%--
  Created by IntelliJ IDEA.
  User: jhidalgo
  Date: 5/29/17
  Time: 1:57 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainLayout">
    <title>Bar Graph</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <asset:javascript src="barGraph.js.js"></asset:javascript>

</head>

<body>
    <ol class="breadcrumb">
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li class="active"> Estadísticas </li>
    </ol>
    <h1> Estadísticas </h1>
    <h3> Atracciones más populares entre los usuarios </h3>
    <div id="graphDiv1"></div>
    <br />
    <div class="table-container">
        <table class="table table-striped table-hover table-sm" id="table">
            <tr>
                <th>#</th>
                <th> Atracción </th>
                <th> Cantidad de Favoritos </th>
            </tr>
        </table>
    </div>

<script>(function () {

    function createCanvas(divName) {

        var div = document.getElementById(divName);
        var canvas = document.createElement('canvas');
        div.appendChild(canvas);
        if (typeof G_vmlCanvasManager != 'undefined') {
            canvas = G_vmlCanvasManager.initElement(canvas);
        }
        var ctx = canvas.getContext("2d");
        return ctx;
    }

    var ctx = createCanvas("graphDiv1");

    var graph = new BarGraph(ctx);
    graph.margin = 2;
    graph.colors = ["#ADD8E6"];

    $.ajax({url: "/TripsWebApp/stats/favs", success: function(result){
        var attractionNames = [];
        var attractionPopularities = [];


        console.log(result);
        var i = 1;
        for(var attraction in result.content){
            var html = '<tr><td>'+i+'</td><td>' + attraction + '</td><td>' + result.content[attraction]  + ' </td></tr>';
            $('#table').append(html);
            attractionNames.push(attraction);
            attractionPopularities.push(result.content[attraction]);
            i++;
        }

        graph.maxValue = Math.max(attractionPopularities);
        graph.xAxisLabelArr = attractionNames;
        graph.update(attractionPopularities);

    }});



}());
</script>
</body>
</html>
