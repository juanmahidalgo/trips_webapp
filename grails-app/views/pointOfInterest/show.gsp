
<%@ page import="tripswebapp.model.PointOfInterest" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pointOfInterest.label', default: 'PointOfInterest')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-pointOfInterest" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-pointOfInterest" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list pointOfInterest">
			
				<g:if test="${pointOfInterestInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="pointOfInterest.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${pointOfInterestInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pointOfInterestInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="pointOfInterest.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${pointOfInterestInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pointOfInterestInstance?.attraction}">
				<li class="fieldcontain">
					<span id="attraction-label" class="property-label"><g:message code="pointOfInterest.attraction.label" default="Attraction" /></span>
					
						<span class="property-value" aria-labelledby="attraction-label"><g:link controller="attraction" action="show" id="${pointOfInterestInstance?.attraction?.id}">${pointOfInterestInstance?.attraction?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${pointOfInterestInstance?.audioGuide}">
				<li class="fieldcontain">
					<span id="audioGuide-label" class="property-label"><g:message code="pointOfInterest.audioGuide.label" default="Audio Guide" /></span>
					
						<span class="property-value" aria-labelledby="audioGuide-label"><g:link controller="audioGuide" action="show" id="${pointOfInterestInstance?.audioGuide?.id}">${pointOfInterestInstance?.audioGuide?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${pointOfInterestInstance?.image}">
				<li class="fieldcontain">
					<span id="image-label" class="property-label"><g:message code="pointOfInterest.image.label" default="Image" /></span>
					
						<span class="property-value" aria-labelledby="image-label"><g:link controller="image" action="show" id="${pointOfInterestInstance?.image?.id}">${pointOfInterestInstance?.image?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:pointOfInterestInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${pointOfInterestInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
