<%@ page import="tripswebapp.model.Attraction" %>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="attraction.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${attractionInstance?.name}"/>
</div>

<div class="${hasErrors(bean: cityInstance, field: 'city', 'error')} required">
	<label for="city">
		<g:message code="city.city.label" default="City" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="city" name="city.id" from="${tripswebapp.model.City.list()}" optionKey="id" style="width: 350px;" required="" value="${cityInstance?.city?.id}" class="many-to-one chosen-select  "/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="attraction.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${attractionInstance?.description}"/>
</div>


<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'schedule', 'error')} required">
	<label for="schedule">
		<g:message code="attraction.schedule.label" default="Schedule" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="schedule" required="" value="${attractionInstance?.schedule}"/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'averageTime', 'error')} required">
	<label for="averageTime">
		<g:message code="attraction.averageTime.label" default="Average Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="averageTime" type="number" value="${attractionInstance.averageTime}" required=""/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'cost', 'error')} required">
	<label for="cost">
		<g:message code="attraction.cost.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="cost" value="${fieldValue(bean: attractionInstance, field: 'cost')}" required=""/>
</div>


<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'telephone', 'error')} required">
	<label for="telephone">
		<g:message code="attraction.telephone.label" default="Telephone" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="telephone" value="${fieldValue(bean: attractionInstance, field: 'telephone')}" required=""/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'address', 'error')} required">
	<label for="address">
		<g:message code="attraction.telephone.label" default="Address" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="address" value="${fieldValue(bean: attractionInstance, field: 'address')}" required=""/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="attraction.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="latitude" value="${fieldValue(bean: attractionInstance, field: 'latitude')}" required=""/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="attraction.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="longitude" value="${fieldValue(bean: attractionInstance, field: 'longitude')}" required=""/>

</div>

%{--<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'maps', 'error')} ">
	<label for="maps">
		<g:message code="attraction.maps.label" default="Maps" />
	</label>
	<g:select name="maps" from="${tripswebapp.media.AttractionMap.list()}" multiple="multiple" optionKey="id" size="5" value="${attractionInstance?.maps*.id}" class="many-to-many"/>
</div>--}%
%{--<div class="fieldcontain maps">
	<label> Maps (max 3): </label>
	<g:if test="${attractionInstance?.maps}">
		<g:each var="i" in="${ (0..<3) }">
			<label> Map ${i+1} </label>
			<g:if test="${attractionInstance?.maps[i]}">
				<img src="${resource(dir: 'images/maps', file: attractionInstance?.maps[i].path)}" alt="mapa"/>
			--}%%{--
                        <input type='file' name='documentFile.{i+1}' value="${attractionInstance?.maps[i]}" />
            --}%%{--
			</g:if>
		<g:else>
			No map loaded
		</g:else>
		</g:each>
	</g:if>
</div>--}%

%{--<div class="fieldcontain">
	<input type='file' name='documentFile.2' />
	<input type='file' name='documentFile.3' />
</div>--}%

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'pointsOfInterest', 'error')} ">
	<label for="pointsOfInterest">
		<g:message code="attraction.pointsOfInterest.label" default="Points Of Interest" />
		
	</label>
	<g:select name="pointsOfInterest" from="${tripswebapp.model.PointOfInterest.list()}" multiple="multiple" optionKey="id" size="5" value="${attractionInstance?.pointsOfInterest*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'images', 'error')} ">
	<label for="images">
		<g:message code="attraction.images.label" default="Images" />

	</label>
	<g:select name="images" id="images" from="${tripswebapp.media.Image.list()}" multiple="multiple" optionKey="id" size="5" value="${attractionInstance?.images*.id}" class="many-to-many "/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'videos', 'error')} ">
	<label for="videos">
		<g:message code="attraction.videos.label" default="Videos" />
		
	</label>
	<g:select name="videos" from="${tripswebapp.media.Video.list()}" multiple="multiple" optionKey="id" size="5" value="${attractionInstance?.videos*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'audioGuide', 'error')}">
	<label for="audioGuide">
		<g:message code="attraction.audioGuide.label" default="Audio Guide" />
	</label>
	<g:select id="audioGuide" name="audioGuide.id" from="${tripswebapp.media.AudioGuide.list()}" optionKey="id" value="${attractionInstance?.audioGuide?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'classification', 'error')} required">
	<label for="classification">
		<g:message code="attraction.classification.label" default="Classification" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="classification" name="classification.id" from="${tripswebapp.utils.Classification.list()}" optionKey="id"  value="${attractionInstance?.classification?.id}" class="many-to-one"/>

</div>
%{--

<script type="application/javascript">
    $().ready(function(){
        $("#images").chosen({no_results_text: "No se encontraron resultados!"});
    });
</script>--}%


<script type="application/javascript">
    $(".chosen-select ").chosen({no_results_text: "No se encontraron resultados!"});
</script>
