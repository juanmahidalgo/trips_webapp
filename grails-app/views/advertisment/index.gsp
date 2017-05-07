
<%@ page import="tripswebapp.model.Advertisment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'advertisment.label', default: 'Advertisment')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-advertisment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-advertisment" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="advertisment.image.label" default="Image" /></th>
					
						<g:sortableColumn property="description" title="${message(code: 'advertisment.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="latitude" title="${message(code: 'advertisment.latitude.label', default: 'Latitude')}" />
					
						<g:sortableColumn property="link" title="${message(code: 'advertisment.link.label', default: 'Link')}" />
					
						<g:sortableColumn property="longitude" title="${message(code: 'advertisment.longitude.label', default: 'Longitude')}" />
					
						<g:sortableColumn property="subtitle" title="${message(code: 'advertisment.subtitle.label', default: 'Subtitle')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${advertismentInstanceList}" status="i" var="advertismentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${advertismentInstance.id}">${fieldValue(bean: advertismentInstance, field: "image")}</g:link></td>
					
						<td>${fieldValue(bean: advertismentInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: advertismentInstance, field: "latitude")}</td>
					
						<td>${fieldValue(bean: advertismentInstance, field: "link")}</td>
					
						<td>${fieldValue(bean: advertismentInstance, field: "longitude")}</td>
					
						<td>${fieldValue(bean: advertismentInstance, field: "subtitle")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${advertismentInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
