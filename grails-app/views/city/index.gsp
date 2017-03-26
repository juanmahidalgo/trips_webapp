
<%@ page import="tripswebapp.model.City" %>
<!DOCTYPE html>
<html>
<head>
	<title> Cities list </title>
	<meta name="layout" content="mainLayout">
	<g:set var="entityName" value="${message(code: 'city.label', default: 'City')}" />
</head>
<body>
<ol class="breadcrumb">
	<li><a href="${createLink(uri: '/')}">Home</a></li>
	<li class="active">List</li>
</ol>

<div id="list-city" class="content scaffold-list" role="main">
	<h1><g:message code="default.list.label" args="[entityName]" /></h1>
	<g:link class="btn btn-success btn-add" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>

	<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
	</g:if>
	<table class="table table-hover">
		<thead>
		<tr>

			<g:sortableColumn property="name" title="${message(code: 'city.name.label', default: 'Name')}" />
			<th><g:message code="city.country.label" default="Country" /></th>

		</tr>
		</thead>
		<tbody>
		<g:each in="${cityInstanceList}" status="i" var="cityInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

				<td><g:link action="show" id="${cityInstance.id}">${fieldValue(bean: cityInstance, field: "name")}</g:link></td>
				<td><g:link action="show" id="${cityInstance.id}">${cityInstance.country?.name}</g:link></td>


			</tr>
		</g:each>
		</tbody>
	</table>
	<div class="pagination">
		<g:paginate total="${cityInstanceCount ?: 0}" />
	</div>
</div>
</body>
</html>
