
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
	<li class="active">Lista</li>
</ol>

<div id="list-city" class="content scaffold-list" role="main">
	<h1> Lista de Ciudades </h1>

	<g:if test="${flash.error}">
		<div class="alert alert-danger" style="display: block">${flash.error}</div>
	</g:if>
	<g:if test="${flash.message}">
		<div class="aler alert-success" role="status">${flash.message}</div>
	</g:if>
	<table class="table table-hover">
		<thead>
		<tr>
			<g:sortableColumn property="name" title="${message(code: 'city.name.label', default: 'Nombre')}" />
			<th><g:message code="city.country.label" default="Country" /></th>
		</tr>
		</thead>
		<tbody>
		<g:each in="${cityInstanceList}" status="i" var="cityInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				<td><g:link action="show" id="${cityInstance.id}">${fieldValue(bean: cityInstance, field: "name")}</g:link></td>
				<td> ${cityInstance.country?.name}</td>
			</tr>
		</g:each>
		</tbody>
	</table>
	<g:link class="btn btn-success btn-add" action="create"> Crear Ciudad </g:link>
	<div class="pagination">
		<g:paginate total="${cityInstanceCount ?: 0}" />
	</div>
</div>
</body>
</html>
