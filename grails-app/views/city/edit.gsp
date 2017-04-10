<%@ page import="tripswebapp.model.City" %>
<!DOCTYPE html>
<html>
	<head>
		<title> Editar Ciudad </title>
		<meta name="layout" content="mainLayout">
		<g:set var="entityName" value="${message(code: 'city.label', default: 'City')}" />

	</head>
	<body>
		<ol class="breadcrumb">
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="create" action="create">Crear Ciudad </g:link></li>
			<li class="active">Editar Ciudad </li>
		</ol>
		<div id="edit-city" class="content scaffold-edit col-md-5" role="main">
			<h1> Editar Ciudad </h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${cityInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${cityInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<label> Atracciones </label>
			<div class="attractions">
				<g:each in="${cityInstance.attractions}" status="i" var="attractionInstance">
					<div class="attractionsContainer">
						<g:if test="${attractionInstance.images}">
							<img src="${resource(dir: 'images/attractions', file: attractionInstance.images[0].path)}" alt="image"/>
						</g:if>
						<g:link controller="attraction" action="edit" id="${attractionInstance.id}">${fieldValue(bean: attractionInstance, field: "name")}</g:link>
						<a class="btn btn-danger" data-href="/TripsWebApp/attraction/deleteAtracction?id=${attractionInstance.id}" data-toggle="modal" data-target="#confirm-delete"> Borrar </a>
					</div>
				</g:each>
			</div>

			<g:form url="[resource:cityInstance, action:'update']" method="PUT" class="form-group" >
				<g:hiddenField name="version" value="${cityInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>

				<fieldset class="buttons">
					<g:actionSubmit class="save btn btn-success" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
			<g:link params="[id: cityInstance?.id, type: 'image']" action="manageImages" class="btn btn-primary"> Administrar Imágenes </g:link>
		</div>
		<div class="mapContainer col-md-6">
			<div id="map"></div>
		</div>
		<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						Borrar Atracción
					</div>
					<div class="modal-body">
						¿ Está seguro que desea eliminar la atracción ?
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
						<a class="btn btn-danger btn-ok">Delete</a>
					</div>
				</div>
			</div>
		</div>
		<script>
			var initialPosition = {lat: ${cityInstance.latitude}, lng: ${cityInstance.longitude}};
			function initAutocomplete() {
				var map = new google.maps.Map(document.getElementById('map'), {
					center: initialPosition ,
					zoom: 12,
					mapTypeId: google.maps.MapTypeId.ROADMAP
				});

				var marker = new google.maps.Marker({
					position: initialPosition,
					map: map
				});

			}
            $('#confirm-delete').on('show.bs.modal', function(e) {
                $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
            });
		</script>
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB2HKAXBafJpycygBDLiS_tDyP86h6MTUk&libraries=places&callback=initAutocomplete" async defer></script>
	</body>
</html>
