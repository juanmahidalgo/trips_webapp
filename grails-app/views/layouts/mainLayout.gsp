<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
	<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
	<asset:javascript src="jquery-2.1.4.min.js"></asset:javascript>
	<asset:stylesheet src="bootstrap/css/bootstrap.min.css"></asset:stylesheet>
	<asset:javascript src="bootstrap/js/bootstrap.js"></asset:javascript>
	<asset:javascript src="chosen.jquery.js"></asset:javascript>
	<asset:stylesheet src="chosen.min.css"></asset:stylesheet>
	<asset:javascript src="chosen.order.jquery.min.js"></asset:javascript>

	%{--<script type="text/javascript"
			src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB2HKAXBafJpycygBDLiS_tDyP86h6MTUk&libraries=geometry">
	</script>--}%

	<link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" type="text/css">

	<style>
			.table td {
				word-wrap: break-word;
				max-width: 150px;
			}
			.fa {
				display: inline-block;
				font: normal normal normal 14px/1 FontAwesome;
				font-size: inherit;
				text-rendering: auto;
				-webkit-font-smoothing: antialiased;
				-moz-osx-font-smoothing: grayscale;
				transform: translate(0, 0);
			}
			.fa-chevron-left:before {
				content:"\2039";
			}
			.fa-chevron-right:before {
				content:"\203a"
			}
			.loading{
				background-image:url('../images/spinner.gif');
				background-size: 30px 30px;
				background-repeat: no-repeat;
				background-color: transparent;
				width: 30px;
				height: 30px;
			}
			.history-log{
				margin-bottom:30px;
			}
			.lineSeparator{
				margin: 10px -20px 10px -20px;
				border-top:1px solid black;
			}
			.btnContainer{
				text-align: center;
				padding: 15px 0 15px 0;
			}
			td:hover {
				cursor: pointer;
			}
			tr.line.even:hover, tr.line.odd:hover {
				background-color: rgba(237, 237, 234, 0.89);
			}
			.btn-add{
				margin-top: 15px;
				margin-bottom: 15px;
			}
			.filter{
				margin-top:25px;
			}
			.filterComponent{
				margin-top:15px;
				margin-bottom:15px;
				padding-left: 0px;
			}
			tr.even {
				background-color:  rgb(235,238,247);
			}
			#searchBarContainer {
				margin-bottom: 15px;
			}
		</style>

		<g:layoutHead />
		%{--<r:layoutResources />--}%
	</head>
	<body>
		<g:render template="/templates/navBar"></g:render>
		<div role="main" style="margin: 0px 20px 0px 20px;">
			<g:layoutBody/>
		</div>
	</body>
</html>