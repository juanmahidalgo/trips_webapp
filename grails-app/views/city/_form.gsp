<%@ page import="tripswebapp.model.City" %>



<div class="${hasErrors(bean: cityInstance, field: 'country', 'error')} required">
	<label for="country">
		<g:message code="city.country.label" default="Country" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="country" name="country.id" from="${tripswebapp.model.Country.list()}" optionKey="id" style="width: 350px;" required="" value="${cityInstance?.country?.id}" class="many-to-one chosen-select  "/>

</div>

%{--
<div class="fieldcontain ${hasErrors(bean: cityInstance, field: 'attractions', 'error')} ">
--}%
	%{--<label for="attractions">
		<g:message code="city.attractions.label" default="Attractions" />
		
	</label>
	<g:select name="attractions" from="${tripswebapp.model.Attraction.list()}" multiple="multiple" optionKey="id" size="5" value="${cityInstance?.attractions*.id}" class="many-to-many"/>
--}%
%{--
</div>
--}%

<div class="fieldcontain inputField ${hasErrors(bean: cityInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="city.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${cityInstance?.name}"/>
</div>

<div class="fieldcontain">

	<label for="imageFile"> Upload Image: </label>

	<input  type="file" name="imageFile">

</div>

<script type="application/javascript">
        $(".chosen-select ").chosen({no_results_text: "No se encontraron resultados!"});
</script>