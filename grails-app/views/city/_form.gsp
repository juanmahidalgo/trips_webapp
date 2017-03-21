<%@ page import="tripswebapp.model.City" %>



<div class="fieldcontain ${hasErrors(bean: cityInstance, field: 'attractions', 'error')} ">
	<label for="attractions">
		<g:message code="city.attractions.label" default="Attractions" />
		
	</label>
	<g:select name="attractions" from="${tripswebapp.model.Attraction.list()}" multiple="multiple" optionKey="id" size="5" value="${cityInstance?.attractions*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: cityInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="city.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${cityInstance?.name}"/>

</div>

