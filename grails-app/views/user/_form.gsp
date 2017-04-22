<%@ page import="tripswebapp.model.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'favourites', 'error')} ">
	<label for="favourites">
		<g:message code="user.favourites.label" default="Favourites" />
		
	</label>
	<g:select name="favourites" from="${tripswebapp.model.Stop.list()}" multiple="multiple" optionKey="id" size="5" value="${userInstance?.favourites*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'visited', 'error')} ">
	<label for="visited">
		<g:message code="user.visited.label" default="Visited" />
		
	</label>
	<g:select name="visited" from="${tripswebapp.model.Stop.list()}" multiple="multiple" optionKey="id" size="5" value="${userInstance?.visited*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${userInstance?.password}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'blocked', 'error')} ">
	<label for="blocked">
		<g:message code="user.blocked.label" default="Blocked" />
		
	</label>
	<g:checkBox name="blocked" value="${userInstance?.blocked}" />

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="user.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${userInstance?.name}"/>

</div>

