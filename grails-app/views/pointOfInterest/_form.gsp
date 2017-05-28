<%@ page import="tripswebapp.model.PointOfInterest" %>



<div class="fieldcontain ${hasErrors(bean: pointOfInterestInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="pointOfInterest.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${pointOfInterestInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pointOfInterestInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="pointOfInterest.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${pointOfInterestInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pointOfInterestInstance, field: 'attraction', 'error')} required">
	<label for="attraction">
		<g:message code="pointOfInterest.attraction.label" default="Attraction" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="attraction" name="attraction.id" from="${tripswebapp.model.Attraction.list()}" optionKey="id" required="" value="${pointOfInterestInstance?.attraction?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pointOfInterestInstance, field: 'audioGuide', 'error')} required">
	<label for="audioGuide">
		<g:message code="pointOfInterest.audioGuide.label" default="Audio Guide" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="audioGuide" name="audioGuide.id" from="${tripswebapp.media.AudioGuide.list()}" optionKey="id" required="" value="${pointOfInterestInstance?.audioGuide?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pointOfInterestInstance, field: 'image', 'error')} required">
	<label for="image">
		<g:message code="pointOfInterest.image.label" default="Image" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="image" name="image.id" from="${tripswebapp.media.Image.list()}" optionKey="id" required="" value="${pointOfInterestInstance?.image?.id}" class="many-to-one"/>

</div>

