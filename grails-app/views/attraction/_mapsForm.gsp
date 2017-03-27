<div class="fieldcontain maps">
    <label> Maps (max 3): </label>
    <g:if test="${attractionInstance?.maps}">
        <g:each var="i" in="${ (0..<3) }">
            <label> Map ${i+1} </label>
            <g:if test="${attractionInstance?.maps[i]}">
                <img src="${resource(dir: 'images/maps', file: attractionInstance?.maps[i].path)}" alt="mapa"/>
            %{--
                        <input type='file' name='documentFile.{i+1}' value="${attractionInstance?.maps[i]}" />
            --}%
            </g:if>
            <g:else>
                No map loaded
            </g:else>
        </g:each>
    </g:if>
</div>