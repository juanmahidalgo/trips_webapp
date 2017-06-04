<%@ page import="tripswebapp.model.PointOfInterest" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainLayout">
		<g:set var="entityName" value="${message(code: 'pointOfInterest.label', default: 'PointOfInterest')}" />
		<title> Editando punto de interés</title>
	</head>
	<body>
		<ol class="breadcrumb">
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="" action="edit" controller="attraction"> Editando atracción </g:link></li>
			<li class="active"> Editar Punto de Interés </li>
		</ol>
		<div id="edit-pointOfInterest" class="content scaffold-edit col-md-5" role="main">
			<h1> Editando punto de interés </h1>
			<g:if test="${flash.message}">
			<div class="message alert alert-info" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${pointOfInterestInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${pointOfInterestInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:pointOfInterestInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${pointOfInterestInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="btn btn-success save" action="update" value="Actualizar" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
