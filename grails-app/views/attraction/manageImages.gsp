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

    <ol class="breadcrumb">
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
        <li class="active"> Edit Images</li>
    </ol>

    <h1><g:message code="default.manageImages.label" args="[entityName]" /></h1>

    <g:form url="[resource:attractionInstance, action:'uploadImage']" enctype='multipart/form-data' >
        <g:hiddenField name="typeOfFile" value="map"/>
        <div class="fieldcontain maps">
            <label> Maps: </label>
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
        </div>
        <fieldset class="buttons">
            <label> Add new </label>
            <input type='file' name='documentFile' />
            <g:submitButton name="create" class="save btn btn-success" value="Add Map" />
        </fieldset>

    </g:form>



</body>
</html>