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

        <label> Filtrar por: </label>
        <div class="col-md-4">
            <select name="filterBy">
                <option value="stop"> Atracción </option>
                <option value="city"> Ciudad </option>
                <option value="country"> País </option>
                <option value="author"> Autor </option>
                <option value="text"> Texto </option>
                <option value="score"> Puntaje </option>
            </select>
        </div>
        <div class="col-md-3">
            <input type="text" name="filter">
        </div>
        <div class="col-md-2">
            <input class="btn-filtro btn btn-info" type="submit" value="Filtrar">
        </div>
    </form>


    <table class="table table-hover">
        <thead>
        <tr>

            <g:sortableColumn property="date" title="Fecha" />

            <g:sortableColumn property="stop" title="Atracción" />

            <g:sortableColumn property="stop.city.name" title="Ciudad" />

            <g:sortableColumn property="stop.city.country.name" title="País" />

            <g:sortableColumn property="author" title="Autor" />

            <g:sortableColumn property="text" title="Comentario" />

            <g:sortableColumn property="score" title="Puntaje" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${reviewInstanceList}" status="i" var="reviewInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td> ${reviewInstance.date} </td>

                <td> ${reviewInstance.stop} </td>

                <td> ${reviewInstance.stop.city.name} </td>

                <td> ${reviewInstance.stop.city.country.name} </td>

                <td> ${reviewInstance.author} </td>

                <td> ${reviewInstance.text} </td>

                <td> ${reviewInstance.score} </td>

                <td>${fieldValue(bean: reviewInstance, field: "date")}</td>

                %{--<td><g:link action="edit" id="${reviewInstance.id}">${fieldValue(bean: reviewInstance, field: "name")}</g:link></td>
--}%
                <td class="borrarColumn"><a class="btn btn-danger" data-href="/deleteReview?id=${reviewInstance.id}" data-toggle="modal" data-target="#confirm-delete"> Borrar </a></td>

            </tr>

        </g:each>
        </tbody>
    </table>
    <div class="pagination">
        <g:paginate total="${reviewInstanceCount ?: 0}" />
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
    $('#confirm-delete').on('show.bs.modal', function(e) {
        $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
    });
</script>
</body>
</html>