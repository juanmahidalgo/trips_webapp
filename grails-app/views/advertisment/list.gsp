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
    <title> Lista de Publicidades </title>

</head>
<body>
<ol class="breadcrumb">
    <li><a href="${createLink(uri: '/')}">Home</a></li>
    <li class="active">Lista de Publicidades </li>
</ol>
<div id="list-reviews" class="content scaffold-list" role="main">
    <h1> Lista de Publicidades </h1>
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

    <g:link class="btn btn-success btn-add" action="create"> Crear Publicidad </g:link></li>

    <table class="table table-hover">
        <thead>
        <tr>
            <g:sortableColumn property="id" title="id" params="[filterBy: params.filterBy, filter: params.filter]" />
            <g:sortableColumn property="title" title="Titulo" params="[filterBy: params.filterBy, filter: params.filter]"  />
            <g:sortableColumn property="subtitle" title="Subtitulo" params="[filterBy: params.filterBy, filter: params.filter]"  />
            <g:sortableColumn property="description" title="Descripción" params="[filterBy: params.filterBy, filter: params.filter]"  />
            <g:sortableColumn property="city" title="Ciudad" params="[filterBy: params.filterBy, filter: params.filter]"  />
        </tr>
        </thead>
        <tbody>
            <g:each in="${ads}" status="i" var="adInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td> ${adInstance.id} </td>
                    <td><g:link action="edit" id="${adInstance.id}"> ${adInstance.title}</g:link></td>
                    <td> ${adInstance.subtitle} </td>
                    <td> ${adInstance.description} </td>
                    <td><g:link controller="city" action="edit" id="${adInstance.city?.id}">${adInstance.city?.name}</g:link></td>
                    <td class="borrarColumn"><a class="btn btn-success" href="sendAdd?id=${adInstance.id}"> Enviar </a></td>
                </tr>
            </g:each>
        </tbody>
    </table>
    <div class="pagination">
        <boots:paginate action="list" max="${numberOfRecords}" offset="${offset}" total="${adInstance ?: 0}" />
    </div>

    <div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    Borrar la publicidad
                </div>
                <div class="modal-body">
                    ¿ Está seguro que desea borrar la publicidad?
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
    var string = "{'to':'ey_-qzhpyKM:APA91bG2GS5LKK8n4SoSLlVgMZEuBGpe8lPBIOeGdE2f1SWS7iQK3E8ht07GuKtYR9l8GMEzE0n6UY5S6Vc2ao9KzvkQhgpqCv0N71q5jUu13Z1XvXpRdbbzkTENh3w9_CNuNUflbH7' ,'notification':{'body':'chau','tittle':'hola','icon':'logo'}}";

    var obj = {
        notification : {
            body: 'hola',
            tittle: 'hola',
            icon: 'logo',
            click_action: 'OPEN_ADVERTISING'
        },
        data: {
            add_id: '1',
        },
        to: 'ey_-qzhpyKM:APA91bG2GS5LKK8n4SoSLlVgMZEuBGpe8lPBIOeGdE2f1SWS7iQK3E8ht07GuKtYR9l8GMEzE0n6UY5S6Vc2ao9KzvkQhgpqCv0N71q5jUu13Z1XvXpRdbbzkTENh3w9_CNuNUflbH7j',
    };
    localStorage.setItem('gameStorage', JSON.stringify(obj));
    var obj = JSON.parse(localStorage.getItem('gameStorage'));

    var string2 = '{"notification":{"body":"hola","tittle":"hola","icon":"logo"},"to":"ey_-qzhpyKM:APA91bG2GS5LKK8n4SoSLlVgMZEuBGpe8lPBIOeGdE2f1SWS7iQK3E8ht07GuKtYR9l8GMEzE0n6UY5S6Vc2ao9KzvkQhgpqCv0N71q5jUu13Z1XvXpRdbbzkTENh3w9_CNuNUflbH7j"}'
    $('#sendAdv').on('click',function(e){
        $.ajax({
            url: "https://gcm-http.googleapis.com/gcm/send",
            data: string2,
            contentType: "application/json",
            headers: {
                "Authorization": "key=AIzaSyCZgtai2IQgEKQopHC2afKkShY_sbT3J1E"
            },
            success: function(json) {
                console.log(json);
            },
            error: function(json) {
                console.log(json);
            },
            type: 'POST'
        });
    });
    $('#confirm-delete').on('show.bs.modal', function(e) {
        $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
    });
</script>
</body>
</html>