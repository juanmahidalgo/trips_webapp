<%--
  Created by IntelliJ IDEA.
  User: jhidalgo
  Date: 3/26/17
  Time: 7:37 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainLayout">
    <g:set var="entityName" value="${message(code: 'attraction.label', default: 'Attraction')}" />
    <title><g:message code="default.manageImages.label" args="[entityName]" /></title></head>
<body>
<div class="mainContainer">
    <ol class="breadcrumb">
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"> Lista de Atracciones </g:link></li>
        <li class="active"> Agregar Traducción</li>
    </ol>
    <div class="col-md-5">
        <h1> Cargando Traducción para ${attractionInstance?.name} </h1>
        <g:form url="[resource:attractionInstance, action:'saveTraduction']" enctype='multipart/form-data' >
            <fieldset class="form">
                <div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'name', 'error')}">
                    <label for="name">
                        <g:message code="attraction.name.label" default="Nombre" />
                    </label>
                    <g:textField name="name" required="" oninput="setCustomValidity('')" value="${attractionInstance?.name}" readonly="readonly"/>
                </div>
                <div class="${hasErrors(bean: cityInstance, field: 'city', 'error')}">
                    <label for="city">
                        <g:message code="city.city.label" default="Ciudad" />
                    </label>
                    <g:textField name="city" value="${attractionInstance.city?.name}" readonly="readonly"/>
                </div>
                <div class="fieldcontain inputField required">
                    <label for="language">
                        <g:message code="attraction.language.label" default="Idioma" />
                        <span class="required-indicator">*</span>
                    </label>
                    <g:select id="language" name="language.id" from="${tripswebapp.model.Language.list()}" optionKey="id"  class="many-to-one chosen-select"/>
                </div>
                <div class="fieldcontain inputField ${hasErrors(bean: attractionInstance, field: 'description', 'error')} required">
                    <label for="description">
                        <g:message code="attraction.description.label" default="Descripcion" />
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField name="description" required="" oninput="setCustomValidity('')" oninvalid="this.setCustomValidity('Por favor ingrese una descripcón')" value="${attractionInstance?.description}" />
                </div>
                <label for="audioGuideFile"> Subir AudioGuia
                </label>
                <input  type="file" name="audioGuideFile" id="audioGuideFile">
            </fieldset>
            <fieldset class="buttons">
                <g:submitButton name="create" class="save btn btn-success createButton" value="Cargar Traducción" />
            </fieldset>
        </g:form>
    </div>
    <div class="mapContainer col-md-6">
        <div id="map"></div>
    </div>
</div>
<script>
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