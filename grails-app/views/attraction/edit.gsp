<%@ page import="tripswebapp.model.Attraction" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainLayout">
		<g:set var="entityName" value="${message(code: 'attraction.label', default: 'Attraction')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<ol class="breadcrumb">
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			<li class="active">Edit City</li>
		</ol>
		<div id="edit-attraction" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${attractionInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${attractionInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:attractionInstance, action:'update']" method="PUT">
				<g:hiddenField name="version" value="${attractionInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save btn btn-success" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
			<g:form action="updateMaps" enctype='multipart/form-data'>
				<g:render template="mapsForm"/>
				<g:submitButton name="updateMaps" class="save btn btn-success" value="${message(code: 'default.button.updateMaps.label', default: 'Update Maps')}" />
			</g:form>

		</div>
	</body>
</html>
