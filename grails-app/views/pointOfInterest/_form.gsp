<%@ page import="tripswebapp.model.PointOfInterest" %>



<div class="fieldcontain inputField ${hasErrors(bean: pointOfInterestInstance, field: 'Nombre', 'error')} ">
	<label for="name">
		<g:message code="pointOfInterest.name.label" default="Nombre" />
		
	</label>
	<g:textField name="name" value="${pointOfInterestInstance?.name}"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: pointOfInterestInstance, field: 'Descripción', 'error')} ">
	<label for="description">
		Descripción
	</label>
	<g:textField name="description" value="${pointOfInterestInstance?.description}"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: pointOfInterestInstance, field: 'Atracción', 'error')} required">
	<label for="attraction">
		Atracción
		<span class="required-indicator">*</span>
	</label>
	<g:select id="attraction" name="attraction.id" from="${tripswebapp.model.Attraction.list()}" optionKey="id" required="" value="${pointOfInterestInstance?.attraction?.id}" class="many-to-one" readonly="readonly"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: pointOfInterestInstance, field: 'Audio Guia', 'error')} required">
	<label for="audioGuide">
		AudioGuia
		<span class="required-indicator">*</span>
	</label>
	<g:select id="audioGuide" name="audioGuide.id" from="${tripswebapp.media.AudioGuide.list()}" optionKey="id" required="" value="${pointOfInterestInstance?.audioGuide?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: pointOfInterestInstance, field: 'Imagen', 'error')} required">
	<label for="image">
		Imagen
		<span class="required-indicator">*</span>
	</label>
	<g:select id="image" name="image.id" from="${tripswebapp.media.Image.list()}" optionKey="id" required="" value="${pointOfInterestInstance?.image?.id}" class="many-to-one"/>
</div>

<div class="">
	<label for="traductions">
		<g:message code="pointOfInterest.traductions.label" default="Idiomas" />
	</label>
	<g:each var="traduction" in="${pointOfInterestInstance?.traductions}" status="i">
		<g:link params="[id: pointOfInterestInstance?.id, traductionId: traduction.id]" action="loadTraduction" class=""> ${traduction} </g:link>
	</g:each>
	<g:link params="[id: pointOfInterestInstance?.id]" action="loadTraduction" class="btn btn-info"> Cargar Traducción </g:link>
</div>