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
    <title> Lista de Usuarios </title>

</head>
<body>
<ol class="breadcrumb">
    <li><a href="${createLink(uri: '/')}">Home</a></li>
    <li class="active">Lista de Usuarios </li>
</ol>
<div id="list-reviews" class="content scaffold-list" role="main">
    <h1> Lista de Usuarios </h1>
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

    <table class="table table-hover">
        <thead>
        <tr>
            <g:sortableColumn property="id" title="ID" params="[filterBy: params.filterBy, filter: params.filter]" />
            <g:sortableColumn property="name" title="Nombre" params="[filterBy: params.filterBy, filter: params.filter]"  />
            <g:sortableColumn property="blocked" title="Estado" params="[filterBy: params.filterBy, filter: params.filter]"  />
        </tr>
        </thead>
        <tbody>
        <g:each in="${users}" status="i" var="userInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td> ${userInstance.id} </td>
                    <td> ${userInstance.name} </td>
                    <td> ${userInstance.blocked ? 'Bloqueado' : 'No bloqueado'} </td>
                    <td class="borrarColumn">
                        <a class="btn btn-danger" data-href="blockUser?id=${userInstance.id}&blocked=${userInstance.blocked}" data-toggle="modal" data-target="#confirm-delete">
                            <g:if test="${userInstance?.blocked}">
                                Desbloquear
                            </g:if>
                            <g:else>
                                Bloquear
                            </g:else>
                        </a>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
    <div class="pagination">
        <boots:paginate action="list" max="${numberOfRecords}" offset="${offset}" total="${userInstance ?: 0}" />
        %{--<g:paginate total="${reviewInstanceCount ?: 0}" />--}%
    </div>

    <div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    Borrar Usuario
                </div>
                <div class="modal-body">
                    ¿ Está seguro que desea bloquear al Usuario?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    <a class="btn btn-danger btn-ok">
                        <g:if test="${userInstance?.blocked}">
                            Desbloquear
                        </g:if>
                        <g:else>
                            Bloquear
                        </g:else>
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