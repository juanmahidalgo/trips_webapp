
<%@ page import="tripswebapp.model.City" %>
<!DOCTYPE html>
<html>
<head>
    <title> Lista de Ciudades </title>
    <meta name="layout" content="mainLayout">
    <g:set var="entityName" value="${message(code: 'city.label', default: 'City')}" />
</head>
<body>
<ol class="breadcrumb">
    <li><a href="${createLink(uri: '/')}">Home</a></li>
    <li class="active">Lista de Ciudades </li>
</ol>

<div id="list-city" class="content scaffold-list" role="main">
    <h1> Lista de Ciudades </h1>

    <g:if test="${flash.error}">
        <div class="alert alert-danger" style="display: block">${flash.error}</div>
    </g:if>
    <g:if test="${flash.message}">
        <div class="alert alert-info" role="status">${flash.message}</div>
    </g:if>
    <g:link class="btn btn-success btn-add" action="create"> Crear Ciudad </g:link>

    <table class="table table-hover">
        <thead>
        <tr>
            <g:sortableColumn property="name" title="${message(code: 'city.name.label', default: 'Nombre')}" />
            <g:sortableColumn property="country.name" title="País"/>
        </tr>
        </thead>
        <tbody>
        <g:each in="${cityInstanceList}" status="i" var="cityInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td><g:link action="edit" id="${cityInstance.id}">${fieldValue(bean: cityInstance, field: "name")}</g:link></td>
                <td> ${cityInstance.country?.name}</td>
                <td class="borrarColumn"><a class="btn btn-danger" data-href="deleteCity?id=${cityInstance.id}" data-toggle="modal" data-target="#confirm-delete"> Borrar </a></td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pagination">
        <boots:paginate total="${cityInstanceCount ?: 0}" />
    </div>
    <div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    Borrar Atracción
                </div>
                <div class="modal-body">
                    ¿ Está seguro que desea eliminar la Ciudad ?
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
