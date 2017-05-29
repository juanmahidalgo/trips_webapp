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
            <li><g:link class="list" action="index"> Lista de Atracciones </g:link></li>
            <li class="active"> Editar Imagenes</li>
        </ol>

%{--
        <h1><g:message code="default.manageImages.label" args="[entityName]" /></h1>
--}%

        <g:if test="${params.type == 'image'}" >
            <h1> Editando imagenes de ${attractionInstance?.name}</h1>
        </g:if>
        <g:elseif test="${params.type == 'map'}">
            <h1> Editando Mapas from ${attractionInstance?.name} </h1>
        </g:elseif>
        <g:elseif test="${params.type == 'video'}">
            <h1> Editando Video from ${attractionInstance?.name} </h1>
        </g:elseif>
        <g:form url="[resource:attractionInstance, action:'uploadImage']" enctype='multipart/form-data' >

            <fieldset class="buttons addNewImage">
                <h2 class="addNewTitle">
                    <g:if test="${params.type == 'image'}" >
                        Cargar Imagen (max 10mb):
                    </g:if>
                    <g:if test="${params.type == 'map'}" >
                        Cargar Mapa (max 10mb):
                    </g:if>
                    <g:if test="${params.type == 'video'}" >
                        Cargar Video (max 20mb):
                    </g:if>
                </h2>
                <input type='file' name='documentFile' />
                <g:submitButton name="create" class="save btn btn-success" value="Cargar" />
            </fieldset>

            <g:hiddenField name="typeOfFile" value="${params.type}"/>
            <div class="fieldcontain maps">
                <g:if test="${params.type == 'image'}">
                    <h2> Imágenes cargadas: </h2>
                    <g:if test="${attractionInstance?.images}">
                        <g:each var="image" in="${attractionInstance?.images}" status="i">
                            <label> Imagen ${i+1} </label>
                            <g:if test="image">
                                <img src="${resource(dir: 'images/attractions', file: image.path)}" alt="image"/>
                                <g:link params="[id: attractionInstance?.id, imgId: image.id]" action="deleteImage" class="btn btn-danger"> Borrar </g:link>
                            </g:if>
                        </g:each>
                    </g:if>
                    <g:else>
                        <b> No hay imágenes todavía.. </b>
                    </g:else>
                </g:if>
                <g:elseif test="${params.type == 'map'}">
                    <h2> Mapas cargados: </h2>
                    <g:if test="${attractionInstance?.maps}">
                        <g:each var="map" in="${attractionInstance?.maps}" status="i">
                            <label> Map ${i+1} </label>
                            <g:if test="map">
                                <img src="${resource(dir: 'images/maps', file: map.path)}" alt="mapa"/>
                                <g:link params="[id: attractionInstance?.id, imgId: map.id]" action="deleteImage" class="btn btn-danger"> Delete Map</g:link>
                            </g:if>
                        </g:each>
                    </g:if>
                    <g:else>
                        <b> No hay mapas cargados todavía.. </b>
                    </g:else>
                </g:elseif>
                <g:elseif test="${params.type == 'video'}">
                    <h2> Video cargado: </h2>
                    <g:if test="${attractionInstance?.videos}">
                        <g:each var="video" in="${attractionInstance?.videos}" status="i">
                            <label> Video ${i+1} </label>
                            <g:if test="video">
                                <span> ${video.path}</span>
                                <g:link params="[id: attractionInstance?.id, videoId: video.id]" action="deleteImage" class="btn btn-danger"> Borrar Video </g:link>
                            </g:if>
                        </g:each>
                    </g:if>
                    <g:else>
                        <b> No hay video cargado todavía.. </b>
                    </g:else>
                </g:elseif>
            </div>
        </g:form>
    </div>

</body>
</html>