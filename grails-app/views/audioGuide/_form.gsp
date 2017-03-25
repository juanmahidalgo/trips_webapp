<%@ page import="tripswebapp.media.AudioGuide" %>



<div class="fieldcontain ${hasErrors(bean: audioGuideInstance, field: 'file', 'error')} required">
	<label for="file">
		<g:message code="audioGuide.file.label" default="File" />
		<span class="required-indicator">*</span>
	</label>
	

</div>

