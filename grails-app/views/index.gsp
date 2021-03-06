%{--<!DOCTYPE html>--}%
%{--<html>--}%
	%{--<head>--}%
		%{--<meta name="layout" content="main"/>--}%
		%{--<title>Welcome to Grails</title>--}%
		%{--<style type="text/css" media="screen">--}%
			%{--#status {--}%
				%{--background-color: #eee;--}%
				%{--border: .2em solid #fff;--}%
				%{--margin: 2em 2em 1em;--}%
				%{--padding: 1em;--}%
				%{--width: 12em;--}%
				%{--float: left;--}%
				%{---moz-box-shadow: 0px 0px 1.25em #ccc;--}%
				%{---webkit-box-shadow: 0px 0px 1.25em #ccc;--}%
				%{--box-shadow: 0px 0px 1.25em #ccc;--}%
				%{---moz-border-radius: 0.6em;--}%
				%{---webkit-border-radius: 0.6em;--}%
				%{--border-radius: 0.6em;--}%
			%{--}--}%

			%{--.ie6 #status {--}%
				%{--display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */--}%
			%{--}--}%

			%{--#status ul {--}%
				%{--font-size: 0.9em;--}%
				%{--list-style-type: none;--}%
				%{--margin-bottom: 0.6em;--}%
				%{--padding: 0;--}%
			%{--}--}%

			%{--#status li {--}%
				%{--line-height: 1.3;--}%
			%{--}--}%

			%{--#status h1 {--}%
				%{--text-transform: uppercase;--}%
				%{--font-size: 1.1em;--}%
				%{--margin: 0 0 0.3em;--}%
			%{--}--}%

			%{--#page-body {--}%
				%{--margin: 2em 1em 1.25em 18em;--}%
			%{--}--}%

			%{--h2 {--}%
				%{--margin-top: 1em;--}%
				%{--margin-bottom: 0.3em;--}%
				%{--font-size: 1em;--}%
			%{--}--}%

			%{--p {--}%
				%{--line-height: 1.5;--}%
				%{--margin: 0.25em 0;--}%
			%{--}--}%

			%{--#controller-list ul {--}%
				%{--list-style-position: inside;--}%
			%{--}--}%

			%{--#controller-list li {--}%
				%{--line-height: 1.3;--}%
				%{--list-style-position: inside;--}%
				%{--margin: 0.25em 0;--}%
			%{--}--}%

			%{--@media screen and (max-width: 480px) {--}%
				%{--#status {--}%
					%{--display: none;--}%
				%{--}--}%

				%{--#page-body {--}%
					%{--margin: 0 1em 1em;--}%
				%{--}--}%

				%{--#page-body h1 {--}%
					%{--margin-top: 0;--}%
				%{--}--}%
			%{--}--}%
		%{--</style>--}%
	%{--</head>--}%
	%{--<body>--}%
		%{--<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
		%{--<div id="status" role="complementary">--}%
			%{--<h1>Application Status</h1>--}%
			%{--<ul>--}%
				%{--<li>App version: <g:meta name="app.version"/></li>--}%
				%{--<li>Grails version: <g:meta name="app.grails.version"/></li>--}%
				%{--<li>Groovy version: ${GroovySystem.getVersion()}</li>--}%
				%{--<li>JVM version: ${System.getProperty('java.version')}</li>--}%
				%{--<li>Reloading active: ${grails.util.Environment.reloadingAgentEnabled}</li>--}%
				%{--<li>Controllers: ${grailsApplication.controllerClasses.size()}</li>--}%
				%{--<li>Domains: ${grailsApplication.domainClasses.size()}</li>--}%
				%{--<li>Services: ${grailsApplication.serviceClasses.size()}</li>--}%
				%{--<li>Tag Libraries: ${grailsApplication.tagLibClasses.size()}</li>--}%
			%{--</ul>--}%
			%{--<h1>Installed Plugins</h1>--}%
			%{--<ul>--}%
				%{--<g:each var="plugin" in="${applicationContext.getBean('pluginManager').allPlugins}">--}%
					%{--<li>${plugin.name} - ${plugin.version}</li>--}%
				%{--</g:each>--}%
			%{--</ul>--}%
		%{--</div>--}%
		%{--<div id="page-body" role="main">--}%
			%{--<h1>Welcome to Grails</h1>--}%
			%{--<p>Congratulations, you have successfully started your first Grails application! At the moment--}%
			   %{--this is the default page, feel free to modify it to either redirect to a controller or display whatever--}%
			   %{--content you may choose. Below is a list of controllers that are currently deployed in this application,--}%
			   %{--click on each to execute its default action:</p>--}%

			%{--<div id="controller-list" role="navigation">--}%
				%{--<h2>Available Controllers:</h2>--}%
				%{--<ul>--}%
					%{--<g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">--}%
						%{--<li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>--}%
					%{--</g:each>--}%
				%{--</ul>--}%
			%{--</div>--}%
		%{--</div>--}%
	%{--</body>--}%
%{--</html>--}%


<!doctype html>
<html>
<head>
	<style>
		.contentList {
			font-size: 18px;
		}

		.contentList li {
			margin-top:5px;
			margin-bottom:5px;

			list-style: none;
			font-size: 21px;
		}

		.contentList a {
			color: black;
		}

		.contentList a:hover {
			text-decoration:none;
			color: black
		}

		.contentList img{
			display: block;
			margin-top: 20px;
			margin-bottom: 20px;
			width: 700px;
			height: 300px;
		}
		.boxReseñas a {
			color: black;
			padding-left: 25px;
		}
	</style>
	<meta name="layout" content="mainLayout">
	<asset:stylesheet src="bootstrap/css/bootstrap.min.css"></asset:stylesheet>
	<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body>
<div role="main">
	<div class="container left col-sm-8">
		%{--Barra de navegación--}%
		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<div class="navbar-header">
					<span class="navbar-brand"> Administrator </span>
				</div>
				%{--<div class="collapse navbar-collapse">--}%
					%{--<p class="navbar-text navbar-right"><i class="glyphicon glyphicon-user" aria-hidden="true"></i> ${request.session_context.context.user.fullName}</p>--}%
					%{--<p class="navbar-text navbar-right"><a href="/logout">logout</a></p>--}%
				%{--</div>--}%
			</div>
		</nav>
	%{-- Fin Barra de navegación--}%
		<g:if test="${flash.message}" >
			<div class="alert alert-info">
				${flash.message}
			</div>
		</g:if>
		<g:elseif test="${flash.success}">
			<div class="alert alert-success">
				${flash.success}
			</div>
		</g:elseif>
		<g:elseif test="${flash.error}" >
			<div class="alert alert-danger">
				${flash.error}
			</div>
		</g:elseif>

		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title"> Administrador de Contenido </h3>
			</div>
			<div class="panel-body">
				<ul class="contentList">
					<li>
						<a href="city/list" target="_self"> Ciudades
							<img src="${resource(dir: 'images/', file: 'cities2.png')}" alt="image"/>
						</a>
					</li>
					<li>
						<a href="attraction/list" target="_self"> Atracciones
							<img src="${resource(dir: 'images/', file: 'atracciones2.png')}" alt="image"/>
						</a>
					</li>
					<li>
						<a href="route/list" target="_self"> Recorridos
							<img src="${resource(dir: 'images/', file: 'recorridos.png')}" alt="image"/>
						</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title"> Moderación de Reseñas </h3>
			</div>
			<div class="panel-body boxReseñas">
				<h4> <a href="review/list" target="_self">Buscador de Reseñas</a>  </h4>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title"> Moderación de Usuarios </h3>
			</div>
			<div class="panel-body boxReseñas">
				<h4> <a href="user/list" target="_self">Buscador de Usuarios</a>  </h4>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title"> Moderación de Publicidades </h3>
			</div>
			<div class="panel-body boxReseñas">
				<h4> <a href="advertisment/list" target="_self">Buscador de Publicidades</a>  </h4>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title"> Estadísticas</h3>
			</div>
			<div class="panel-body boxReseñas">
				<h4> <a href="attraction/stats" target="_self"> Atracciones más populares entre los usuarios </a>  </h4>
			</div>
		</div>
	</div>
</div>
</body>
</html>

