<%@ page import="tripswebapp.model.Route" %>

<div class="fieldcontain inputField ${hasErrors(bean: routeInstance, field: 'city', 'error')} required">
	<label for="city">
		<g:message code="route.city.label" default="Ciudad" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="city" name="city.id" from="${tripswebapp.model.City.list()}" optionKey="id" required="" value="${routeInstance?.city?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: routeInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="route.name.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${routeInstance?.name}"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: routeInstance, field: 'stops', 'error')} ">
	<label for="stops">
		<g:message code="route.stop.label" default="Paradas" />
	</label>
	<g:select name="stops" id="stops"
			  from="${routeInstance.city ? routeInstance.city.attractions : ''}"
			  value="${routeInstance.stops ? routeInstance.stops : ''}"
			  optionKey="id"
			  optionValue="name"
			  style="width: 350px;"
			  class="chosen-select"
			  multiple="true"
	/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: routeInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="route.description.label" default="Descripción" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${routeInstance?.description}"/>
</div>

%{--
<div class="fieldcontain">
	<g:if test="${routeInstance?.image}">
		<label for="imageFile"> Cambiar Imagen: (max 10 mb) </label>
	</g:if>
	<g:else>
		<label for="imageFile"> Subir Imagen: (max 10 mb) </label>
	</g:else>
	<input  type="file" name="imageFile">
</div>--}%

<script type="application/javascript">
    $().ready(function(){
        $("#stops").chosen({no_results_text: "No se encontraron resultados!"});
        $("#city").chosen({no_results_text: "No se encontraron resultados!"});
    });
</script>
