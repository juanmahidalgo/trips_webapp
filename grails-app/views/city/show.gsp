
<%@ page import="tripswebapp.model.City" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainLayout">
		<g:set var="entityName" value="${message(code: 'city.label', default: 'City')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<ol class="breadcrumb">
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			<li class="active"><g:message code="default.show.label" args="[entityName]"/></li>
		</ol>
		<div id="show-city" class="content scaffold-show" role="main">
			<h1>%{--<g:message code="default.show.label" args="[entityName]" />--}% ${cityInstance?.name} </h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list city">
			
				<g:if test="${cityInstance?.country}">
				<li class="fieldcontain">
					<span id="country-label" class="property-label"><g:message code="city.country.label" default="Country" /></span> :
					<span class="property-value" aria-labelledby="country-label"><g:link controller="country" action="show" id="${cityInstance?.country?.id}">${cityInstance?.country?.name}</g:link></span>
				</li>
				</g:if>
			
				<g:if test="${cityInstance?.attractions}">
				<li class="fieldcontain">
					<span id="attractions-label" class="property-label"><g:message code="city.attractions.label" default="Attractions" /></span> :
						<g:each in="${cityInstance.attractions}" var="a">
						<span class="property-value" aria-labelledby="attractions-label"><g:link controller="attraction" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${cityInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="city.name.label" default="Name" /></span> :
					<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${cityInstance}" field="name"/></span>
					
				</li>
				</g:if>

				<li class="fieldcontain ">
					<span id="image-label" class="property-label"><g:message code="city.image.label" default="Image" /></span> :
					<g:if test="${cityInstance?.image}">
						<img src="${resource(dir: 'images/cities', file: cityInstance.image.path)}" alt="img"/>
					</g:if>
					<g:else>
						<b>No image loaded</b>
					</g:else>
				</li>
				<g:link params="[id: cityInstance?.id, type: 'image']" action="manageImages" class="btn btn-primary"> Manage Images </g:link>

			
			</ol>
			<g:form url="[resource:cityInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit btn btn-info" action="edit" resource="${cityInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
