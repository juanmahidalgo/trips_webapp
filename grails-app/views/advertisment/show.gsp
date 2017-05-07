
<%@ page import="tripswebapp.model.Advertisment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'advertisment.label', default: 'Advertisment')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-advertisment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-advertisment" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list advertisment">
			
				<g:if test="${advertismentInstance?.image}">
				<li class="fieldcontain">
					<span id="image-label" class="property-label"><g:message code="advertisment.image.label" default="Image" /></span>
					
						<span class="property-value" aria-labelledby="image-label"><g:link controller="image" action="show" id="${advertismentInstance?.image?.id}">${advertismentInstance?.image?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${advertismentInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="advertisment.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${advertismentInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${advertismentInstance?.latitude}">
				<li class="fieldcontain">
					<span id="latitude-label" class="property-label"><g:message code="advertisment.latitude.label" default="Latitude" /></span>
					
						<span class="property-value" aria-labelledby="latitude-label"><g:fieldValue bean="${advertismentInstance}" field="latitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${advertismentInstance?.link}">
				<li class="fieldcontain">
					<span id="link-label" class="property-label"><g:message code="advertisment.link.label" default="Link" /></span>
					
						<span class="property-value" aria-labelledby="link-label"><g:fieldValue bean="${advertismentInstance}" field="link"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${advertismentInstance?.longitude}">
				<li class="fieldcontain">
					<span id="longitude-label" class="property-label"><g:message code="advertisment.longitude.label" default="Longitude" /></span>
					
						<span class="property-value" aria-labelledby="longitude-label"><g:fieldValue bean="${advertismentInstance}" field="longitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${advertismentInstance?.subtitle}">
				<li class="fieldcontain">
					<span id="subtitle-label" class="property-label"><g:message code="advertisment.subtitle.label" default="Subtitle" /></span>
					
						<span class="property-value" aria-labelledby="subtitle-label"><g:fieldValue bean="${advertismentInstance}" field="subtitle"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${advertismentInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="advertisment.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${advertismentInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:advertismentInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${advertismentInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
