<%@ page import="tripswebapp.model.City" %>
<!DOCTYPE html>
<html>
	<head>
		<title> Edit City </title>
		<meta name="layout" content="mainLayout">
		<g:set var="entityName" value="${message(code: 'city.label', default: 'City')}" />

	</head>
	<body>
		<ol class="breadcrumb">
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			<li class="active">Edit City</li>
		</ol>
		<div id="edit-city" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${cityInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${cityInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:cityInstance, action:'update']" method="PUT" class="form-group" >
				<g:hiddenField name="version" value="${cityInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save btn btn-success" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
