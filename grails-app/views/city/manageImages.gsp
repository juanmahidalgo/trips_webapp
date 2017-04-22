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
    <g:set var="entityName" value="${message(code: 'city.label', default: 'City')}" />
    <title> Editando imágnes</title></head>
<body>
    <div class="mainContainer">
        <ol class="breadcrumb">
            <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            <li><g:link class="list" action="index"> Lista de Ciudades </g:link></li>
            <li class="active"> Edición de imágenes</li>
        </ol>

        <h1> Editando imágenes de ${cityInstance?.name}</h1>

        <g:form url="[resource:cityInstance, action:'uploadImage']" enctype='multipart/form-data' >

            <fieldset class="buttons addNewImage">
                <h2 class="addNewTitle"> Cargar imágen (max 10mb): </h2>
                <input type='file' name='documentFile' />
                <g:submitButton name="create" class="save btn btn-success" value="Cargar" />
            </fieldset>

            <div class="fieldcontain maps">
                <h2> Imágenes cargadas: </h2>
                <g:if test="${cityInstance?.image}">
                    <label> Imagen </label>
                    <g:if test="image">
                        <img src="${resource(dir: 'images/cities', file: cityInstance?.image.path)}" alt="image"/>
                        <g:link params="[id: cityInstance?.id, imgId: cityInstance?.image.id]" action="deleteImage" class="btn btn-danger"> Borrar </g:link>
                    </g:if>
                </g:if>
                <g:else>
                    <b> No hay imágenes todavía.. </b>
                </g:else>
            </div>
        </g:form>
    </div>

</body>
</html>