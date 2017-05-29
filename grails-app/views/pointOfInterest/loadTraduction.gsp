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
        <li><g:link class="list" action="edit" id="${pointOfInterestInstance?.id}"> ${pointOfInterestInstance.name} </g:link></li>
        <li class="active"> Agregar Traducción</li>
    </ol>
    <div class="col-md-10">
        <g:if test="${traductionInstance}">
            <h1> Editando Traducción en ${traductionInstance.lang} para ${pointOfInterestInstance?.name}  </h1>
        </g:if>
        <g:else>
            <h1> Creando Traducción para ${pointOfInterestInstance?.name} </h1>
        </g:else>
        <g:form url="[resource:pointOfInterestInstance, action:'saveTraduction']" enctype='multipart/form-data' >
            <fieldset class="form">
                <div class="fieldcontain inputField">
                    <label for="name">
                        <g:message code="pointOfInteres.name.label" default="Nombre" />
                    </label>
                    <g:textField name="name" required="" oninput="setCustomValidity('')" value="${pointOfInterestInstance?.name}" readonly="readonly"/>
                </div>
                <div class="fieldcontain inputField required">
                    <label for="language">
                        <g:message code="pointOfInterest.language.label" default="Idioma" />
                        <span class="required-indicator">*</span>
                    </label>
                    <g:if test="${!traductionInstance}">
                        <g:select id="language" name="language.id" value="${traductionInstance?.lang?.id}" from="${tripswebapp.model.Language.list()}" optionKey="id"  class="many-to-one chosen-select"/>
                    </g:if>
                    <g:else>
                        <g:textField name="language" value="${traductionInstance?.lang}" readonly="readonly"/>

                    </g:else>
                    <input type="hidden" name="traduction_id" value="${traductionInstance?.id}" />
                    <input type="hidden" name="lang_id" value="${traductionInstance?.lang?.id}" />

                </div>
                <div class="fieldcontain inputField required">
                    <label for="description">
                        <g:message code="attraction.description.label" default="Descripción" />
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField name="descripcion" required="" oninput="setCustomValidity('')" oninvalid="this.setCustomValidity('Por favor ingrese una descripcón')" value="${traductionInstance ? traductionInstance.description : pointOfInterestInstance?.description}" />
                </div>
                <g:if test="${traductionInstance?.audioGuide}">
                        <label for="audioGuideFile"> Audioguia cargada:
                        </label>
                        ${traductionInstance.audioGuide.path}
                        <div>
                            <label> Cargar otra audioguia: </label>
                        </div>
                </g:if>
                <g:else>
                    <label for="audioGuideFile"> Subir AudioGuia
                    </label>
                </g:else>
                <input  type="file" name="audioGuideFile" id="audioGuideFile">

            </fieldset>
            <fieldset class="buttons">
                <g:submitButton name="create" class="save btn btn-success createButton" value="Cargar Traducción" />
            </fieldset>
        </g:form>
    </div>
</div>
<script>
    var disableLang = ${traductionInstance ? true : false};
    if(disableLang){
        $('#language').prop('disabled', true);
    }
    $(function(){
        var select_val = $('#sel_test option:selected').val();
        $('#hdn_test').val(select_val);
        $('#output').text('Selected value is: ' + select_val);
    });
</script>
</body>
</html>