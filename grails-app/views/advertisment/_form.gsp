<%@ page import="tripswebapp.model.Advertisment" %>

<div class="${hasErrors(bean: routeInstance, field: 'city', 'error')} required">
	<label for="city">
		<g:message code="advertisment.city.label" default="Ciudad" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="city" name="city.id" from="${tripswebapp.model.City.list()}" style="width: 350px;" optionKey="id" required="" value="${advertismentInstance?.city?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: advertismentInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="advertisment.title.label" default="Título" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${advertismentInstance?.title}"/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: advertismentInstance, field: 'subtitle', 'error')} required">
	<label for="subtitle">
		<g:message code="advertisment.subtitle.label" default="Subtitulo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="subtitle" required="" value="${advertismentInstance?.subtitle}"/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: advertismentInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="advertisment.description.label" default="Descripción" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${advertismentInstance?.description}"/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: advertismentInstance, field: 'link', 'error')} required">
	<label for="link">
		<g:message code="advertisment.link.label" default="Link" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="link" required="" value="${advertismentInstance?.link}"/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: advertismentInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="advertisment.latitude.label" default="Latitud" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="latitude" value="${fieldValue(bean: advertismentInstance, field: 'latitude')}" required=""/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: advertismentInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="advertisment.longitude.label" default="Longitud" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="longitude" value="${fieldValue(bean: advertismentInstance, field: 'longitude')}" required=""/>
</div>

%{--<div class="fieldcontain inputField ${hasErrors(bean: advertismentInstance, field: 'image', 'error')} ">
	<label for="image">
		<g:message code="advertisment.image.label" default="Image" />
		
	</label>
	<g:select id="image" name="image.id" from="${tripswebapp.media.Image.list()}" optionKey="id" value="${advertismentInstance?.image?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>--}%

<g:if test="${context == 'edit'}">
	<div class="fieldcontain images">
		<span id="image-label" class="property-label"> Imágen </span> :
		<g:if test="${advertismentInstance?.image}">
			<img src="${resource(dir: 'images/cities', file: advertismentInstance.image?.path)}" alt="img"/>
		</g:if>
		<g:else>
			<b> No image loaded </b>
		</g:else>
	</div>
</g:if>

<div class="fieldcontain">
	<g:if test="${advertismentInstance?.image}">
		<label for="imageFile"> Cambiar Imagen: (max 10 mb) </label>
	</g:if>
	<g:else>
		<label for="imageFile"> Subir Imagen: (max 10 mb) </label>
	</g:else>
	<input type="file" name="imageFile" accept=".jpeg,.png">
</div>

<script type="application/javascript">
    $().ready(function(){
        $("#city").chosen({no_results_text: "No se encontraron resultados!"});
    });
</script>


