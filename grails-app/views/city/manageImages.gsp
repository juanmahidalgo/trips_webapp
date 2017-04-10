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
    <title><g:message code="default.manageImages.label" args="[entityName]" /></title></head>
<body>
    <div class="mainContainer">
        <ol class="breadcrumb">
            <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            <li class="active"> Edit Images</li>
        </ol>

        <h1> Editing Images from ${cityInstance?.name}</h1>

        <g:form url="[resource:cityInstance, action:'uploadImage']" enctype='multipart/form-data' >

            <fieldset class="buttons addNewImage">
                <h2 class="addNewTitle"> Add new: </h2>
                <input type='file' name='documentFile' />
                <g:submitButton name="create" class="save btn btn-success" value="Add new" />
            </fieldset>

            <div class="fieldcontain maps">
                <h2> Loaded Images: </h2>
                <g:if test="${cityInstance?.image}">
                    <label> Image </label>
                    <g:if test="image">
                        <img src="${resource(dir: 'images/cities', file: cityInstance?.image.path)}" alt="image"/>
                        <g:link params="[id: cityInstance?.id, imgId: cityInstance?.image.id]" action="deleteImage" class="btn btn-danger"> Delete Image</g:link>
                    </g:if>
                </g:if>
                <g:else>
                    <b> No image loaded yet.. </b>
                </g:else>
            </div>
        </g:form>
    </div>

</body>
</html>