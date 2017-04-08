<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainLayout">
		<g:set var="entityName" value="${message(code: 'attraction.label', default: 'Attraction')}" />
		<title>  Crear Atracción </title>
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
			<li><g:link class="list" action="index"> Lista de Atracciones </g:link></li>
			<li class="active">Crear Atracción</li>
		</ol>
		<div id="create-attraction" class="content scaffold-create col-md-5" role="main">
			<h1> Crear Atracción </h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
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
			<g:form action="save" enctype='multipart/form-data' >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save btn btn-success" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
        <div class="mapContainer col-md-6">
            <div id="map"></div>
        </div>

    <script>
        function completeForm(places){
            $('#name').val(places.name);
            var locationInfo = places.address_components;
            locationInfo.forEach(function(item) {
                if(item['types'].indexOf("country") > 0){
                    $('#country').val(item['long_name']);
                }
                if(item['types'].indexOf("locality") > 0){
                    $('#city').val(item['long_name']);
                }
            });
            $('#address').val(places.formatted_address);
            $('#telephone').val(places.formatted_phone_number);
            $('#latitude').val(places.geometry.location.lat());
            $('#longitude').val(places.geometry.location.lng());

        }

        var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        var labelIndex = 0;
        function initAutocomplete() {
            var map = new google.maps.Map(document.getElementById('map'), {
                center: {lat: -33.8688, lng: 151.2195},
                zoom: 13,
                mapTypeId: google.maps.MapTypeId.ROADMAP
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

            function addMarker(location, map) {
                // Add the marker at the clicked location, and add the next-available label
                // from the array of alphabetical characters.
                var marker = new google.maps.Marker({
                    position: location,
                    label: labels[labelIndex++ % labels.length],
                    map: map
                });
                cleanFields();
                $('#latitude').val(location.lat());
                $('#longitude').val(location.lng());
                getInfoAndFill(location);
            }
        }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB2HKAXBafJpycygBDLiS_tDyP86h6MTUk&libraries=places&callback=initAutocomplete" async defer></script>

    </body>
</html>
