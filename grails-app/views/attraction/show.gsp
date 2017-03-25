
<%@ page import="tripswebapp.model.Attraction" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'attraction.label', default: 'Attraction')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-attraction" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-attraction" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list attraction">
			
				<g:if test="${attractionInstance?.audioGuide}">
				<li class="fieldcontain">
					<span id="audioGuide-label" class="property-label"><g:message code="attraction.audioGuide.label" default="Audio Guide" /></span>
					
						<span class="property-value" aria-labelledby="audioGuide-label"><g:link controller="audioGuide" action="show" id="${attractionInstance?.audioGuide?.id}">${attractionInstance?.audioGuide?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${attractionInstance?.averageTime}">
				<li class="fieldcontain">
					<span id="averageTime-label" class="property-label"><g:message code="attraction.averageTime.label" default="Average Time" /></span>
					
						<span class="property-value" aria-labelledby="averageTime-label"><g:fieldValue bean="${attractionInstance}" field="averageTime"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${attractionInstance?.classification}">
				<li class="fieldcontain">
					<span id="classification-label" class="property-label"><g:message code="attraction.classification.label" default="Classification" /></span>
					
						<span class="property-value" aria-labelledby="classification-label"><g:link controller="classification" action="show" id="${attractionInstance?.classification?.id}">${attractionInstance?.classification?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${attractionInstance?.cost}">
				<li class="fieldcontain">
					<span id="cost-label" class="property-label"><g:message code="attraction.cost.label" default="Cost" /></span>
					
						<span class="property-value" aria-labelledby="cost-label"><g:fieldValue bean="${attractionInstance}" field="cost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${attractionInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="attraction.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${attractionInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${attractionInstance?.images}">
				<li class="fieldcontain">
					<span id="images-label" class="property-label"><g:message code="attraction.images.label" default="Images" /></span>
					
						<g:each in="${attractionInstance.images}" var="i">
						<span class="property-value" aria-labelledby="images-label"><g:link controller="image" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${attractionInstance?.latitude}">
				<li class="fieldcontain">
					<span id="latitude-label" class="property-label"><g:message code="attraction.latitude.label" default="Latitude" /></span>
					
						<span class="property-value" aria-labelledby="latitude-label"><g:fieldValue bean="${attractionInstance}" field="latitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${attractionInstance?.longitude}">
				<li class="fieldcontain">
					<span id="longitude-label" class="property-label"><g:message code="attraction.longitude.label" default="Longitude" /></span>
					
						<span class="property-value" aria-labelledby="longitude-label"><g:fieldValue bean="${attractionInstance}" field="longitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${attractionInstance?.maps}">
				<li class="fieldcontain">
					<span id="maps-label" class="property-label"><g:message code="attraction.maps.label" default="Maps" /></span>
					
						<g:each in="${attractionInstance.maps}" var="m">
						<span class="property-value" aria-labelledby="maps-label"><g:link controller="attractionMap" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${attractionInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="attraction.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${attractionInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${attractionInstance?.pointsOfInterest}">
				<li class="fieldcontain">
					<span id="pointsOfInterest-label" class="property-label"><g:message code="attraction.pointsOfInterest.label" default="Points Of Interest" /></span>
					
						<g:each in="${attractionInstance.pointsOfInterest}" var="p">
						<span class="property-value" aria-labelledby="pointsOfInterest-label"><g:link controller="pointOfInterest" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${attractionInstance?.schedule}">
				<li class="fieldcontain">
					<span id="schedule-label" class="property-label"><g:message code="attraction.schedule.label" default="Schedule" /></span>
					
						<span class="property-value" aria-labelledby="schedule-label"><g:fieldValue bean="${attractionInstance}" field="schedule"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${attractionInstance?.videos}">
				<li class="fieldcontain">
					<span id="videos-label" class="property-label"><g:message code="attraction.videos.label" default="Videos" /></span>
					
						<g:each in="${attractionInstance.videos}" var="v">
						<span class="property-value" aria-labelledby="videos-label"><g:link controller="video" action="show" id="${v.id}">${v?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:attractionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${attractionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
