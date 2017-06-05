<%@ page import="tripswebapp.model.Route" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainLayout">
		<g:set var="entityName" value="${message(code: 'route.label', default: 'Route')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<ol class="breadcrumb">
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="" action="list"> Lista de Recorridos </g:link></li>
			<li class="active">Editar Recorrido </li>
		</ol>
		<div id="edit-route" class="content scaffold-edit col-md-5" role="main">
			<h1> Editando Recorrido </h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${routeInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${routeInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:routeInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${routeInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save btn btn-info" action="update" value="Actualizar" />
				</fieldset>
			</g:form>
		</div>
	<div class="mapContainer col-md-6">
		<div id="map"></div>
		<div id="warnings-panel" style="display:none;"></div>
	</div>
	<script>
        var attractions = {};
        var markerArray = [];
        var order = "${routeInstance.stopsOrder?.join(',') ?: []}";
        order = order.split(',');
        var map;
        var directionsService, directionsDisplay, stepDisplay;
        var initialPosition = {lat: ${routeInstance.city?.latitude}, lng: ${routeInstance.city?.longitude}};
        function getCity(){
            $.ajax({
                url: '/TripsWebApp/cities/'+$('#city').val()+'.json',
                success: function(json) {
                    console.log(json);
                    map.setCenter({lat: json.latitude, lng: json.longitude});
                },
                type: 'GET'
            });
        }
        function loadAttractions(refreshData){
            var city = getCity($('#city').val());
            $.ajax({
                url: '/TripsWebApp/city/getAtrractions',
                data: {
                    id: $('#city').val()
                },
                success: function(json) {
                    if(refreshData){
                    	$('#stops').html('').trigger("chosen:updated");
					}
                    json.forEach(function(item){
                        //addMarkerWithBounce({lat:item.latitude, lng: item.longitude});
                        attractions[item.id] = item;
                        if(refreshData){
							var obj = $('<option>').text(item.name).attr('value', item.id).attr('id',item.id);
							$('#stops').append(obj);
							$('#stops').trigger("chosen:updated");
						}
                    });
                    drawRoute();

                },
                type: 'GET'
            });
        }

        function initAutocomplete() {
            directionsService = new google.maps.DirectionsService;
            map = new google.maps.Map(document.getElementById('map'), {
                center: initialPosition,
                zoom: 13,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            });
            directionsDisplay = new google.maps.DirectionsRenderer({map: map});
            stepDisplay = new google.maps.InfoWindow;
            loadAttractions(false);
        }

        function addStop(item) {
            marker = new google.maps.Marker({
                map: map,
                draggable: true,
                animation: google.maps.Animation.DROP,
                position: {lat: item.latitude, lng: item.longitude}
            });
            marker.addListener('click', toggleBounce);
            markerArray.push(marker);

        }

        function toggleBounce() {
            if (marker.getAnimation() !== null) {
                marker.setAnimation(null);
            } else {
                marker.setAnimation(google.maps.Animation.BOUNCE);
            }
        }

        function cleanMap(){
            for (var i = 0; i < markerArray.length; i++) {
                markerArray[i].setMap(null);
            }
        }

        function drawRoute(){
            cleanMap();
            // triggers when whole value changed
            markerArray = [];
            var stops = $('#stops').getSelectionOrder();
            if(stops){
                stops.forEach(function(stop){
                    addStop(attractions[stop])
                });
            }
            if(markerArray.length > 1){
                calculateAndDisplayRoute(directionsDisplay, directionsService, markerArray, stepDisplay,map);
            }
            else if(markerArray.length == 1 && directionsDisplay){
                //directionsDisplay.setMap(null);
                //directionsDisplay = null;
            }
		}

        $('#stops').chosen().change(function(evt, params) {
            cleanMap();
            // triggers when whole value changed
            markerArray = [];
            var stops = $('#stops').getSelectionOrder();
            if(params.deselected && stops.indexOf(params.deselected) > -1){
                stops.splice(stops.indexOf(params.deselected), 1);
            }
            if(stops){
                stops.forEach(function(stop){
                    addStop(attractions[stop])
                });
            }
            if(markerArray.length > 1){
                calculateAndDisplayRoute(directionsDisplay, directionsService, markerArray, stepDisplay,map);
            }
            else if(markerArray.length == 1 && directionsDisplay){
                //directionsDisplay.setMap(null);
                //directionsDisplay = null;
            }        });

        function calculateAndDisplayRoute(directionsDisplay, directionsService,
                                          markerArray, stepDisplay, map) {
            // First, remove any existing markers from the map.
            cleanMap();
            if(markerArray.length > 2){
                var waypts = [];
                for (var i = 1; i < markerArray.length-1; i++) {
                    waypts.push({
                        location: markerArray[i].position,
                        stopover: true
                    });
                }
            }

            // Retrieve the start and end locations and create a DirectionsRequest using
            // WALKING directions.
            directionsService.route({
                origin: markerArray[0].position,
                destination: markerArray[markerArray.length-1].position,
                waypoints: waypts,
                optimizeWaypoints: true,
                travelMode: 'WALKING'
            }, function(response, status) {
                // Route the directions and pass the response to a function to create
                // markers for each step.
                if (status === 'OK') {
                    document.getElementById('warnings-panel').innerHTML =
                        '<b>' + response.routes[0].warnings + '</b>';
                    directionsDisplay.setDirections(response);
                    //showSteps(response, markerArray, stepDisplay, map);
                } else {
                    window.alert('Directions request failed due to ' + status);
                }
            });
            markerArray = [];
        }

        $('#city').on('change', function(evt) {
            loadAttractions(true);
        });

        $().ready(function(){
            $('#stops').setSelectionOrder(order, true);
        });
	</script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB2HKAXBafJpycygBDLiS_tDyP86h6MTUk&libraries=places&callback=initAutocomplete" async defer></script>

	</body>
</html>
