<%@ page import="tripswebapp.model.Attraction" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainLayout">
		<g:set var="entityName" value="${message(code: 'attraction.label', default: 'Attraction')}" />
		<title> Editar Atracción </title>
		<script>
            function geolocate() {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(function(position) {
                        var geolocation = {
                            lat: position.coords.latitude,
                            lng: position.coords.longitude
                        };
                        var circle = new google.maps.Circle({
                            center: geolocation,
                            radius: position.coords.accuracy
                        });
                        autocomplete.setBounds(circle.getBounds());
                    });
                }
            }
		</script>
	</head>
	<body>
		<ol class="breadcrumb">
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="list" action="list"> Lista de Atracciones </g:link></li>
			<li class="active"> Editar Atracción </li>
		</ol>
		<div id="edit-attraction" class="content scaffold-edit col-md-6" role="main">
			<h1> Editar Atracción </h1>
			<g:if test="${flash.message}">
			<div class="message alert alert-info" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${attractionInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${attractionInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<div id="searchBarContainer">
				<label for="autocomplete">Buscador </label>
				<input id="autocomplete" placeholder=" Ingrese una atracción o ciudad.. "
					   onFocus="geolocate()" type="text"></input>
			</div>
			<g:form url="[resource:attractionInstance, action:'update']" method="PUT">
				<g:hiddenField name="version" value="${attractionInstance?.version}" />
				<fieldset class="form" >
					<g:render template="form" model="[context: 'edit']"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save btn btn-success" action="update" value="Actualizar" />
				</fieldset>
			</g:form>
		</div>
	<div class="mapContainer col-md-6">
		<div id="map"></div>
		<label> Puntos de interés </label>
		<div class="routes col-md-10">
			<g:each in="${attractionInstance.pointsOfInterest}" status="i" var="point">
				<div class="attractionsContainer" id="point-${point.id}">
					<g:if test="${point.image}">
                        <img src="${resource(dir: 'images/pointsofinterest', file: point.image.path)}" alt="image"/>
                    </g:if>
                    <g:else>
                        <img src="${resource(dir: 'images', file: 'noimage.png')}" alt="image"/>
                    </g:else>
					<g:link controller="pointOfInterest" action="edit" id="${point.id}">${point.name}</g:link>
					<a id="${point.id}" class="btn btn-danger btn-delete-point" data-href="/TripsWebApp/pointOfInterest/deletePoint?id=${point.id}" data-toggle="modal" data-target="#confirm-delete-point"> Borrar </a>
				</div>
			</g:each>
			<g:if test="${attractionInstance.pointsOfInterest.size() == 0}">
				<label> No hay puntos de interés para esta atracción</label>
			</g:if>
		</div>
		<div class="botones footer">
			<a class="btn btn-success" data-href="/TripsWebApp/pointOfInterest/save?id=${attractionInstance.id}" data-toggle="modal" data-target="#confirm-delete"> Agregar Punto de Interés </a>
		</div>
	</div>
	<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<g:form id="pointForm" url="[action:'save',controller:'pointOfInterest']" method="post" enctype='multipart/form-data' >
					<div class="modal-header">
						Creando punto de interés
					</div>
					<div class="modal-body">
						<fieldset class="form">
							<div class="fieldcontain inputField ">
								<label for="name">
									<g:message code="pointOfInterest.name.label" default="Name" />
								</label>
								<g:textField name="name" value="${pointOfInterestInstance?.name}"/>
							</div>
							<input type="hidden" name="attractionId" value="${attractionInstance.id}">
							<div class="fieldcontain inputField ">
								<label for="description">
									<g:message code="pointOfInterest.description.label" default="Description" />

								</label>
								<g:textField name="description" value="${pointOfInterestInstance?.description}"/>
							</div>
							<div class="fieldcontain required">
								<label for="audioGuide">
									<g:message code="pointOfInterest.audioGuide.label" default="Audio Guide" />
									<span class="required-indicator">*</span>
								</label>
								<input type="file" name="audioGuideFile">
							</div>
							<div class="fieldcontain required">
								<label for="image">
									<g:message code="pointOfInterest.image.label" default="Image" />
									<span class="required-indicator">*</span>
								</label>
								<input type="file" name="imageFile">
							</div>
						</fieldset>
					</div>
					<div class="modal-footer">
						<g:submitButton name="create" class="btn btn-success btn-ok" value="${message(code: 'default.button.create.label', default: 'Crear ')}" />
						<button type="button" class="btn btn-default" data-dismiss="modal"> Cancelar </button>
					</div>
				</g:form>
			</div>
		</div>
	</div>
	<div class="modal fade" id="confirm-delete-point" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					Borrar Punto
				</div>
				<div class="modal-body">
					¿ Está seguro que desea eliminar el punto de interés ?
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"> Cancelar </button>
					<a class="btn btn-danger btn-ok btn-ok-point"> Eliminar </a>
				</div>
			</div>
		</div>
	</div>

	<script>
		$('#confirm-delete-point').on('show.bs.modal', function(e) {
			$(this).find('.btn-ok-point').attr('href', $(e.relatedTarget).data('href'));
		});
		$('.btn-delete-point').click(function(){
		    var point = this.id;
            $.ajax({
                type: 'POST',
                url: '/TripsWebApp/pointOfInterest/deletePoint',
                data: {id: point},
                success: function() {
                    $('#point-'+point).remove();
                    $('#confirm-delete-point').modal('hide');
                },
            });
            return false;
        });
		$(function() {
			$('#pointForm').submit(function() {
				var formData = new FormData($(this)[0]);
				$.ajax({
					type: 'POST',
					url: '/TripsWebApp/pointOfInterest/savePoint',
					data: formData,
					processData: false,
					contentType: false,
					success: function(json) {
						var html = '<div class="attractionsContainer"> '
								+ '<img src="/TripsWebApp/images/pointsofinterest/' + json.image.path + '" alt="image"/>'
							+ '<a href="/TripsWebApp/pointsofinterest/"'+ json.id + '>' + json.name + '</a>'
							+ '<a class="btn btn-danger" data-href="/TripsWebApp/pointOfInterest/deletePoint?id=' + json.id +'" data-toggle="modal" data-target="#confirm-delete-point"> Borrar </a> '+
								' </div>';
						$('.routes').append(html);
						$('#confirm-delete').modal('hide');
					},
				});
				return false;
			});
		})
		function completeForm(places){
			$('#name').val(places.name);
			var locationInfo = places.address_components;
			locationInfo.forEach(function(item) {
				if(item['types'].indexOf("country") > 0){
					$('#country').val(item['long_name']);
				}
				if(item['types'].indexOf("locality") >= 0){
					$('#city').val(item['long_name']);
				}
			});
			$('#address').val(places.formatted_address);
			$('#telephone').val(places.formatted_phone_number);
			$('#latitude').val(places.geometry.location.lat());
			$('#longitude').val(places.geometry.location.lng());
			/*places.photos.forEach(function(photo){
			 var html = '<img src="' + photo.getUrl({'maxWidth': 250, 'maxHeight': 250}) + '">';
			 $('.imagesContainer').append(html);
			 });*/
		}
		var initialPosition = {lat: ${attractionInstance.latitude}, lng: ${attractionInstance.longitude}};
		var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		var labelIndex = 0;
		function initAutocomplete() {
			var map = new google.maps.Map(document.getElementById('map'), {
				center: initialPosition ,
				zoom: 16,
				mapTypeId: google.maps.MapTypeId.ROADMAP
			});

			var marker = new google.maps.Marker({
				position: initialPosition,
				map: map
			});

			// Create the search box and link it to the UI element.
			var input = document.getElementById('autocomplete');
			var searchBox = new google.maps.places.SearchBox(input);

			// Bias the SearchBox results towards current map's viewport.
			map.addListener('bounds_changed', function() {
				searchBox.setBounds(map.getBounds());
			});

			var markers = [];

			google.maps.event.addListener(map, 'click', function(event) {
				addMarker(event.latLng, map);
			});

			// Listen for the event fired when the user selects a prediction and retrieve
			// more details for that place.
			searchBox.addListener('places_changed', function() {
				var places = searchBox.getPlaces();
				completeForm(places[0]);

				if (places.length == 0) {
					return;
				}

				// Clear out the old markers.
				markers.forEach(function(marker) {
					marker.setMap(null);
				});
				markers = [];

				// For each place, get the icon, name and location.
				var bounds = new google.maps.LatLngBounds();
				places.forEach(function(place) {
					var icon = {
						url: place.icon,
						size: new google.maps.Size(71, 71),
						origin: new google.maps.Point(0, 0),
						anchor: new google.maps.Point(17, 34),
						scaledSize: new google.maps.Size(25, 25)
					};

					// Create a marker for each place.
					markers.push(new google.maps.Marker({
						map: map,
						icon: icon,
						title: place.name,
						position: place.geometry.location
					}));

					if (place.geometry.viewport) {
						// Only geocodes have viewport.
						bounds.union(place.geometry.viewport);
					} else {
						bounds.extend(place.geometry.location);
					}
				});
				map.fitBounds(bounds);
			});

			function cleanFields(){
				$('#name').val('');
				$('#country').val('');
				$('#city').val('');
				$('#address').val('');
				$('#telephone').val('');
			}

			function getInfoAndFill(location){
				var latdegrees=location.lat();
				var londegrees=location.lng();
				var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + latdegrees + "," + londegrees + "&key=AIzaSyB2HKAXBafJpycygBDLiS_tDyP86h6MTUk";
				$.getJSON(url,function (data, textStatus) {
					var locationInfo = data.results[0].address_components;
					locationInfo.forEach(function(item) {
						if(item['types'].indexOf("country") >= 0){
							$('#country').val(item['long_name']);
						}
						if(item['types'].indexOf("locality") >= 0){
							$('#city').val(item['long_name']);
						}
					});
				});
			}

			function setMapOnAll(map) {
				for (var i = 0; i < markers.length; i++) {
					markers[i].setMap(map);
				}
			}

			// Removes the markers from the map, but keeps them in the array.
			function clearMarkers() {
				setMapOnAll(null);
			}

			function addMarker(location, map) {
				// Add the marker at the clicked location, and add the next-available label
				// from the array of alphabetical characters.
				clearMarkers();
				var marker = new google.maps.Marker({
					position: location,
					map: map
				});
				cleanFields();
				$('#latitude').val(location.lat());
				$('#longitude').val(location.lng());
				getInfoAndFill(location);
				markers.push(marker);
			}
		}
	</script>
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB2HKAXBafJpycygBDLiS_tDyP86h6MTUk&libraries=places&callback=initAutocomplete" async defer></script>
	</body>
</html>
