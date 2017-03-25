
<%@ page import="tripswebapp.model.Attraction" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainLayout">

		<g:set var="entityName" value="${message(code: 'attraction.label', default: 'Attraction')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-attraction" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create btn btn-create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-attraction" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="attraction.audioGuide.label" default="Audio Guide" /></th>
					
						<g:sortableColumn property="averageTime" title="${message(code: 'attraction.averageTime.label', default: 'Average Time')}" />
					
						<th><g:message code="attraction.classification.label" default="Classification" /></th>
					
						<g:sortableColumn property="cost" title="${message(code: 'attraction.cost.label', default: 'Cost')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'attraction.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="latitude" title="${message(code: 'attraction.latitude.label', default: 'Latitude')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${attractionInstanceList}" status="i" var="attractionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${attractionInstance.id}">${fieldValue(bean: attractionInstance, field: "audioGuide")}</g:link></td>
					
						<td>${fieldValue(bean: attractionInstance, field: "averageTime")}</td>
					
						<td>${fieldValue(bean: attractionInstance, field: "classification")}</td>
					
						<td>${fieldValue(bean: attractionInstance, field: "cost")}</td>
					
						<td>${fieldValue(bean: attractionInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: attractionInstance, field: "latitude")}</td>
					
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
