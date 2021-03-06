<%--
  Created by IntelliJ IDEA.
  User: jhidalgo
  Date: 4/9/17
  Time: 9:38 PM
--%>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainLayout">
    <title> Lista de Recorridos </title>

</head>
<body>
<ol class="breadcrumb">
    <li><a href="${createLink(uri: '/')}">Home</a></li>
    <li class="active">Lista de Recorridos </li>
</ol>
<div id="list-reviews" class="content scaffold-list" role="main">
    <h1> Lista de Recorridos </h1>
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
                    <option value="id"> Id </option>
                    <option value="name"> Nombre </option>
                    <option value="city"> Ciudad </option>
                </select>
            </div>
            <div class="col-md-2">
                <input type="text" class="form-control" name="filter">
            </div>
            <div class="col-md-2">
                <input class="btn-filtro btn btn-info" type="submit" value="Filtrar">
            </div>
        </div>
    </form>

    <g:link class="btn btn-success btn-add" action="create"> Crear Recorrido </g:link></li>

    <table class="table table-hover">
        <thead>
        <tr>
            <g:sortableColumn property="id" title="ID" params="[filterBy: params.filterBy, filter: params.filter]" />
            <g:sortableColumn property="name" title="Nombre" params="[filterBy: params.filterBy, filter: params.filter]"  />
            <g:sortableColumn property="description" title="Descripción" params="[filterBy: params.filterBy, filter: params.filter]"  />
            <g:sortableColumn property="city" title="Ciudad" params="[filterBy: params.filterBy, filter: params.filter]"  />
            <th> Paradas </th>
%{--
            <th> Idiomas </th>
--}%
        </tr>
        </thead>
        <tbody>
        <g:each in="${routes}" status="i" var="routeInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td> ${routeInstance.id} </td>
                <td><g:link action="edit" id="${routeInstance.id}"> ${routeInstance.name}</g:link></td>
                <td> ${routeInstance.description} </td>
                <td><g:link controller="city" action="edit" id="${routeInstance.city?.id}">${routeInstance.city?.name}</g:link></td>
                <td> ${routeInstance.stops?.size()} </td>

            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pagination">
        <boots:paginate action="list" max="${numberOfRecords}" offset="${offset}" total="${routeInstanceCount ?: 0}" />
    </div>

    <div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    Borrar el recorrido
                </div>
                <div class="modal-body">
                    ¿ Está seguro que desea borrar el recorrido?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    <a id="confirmButton" class="btn btn-danger btn-ok">
                        Borrar
                    </a>
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