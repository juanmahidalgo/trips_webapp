<%@ page import="tripswebapp.model.Advertisment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainLayout">
		<g:set var="entityName" value="${message(code: 'advertisment.label', default: 'Advertisment')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
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
			<li><g:link class="list" action="list"> Lista de Publicidades</g:link></li>
			<li class="active">Editar publicidad</li>
		</ol>
		<div id="edit-advertisment" class="content scaffold-edit col-md-5" role="main">
			<h1> Editando Publicidad </h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${advertismentInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${advertismentInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<div id="searchBarContainer">
				<label for="autocomplete">Buscador </label>
				<input id="autocomplete" placeholder=" Ingrese una atracción o ciudad.. "
					   onFocus="geolocate()" type="text"></input>
			</div>
			<g:form url="[resource:advertismentInstance, action:'update']" method="POST" >
				<g:hiddenField name="version" value="${advertismentInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save btn btn-info" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>
		<div class="mapContainer col-md-6">
			<div id="map"></div>
		</div>
	<script>
        function completeForm(places){
            var locationInfo = places.address_components;
            locationInfo.forEach(function(item) {
                if(item['types'].indexOf("locality") >= 0){
                    $('#city').val(item['long_name']);
                }
            });
            $('#latitude').val(places.geometry.location.lat());
            $('#longitude').val(places.geometry.location.lng());

        }
        var initialPosition = {lat: ${advertismentInstance.latitude}, lng: ${advertismentInstance.longitude}};
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

            }

            function getInfoAndFill(location){
                var latdegrees=location.lat();
                var londegrees=location.lng();
                var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + latdegrees + "," + londegrees + "&key=AIzaSyB2HKAXBafJpycygBDLiS_tDyP86h6MTUk";
                $.getJSON(url,function (data, textStatus) {
                    var locationInfo = data.results[0].address_components;
                    locationInfo.forEach(function(item) {
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
