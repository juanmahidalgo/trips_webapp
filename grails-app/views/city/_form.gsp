<%@ page import="tripswebapp.model.City" %>

<div class="fieldcontain inputField ${hasErrors(bean: cityInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="city.name.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name"  id="locality" required="" value="${cityInstance?.name}" readonly="readonly"/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: cityInstance, field: 'country', 'error')} required">
	<label for="country">
		<g:message code="city.country.label" default="País" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField id="country" name="country" style="width: 350px;" required="" value="${cityInstance?.country?.name}" class="many-to-one" readonly="readonly"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: cityInstance, field: 'state', 'error')}">
	<label for="state">
		<g:message code="city.state.label" default="Estado" />
	</label>
	<g:textField id="administrative_area_level_1" name="state" value="${cityInstance?.state}" readonly="readonly"/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: cityInstance, field: 'latitude', 'error')}">
	<label for="latitude">
		<g:message code="city.latitude.label" default="Latitud" />
	</label>
	<g:textField id="latitude" name="latitude" value="${cityInstance?.latitude}" readonly="readonly"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: cityInstance, field: 'longitude', 'error')}">
	<label for="state">
		<g:message code="city.longitude.label" default="Longitude" />
	</label>
	<g:textField id="longitude" name="longitude" value="${cityInstance?.longitude}" readonly="readonly"/>

</div>

%{--
<div class="fieldcontain ${hasErrors(bean: cityInstance, field: 'attractions', 'error')} ">
--}%
	%{--<label for="attractions">
		<g:message code="city.attractions.label" default="Attractions" />
		
	</label>
	<g:select name="attractions" from="${tripswebapp.model.Attraction.list()}" multiple="multiple" optionKey="id" size="5" value="${cityInstance?.attractions*.id}" class="many-to-many"/>
--}%
%{--
</div>
--}%
<g:if test="${contexto == 'edit'}">
	<div class="fieldcontain images">
		<span id="image-label" class="property-label"> Imágen </span> :
		<g:if test="${cityInstance?.image}">
			<img src="${resource(dir: 'images/cities', file: cityInstance.image.path)}" alt="img"/>
		</g:if>
		<g:else>
			<b> No image loaded </b>
		</g:else>
	</div>
</g:if>

<div class="fieldcontain">
	<g:if test="${cityInstance?.image}">
		<label for="imageFile"> Cambiar Imagen: (max 10 mb) </label>
	</g:if>
	<g:else>
		<label for="imageFile"> Subir Imagen: (max 10 mb) </label>
	</g:else>
	<input type="file" name="imageFile">
</div>

<script type="application/javascript">
        $(".chosen-select ").chosen({no_results_text: "No se encontraron resultados!"});
</script>