<%@ page import="tripswebapp.model.Attraction" %>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="attraction.name.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" oninput="setCustomValidity('')" value="${attractionInstance?.name}" oninvalid="this.setCustomValidity('Por favor ingrese un nombre para la atracción')"/>
</div>

<div class="${hasErrors(bean: cityInstance, field: 'city', 'error')} required">
	<label for="city">
		<g:message code="city.city.label" default="Ciudad" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="city" name="city.id" from="${tripswebapp.model.City.list()}" optionKey="id" style="width: 350px;" required="" value="${attractionInstance.city?.id}" class="many-to-one chosen-select  "/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="attraction.description.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" oninput="setCustomValidity('')" oninvalid="this.setCustomValidity('Por favor ingrese una descripcón')" value="${attractionInstance?.description}" />
</div>


<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'schedule', 'error')}">
	<label for="schedule">
		<g:message code="attraction.schedule.label" default="Horarios" />
	</label>
	<g:textField name="schedule" value="${attractionInstance?.schedule}"/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'averageTime', 'error')} ">
	<label for="averageTime">
		<g:message code="attraction.averageTime.label" default="Tiempo de Visita" />
	</label>
	<g:field name="averageTime" type="number" value="${attractionInstance.averageTime}"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'cost', 'error')}">
	<label for="cost">
		<g:message code="attraction.cost.label" default="Precio (usd)" />
	</label>
	<g:field name="cost" value="${fieldValue(bean: attractionInstance, field: 'cost')}"/>
</div>


<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'telephone', 'error')}">
	<label for="telephone">
		<g:message code="attraction.telephone.label" default="Teléfono" />
	</label>
	<g:field name="telephone" value="${fieldValue(bean: attractionInstance, field: 'telephone')}"/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'address', 'error')} required">
	<label for="address">
		<g:message code="attraction.telephone.label" default="Dirección" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="address" value="${fieldValue(bean: attractionInstance, field: 'address')}" required=""/>
</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="attraction.latitude.label" default="Latitud" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="latitude" value="${attractionInstance.latitude}" required=""/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="attraction.longitude.label" default="Longitud" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="longitude" value="${attractionInstance.longitude}" required=""/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'classification', 'error')} required">
	<label for="classification">
		<g:message code="attraction.classification.label" default="Clasificación" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="classification" name="classification.id" from="${tripswebapp.utils.Classification.list()}" optionKey="id"  value="${attractionInstance?.classification?.id}" class="many-to-one chosen-select"/>

</div>

<div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'hasPoints', 'error')} required">
	<label for="hasPoints">
		<g:message code="attraction.hasPoints.label" default="Recorrible" />
	<span class="required-indicator">*</span>
	</label>
	<g:checkBox name="hasPoints" value="${attractionInstance.hasPoints}"/>

</div>

<g:if test="${context != 'create'}">
	<div class="">
		<label for="traductions">
			<g:message code="attraction.traductions.label" default="Idiomas" />
		</label>
		<g:each var="traduction" in="${attractionInstance?.traductions}" status="i">
			<g:link params="[id: attractionInstance?.id, traductionId: traduction.id]" action="loadTraduction" class=""> ${traduction} </g:link>
		</g:each>
		%{--
            <span id="traductions"> ${attractionInstance?.traductions ?: 'Ninguna traducción cargada todavía'}</span>
        --}%
		<g:link params="[id: attractionInstance?.id]" action="loadTraduction" class="btn btn-info"> Cargar Traducción </g:link>
	</div>
</g:if>

<g:if test="${context == 'create'}">
	<div class="fieldcontain">
		<label> Cargar Mapa (max 10mb) </label>
	</div>
	<input type="file" name="mapFile">
</g:if>
<g:else>
	<div class="fieldcontain maps">
		<label> Mapas: </label>
		<g:if test="${attractionInstance?.maps}">
			<g:each var="map" in="${attractionInstance?.maps}" status="i">
				<label> Mapa ${i+1} </label>
				<g:if test="map">
					<img src="${resource(dir: 'images/maps', file: map.path)}" alt="image"/>
					<g:link params="[id: attractionInstance?.id, imgId: map.id]" action="deleteImage" id="btnEditImages" class="btn btn-danger invisible"> Delete Image</g:link>

				</g:if>
			</g:each>
		</g:if>
		<g:link params="[id: attractionInstance?.id, type: 'map']" action="manageImages" class="btn btn-primary manageImages"> Administrar Mapas </g:link>
	</div>
</g:else>

<g:if test="${context == 'create'}">
	<div class="fieldcontain">
		<label> Cargar Video (max 20mb)</label>
	<input  type="file" name="videoFile">
</div>
</g:if>
<g:else>
	<div class="fieldcontain">
		<div> <label> Videos: </label></div>
        <g:if test="${attractionInstance?.videos}">
            <g:each var="video" in="${attractionInstance?.videos}" status="i">
                <label> Video ${i+1} </label>
                <g:if test="video">
                    <video width="480" height="320" controls>
                        <source src="${resource(dir: 'videos/', file: video.path)}" type="video/mp4">
                    </video>
                </g:if>
            </g:each>
        </g:if>
		<g:link params="[id: attractionInstance?.id, type: 'video']" action="manageImages" class="btn btn-primary manageImages"> Administrar Videos </g:link>
	</div>
</g:else>


<g:if test="${context == 'create'}">
	<div class="fieldcontain">
		<label> Cargar Imagen (max 10mb)</label>
	</div>
	<input  type="file" name="imageFile">
</g:if>
<g:else>
	<div class="fieldcontain">
		<div><label> Imágenes: </label></div>
		<g:if test="${attractionInstance?.images}">
			<g:each var="image" in="${attractionInstance?.images}" status="i">
				<label> Imagen ${i+1} </label>
				<g:if test="image">
					<img src="${resource(dir: 'images/attractions', file: image.path)}" alt="image"/>
					<g:link params="[id: attractionInstance?.id, imgId: image.id]" action="deleteImage" id="btnEditImages" class="btn btn-danger invisible"> Delete Image</g:link>
				</g:if>
			</g:each>
		</g:if>
		<g:else>
			<span> No hay imágenes cargadas todavía </span>
		</g:else>
		<g:link params="[id: attractionInstance?.id, type: 'image']" action="manageImages" class="btn btn-primary manageImages"> Administrar Imágenes </g:link>
	</div>
</g:else>


%{--

<script type="application/javascript">
    $().ready(function(){
        $("#images").chosen({no_results_text: "No se encontraron resultados!"});
    });
</script>--}%

<script type="application/javascript">
    $(".chosen-select ").chosen({no_results_text: "No se encontraron resultados!"});
</script>
