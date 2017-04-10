<%--
  Created by IntelliJ IDEA.
  User: jhidalgo
  Date: 4/9/17
  Time: 9:38 PM
--%>
<%@ page import="tripswebapp.model.Review" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainLayout">

    <g:set var="entityName" value="${message(code: 'review.label', default: 'Review')}" />
    <title> Lista de Reseñas </title>

    <asset:javascript src="moment.js"></asset:javascript>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" />

</head>
<body>
<ol class="breadcrumb">
    <li><a href="${createLink(uri: '/')}">Home</a></li>
    <li class="active">Lista de Reseñas </li>
</ol>
<div id="list-reviews" class="content scaffold-list" role="main">
    <h1> Lista de Reseñas </h1>
%{--
    <g:link class="btn btn-success btn-add" action="create"> Crear Atracción </g:link></li>
--}%

    <g:if test="${flash.message}">
        <div class="alert alert-info message" role="status">${flash.message}</div>
    </g:if>

    <form id="datesForm" action="list">
        <div class="filterComponent col-md-12">
            <div class="col-md-1 filterLabel">
                <label> Filtrar por: </label>
            </div>
            <div class="col-md-2 form-group">
                <select class="form-control" name="filterBy">
                    <option value="stop"> Atracción </option>
                    <option value="city"> Ciudad </option>
                    <option value="country"> País </option>
                    <option value="author"> Autor </option>
                    <option value="text"> Texto </option>
                    <option value="score"> Puntaje </option>
                </select>
            </div>
            <div class="col-md-2">
                <input type="text" class="form-control" name="filter">
            </div>

        </div>
        <div class="filterComponent col-md-12">
            <div class="col-md-1 filterLabel">
                <label> Filtrar desde:  </label>
            </div>
            <div class='col-md-2'>
                <div class="form-group">
                    <div class='input-group date' id='datetimepicker6'>
                        <input name='date1' type='text' class="form-control" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-md-1 filterLabel">
                <label> Filtrar Hasta:  </label>
            </div>
            <div class='col-md-2'>
                <div class="form-group">
                    <div class='input-group date' id='datetimepicker7'>
                        <input name='date2' type='text' class="form-control" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>
            </div>
            %{--<div class="col-md-1">
                <label> Cantidad a mostrar:  </label>
            </div>
            <div class="col-md-2 form-group">
                <select class="form-control" name="max" id="selectorSize">
                    <option value="10">10</option>
                    <option value="20">20</option>
                    <option value="35">35</option>
                </select>
            </div>--}%
            <div class="col-md-2">
                <input class="btn-filtro btn btn-info" type="submit" value="Filtrar">
            </div>
        </div>
    </form>

    <table class="table table-hover">
        <thead>
        <tr>

            <g:sortableColumn property="date" title="Fecha" params="[filterBy: params.filterBy, filter: params.filter]" />

            <g:sortableColumn property="stop" title="Atracción" params="[filterBy: params.filterBy, filter: params.filter]"  />

            <g:sortableColumn property="stop.city.name" title="Ciudad" params="[filterBy: params.filterBy, filter: params.filter]"  />

            <g:sortableColumn property="stop.city.country.name" title="País" params="[filterBy: params.filterBy, filter: params.filter]"  />

            <g:sortableColumn property="author" title="Autor" params="[filterBy: params.filterBy, filter: params.filter]"  />

            <g:sortableColumn property="text" title="Comentario" params="[filterBy: params.filterBy, filter: params.filter]" />

            <g:sortableColumn property="score" title="Puntaje" params="[filterBy: params.filterBy, filter: params.filter]" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${reviews}" status="i" var="reviewInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td> ${reviewInstance.date} </td>

                <td><g:link controller="attraction" action="edit" id="${reviewInstance.stop.id}">${reviewInstance.stop}</g:link></td>

                <td> ${reviewInstance.stop.city.name} </td>

                <td> ${reviewInstance.stop.city.country.name} </td>

                <td> ${reviewInstance.author} </td>

                <td> ${reviewInstance.text} </td>

                <td> ${reviewInstance.score} </td>

                <td>${fieldValue(bean: reviewInstance, field: "date")}</td>

                %{--<td><g:link action="edit" id="${reviewInstance.id}">${fieldValue(bean: reviewInstance, field: "name")}</g:link></td>
--}%
                <td class="borrarColumn"><a class="btn btn-danger" data-href="deleteReview?id=${reviewInstance.id}" data-toggle="modal" data-target="#confirm-delete"> Borrar </a></td>

            </tr>

        </g:each>
        </tbody>
    </table>
    <div class="pagination">
        <boots:paginate action="list" max="${numberOfRecords}" offset="${offset}" date1="${date1}" date2="${date2}" total="${reviewInstanceCount ?: 0}" />

        %{--<g:paginate total="${reviewInstanceCount ?: 0}" />--}%
    </div>

    <div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    Borrar Atracción
                </div>
                <div class="modal-body">
                    ¿ Está seguro que desea eliminar la Reseña?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-danger btn-ok">Delete</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        $('#datetimepicker6').datetimepicker({
            useCurrent: true

        });
        $('#datetimepicker7').datetimepicker();

        $("#datetimepicker6").on("dp.change", function (e) {
            $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker7").on("dp.change", function (e) {
            $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
        });
        $('#datetimepicker6').data("DateTimePicker").date('${date1}');
        $('#datetimepicker7').data("DateTimePicker").date('${date2}');
    });

    $('#confirm-delete').on('show.bs.modal', function(e) {
        $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
    });
</script>
</body>
</html>