<cfsetting showdebugoutput="false">
<cfset event.showdebugpanel(false)>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
	<title>ColdBox Dashboard</title>
	<link href="includes/styles/style.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="includes/javascript/dashboard.js"></script>
	<script language="javascript" src="includes/javascript/jquery-latest.pack.js"></script>
	<script language="javascript" src="includes/javascript/plugins/jqModal.js"></script>
	<script language="javascript" src="includes/javascript/plugins/jqDnR.js"></script>
	<script language="javascript" src="includes/javascript/plugins/jquery.block.js"></script>
</head>
<body>
<cfoutput>
#renderView()#
</cfoutput>
</body>
</html>