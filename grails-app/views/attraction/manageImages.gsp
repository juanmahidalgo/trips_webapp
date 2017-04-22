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
        <g:else>
            <h1> Editando Mapas from ${attractionInstance?.name} </h1>
        </g:else>
        <g:form url="[resource:attractionInstance, action:'uploadImage']" enctype='multipart/form-data' >

            <fieldset class="buttons addNewImage">
                <h2 class="addNewTitle"> Cargar Imagen (max 10mb): </h2>
                <input type='file' name='documentFile' />
                <g:submitButton name="create" class="save btn btn-success" value="Cargar" />
            </fieldset>

            <g:hiddenField name="typeOfFile" value="${params.type == 'image' ? 'image' : 'map'}"/>
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
                <g:else>
                    <h2> Loaded Maps: </h2>
                    <g:if test="${attractionInstance?.maps}">
                        <g:each var="map" in="${attractionInstance?.maps}" status="i">
                            <label> Map ${i+1} </label>
                            <g:if test="map">
                                <img src="${resource(dir: 'images/maps', file: map.path)}" alt="mapa"/>
                                <g:link params="[id: attractionInstance?.id, imgId: map.id]" action="deleteImage" class="btn btn-danger"> Delete Map</g:link>
                            </g:if>
                        </g:each>

                    %{-- <g:each var="i" in="${ (0..<3) }">
                         <label> Map ${i+1} </label>
                         <g:if test="${attractionInstance?.maps[i]}">
                             <img src="${resource(dir: 'images/maps', file: attractionInstance?.maps[i].path)}" alt="mapa"/>
                             <input type='file' name='documentFile.${i+1}' value="${attractionInstance?.maps[i]}" />
                         </g:if>
                     <g:else>
                         <input type='file' name='documentFile.${i+1}' />
                     </g:else>
                     </g:each>--}%
                    </g:if>
                    <g:else>
                        <b> No maps loaded yet.. </b>
                    </g:else>
                </g:else>
            </div>
        </g:form>
    </div>

</body>
</html>