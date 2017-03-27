
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
			<li class="active">List</li>
		</ol>
		<div id="list-attraction" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
		<g:link class="btn btn-success btn-add" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>

			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-hover">
			<thead>
					<tr>

						<g:sortableColumn property="name" title="${message(code: 'attraction.name.label', default: 'Name')}" />

						<g:sortableColumn property="description" title="${message(code: 'attraction.description.label', default: 'Description')}" />

						<g:sortableColumn property="averageTime" title="${message(code: 'attraction.averageTime.label', default: 'Average Time')}" />

						<g:sortableColumn property="cost" title="${message(code: 'attraction.cost.label', default: 'Price')}" />

						<g:sortableColumn property="telephone" title="${message(code: 'attraction.telephone.label', default: 'Telephone')}" />

						<g:sortableColumn property="address" title="${message(code: 'attraction.address.label', default: 'Address')}" />

						<g:sortableColumn property="latitude" title="${message(code: 'attraction.latitude.label', default: 'Latitude')}" />

						<g:sortableColumn property="longitude" title="${message(code: 'attraction.longitude.label', default: 'Longitude')}" />

						<th><g:message code="attraction.classification.label" default="Classification" /></th>

						<th><g:message code="attraction.audioGuide.label" default="Audio Guide" /></th>

					</tr>
				</thead>
				<tbody>
				<g:each in="${attractionInstanceList}" status="i" var="attractionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="show" id="${attractionInstance.id}">${fieldValue(bean: attractionInstance, field: "name")}</g:link></td>

						<td>${fieldValue(bean: attractionInstance, field: "description")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "averageTime")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "cost")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "telephone")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "address")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "latitude")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "longitude")}</td>

						<td>${fieldValue(bean: attractionInstance, field: "classification")}</td>

						<td><g:link action="show" id="${attractionInstance.id}">${fieldValue(bean: attractionInstance, field: "audioGuide")}</g:link></td>

					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${attractionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
