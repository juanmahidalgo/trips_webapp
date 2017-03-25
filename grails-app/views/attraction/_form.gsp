<%@ page import="tripswebapp.model.Attraction" %>



<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'audioGuide', 'error')} required">
	<label for="audioGuide">
		<g:message code="attraction.audioGuide.label" default="Audio Guide" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="audioGuide" name="audioGuide.id" from="${tripswebapp.media.AudioGuide.list()}" optionKey="id" required="" value="${attractionInstance?.audioGuide?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'averageTime', 'error')} required">
	<label for="averageTime">
		<g:message code="attraction.averageTime.label" default="Average Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="averageTime" type="number" value="${attractionInstance.averageTime}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'classification', 'error')} required">
	<label for="classification">
		<g:message code="attraction.classification.label" default="Classification" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="classification" name="classification.id" from="${tripswebapp.utils.Classification.list()}" optionKey="id" required="" value="${attractionInstance?.classification?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'cost', 'error')} required">
	<label for="cost">
		<g:message code="attraction.cost.label" default="Cost" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="cost" value="${fieldValue(bean: attractionInstance, field: 'cost')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="attraction.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${attractionInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'images', 'error')} ">
	<label for="images">
		<g:message code="attraction.images.label" default="Images" />
		
	</label>
	<g:select name="images" from="${tripswebapp.media.Image.list()}" multiple="multiple" optionKey="id" size="5" value="${attractionInstance?.images*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="attraction.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="latitude" value="${fieldValue(bean: attractionInstance, field: 'latitude')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="attraction.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="longitude" value="${fieldValue(bean: attractionInstance, field: 'longitude')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'maps', 'error')} ">
	<label for="maps">
		<g:message code="attraction.maps.label" default="Maps" />
		
	</label>
	<g:select name="maps" from="${tripswebapp.media.AttractionMap.list()}" multiple="multiple" optionKey="id" size="5" value="${attractionInstance?.maps*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="attraction.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${attractionInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'pointsOfInterest', 'error')} ">
	<label for="pointsOfInterest">
		<g:message code="attraction.pointsOfInterest.label" default="Points Of Interest" />
		
	</label>
	<g:select name="pointsOfInterest" from="${tripswebapp.model.PointOfInterest.list()}" multiple="multiple" optionKey="id" size="5" value="${attractionInstance?.pointsOfInterest*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'schedule', 'error')} required">
	<label for="schedule">
		<g:message code="attraction.schedule.label" default="Schedule" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="schedule" required="" value="${attractionInstance?.schedule}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: attractionInstance, field: 'videos', 'error')} ">
	<label for="videos">
		<g:message code="attraction.videos.label" default="Videos" />
		
	</label>
	<g:select name="videos" from="${tripswebapp.media.Video.list()}" multiple="multiple" optionKey="id" size="5" value="${attractionInstance?.videos*.id}" class="many-to-many"/>

</div>

