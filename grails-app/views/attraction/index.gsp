
<%@ page import="tripswebapp.model.Attraction" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainLayout">

		<g:set var="entityName" value="${message(code: 'attraction.label', default: 'Attraction')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<ol class="breadcrumb">
			<li><a href="${createLink(uri: '/')}">Home</a></li>
			<li class="active">Lista de Atracciones </li>
		</ol>
		<div id="list-attraction" class="content scaffold-list" role="main">
			<h1> Lista de Atracciones </h1>
		<g:link class="btn btn-success btn-add" action="create"> Crear Atracción </g:link></li>

			<g:if test="${flash.message}">
				<div class="alert alert-info message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-hover">
			<thead>
					<tr>

						<g:sortableColumn property="name" title="Nombre" />

						<g:sortableColumn property="city" title="Ciudad" />

						<g:sortableColumn property="city.country.name" title="País" />

						<g:sortableColumn property="description" title="Descripción" />

						<g:sortableColumn property="averageTime" title="Tiempo de visita " />

						<g:sortableColumn property="cost" title="Precio (usd)" />

						<g:sortableColumn property="telephone" title="Teléfono" />

						<th><g:message code="attraction.classification.label" default="Clasificación" /></th>

					</tr>
				</thead>
				<tbody>
				<g:each in="${attractionInstanceList}" status="i" var="attractionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="edit" id="${attractionInstance.id}">${fieldValue(bean: attractionInstance, field: "name")}</g:link></td>

						<td>${fieldValue(bean: attractionInstance, field: "city")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "city.country.name")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "description")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "averageTime")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "cost")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "telephone")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "classification")}</td>

						<td class="borrarColumn"><a class="btn btn-danger" data-href="attraction/deleteAtracction?id=${attractionInstance.id}" data-toggle="modal" data-target="#confirm-delete"> Borrar </a></td>

					</tr>

				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${attractionInstanceCount ?: 0}" />
			</div>

			<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							Borrar Atracción
						</div>
						<div class="modal-body">
							¿ Está seguro que desea eliminar la atracción?
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
