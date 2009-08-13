<cfscript>
	// General Properties
	setEnabled(true);
	setUniqueURLS(false);
	
	// Base URL
	if( len(getSetting('AppMapping') ) lte 1){
		setBaseURL("http://#cgi.HTTP_HOST#@REWRITE@");
	}
	else{
		setBaseURL("http://#cgi.HTTP_HOST#/#getSetting('AppMapping')#@REWRITE@");
	}
	
	// Your Application Routes
	addRoute(pattern=":handler/:action?");
</cfscript>