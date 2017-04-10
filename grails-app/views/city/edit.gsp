<%@ page import="tripswebapp.model.City" %>
<!DOCTYPE html>
<html>
	<head>
		<title> Editar Ciudad </title>
		<meta name="layout" content="mainLayout">
		<g:set var="entityName" value="${message(code: 'city.label', default: 'City')}" />
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB2HKAXBafJpycygBDLiS_tDyP86h6MTUk&libraries=places" async defer></script>


	</head>
	<body>
		<ol class="breadcrumb">
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="" action="index">Lista de Ciudades </g:link></li>
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
						<g:else>
							<img src="${resource(dir: 'images', file: 'noimage.png')}" alt="image"/>
						</g:else>
						<g:link controller="attraction" action="edit" id="${attractionInstance.id}">${fieldValue(bean: attractionInstance, field: "name")}</g:link>
						<a class="btn btn-danger" data-href="/TripsWebApp/attraction/deleteAtracction?id=${attractionInstance.id}" data-toggle="modal" data-target="#confirm-delete"> Borrar </a>
					</div>
				</g:each>
			</div>
			<g:if test="${cityInstance.image}">
				<label> Foto </label>
				<div class="image">
					<img src="${resource(dir: 'images/cities', file: cityInstance.image.path)}" alt="image"/>
				</div>
			</g:if>
			<g:else>
				<label> Todavía no tiene imágen, agregale desde el administrador de imágenes</label>
			</g:else>

			<g:form url="[resource:cityInstance, action:'update']" method="PUT" class="form-group" >
				<g:hiddenField name="version" value="${cityInstance?.version}" />
				%{--<fieldset class="form">
					<g:render template="form" model="[context: 'edit']"/>
				</fieldset>--}%

				%{--<fieldset class="buttons">
					<g:actionSubmit class="save btn btn-success" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>--}%
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
            var attractions = [];
            $.ajax({
                url: '/TripsWebApp/city/getAtrractions',
                data: {
                    id: ${cityInstance.id}
                },
                success: function(json) {
                    json.forEach(function(item){
                        //addMarkerWithBounce({lat:item.latitude, lng: item.longitude});
						attractions.push({lat:item.latitude, lng: item.longitude});
						initAutocomplete();
                    });
                },
                type: 'GET'
            });

			var initialPosition = {lat: ${cityInstance.latitude}, lng: ${cityInstance.longitude}};
			function initAutocomplete() {
				var map = new google.maps.Map(document.getElementById('map'), {
					center: initialPosition ,
					zoom: 14,
					mapTypeId: google.maps.MapTypeId.ROADMAP
				});

				attractions.forEach(function(item){
                    marker = new google.maps.Marker({
                        map: map,
                        draggable: true,
                        animation: google.maps.Animation.DROP,
                        position: {lat: item.lat, lng: item.lng}
                    });
                    marker.addListener('click', toggleBounce);
				});
			}
            function toggleBounce() {
                if (marker.getAnimation() !== null) {
                    marker.setAnimation(null);
                } else {
                    marker.setAnimation(google.maps.Animation.BOUNCE);
                }
            }


            function addMarkerWithBounce(place){
                marker = new google.maps.Marker({
                    map: map,
                    draggable: true,
                    animation: google.maps.Animation.DROP,
                    position: {lat: place.lat, lng: place.lng}
                });
                marker.addListener('click', toggleBounce);
            }




            $('#confirm-delete').on('show.bs.modal', function(e) {
                $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
            });
		</script>
	</body>
</html>
