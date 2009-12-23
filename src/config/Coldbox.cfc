<cfcomponent output="false" hint="Dashboard Configuration">
<cfscript>
/**
structures to create for configuration

- coldbox
- settings
- conventions
- environments
- ioc
- models
- debugger
- mailSettings
- i18n
- bugTracers
- webservices
- datasources
- layoutSettings
- layouts
- cacheEngine
- interceptorSettings
- interceptors

Available objects in variable scope
- controller
- logBoxConfig
- appMapping (auto calculated by ColdBox)

Required Methods
- configure() : The method ColdBox calls to configure the application.
Optional Methods
- detectEnvironment() : If declared the framework will call it and it must return the name of the environment you are on.
- {environment}() : The name of the environment found and called by the framework.

*/
	
	// Configure ColdBox Application
	function configure(){
	
		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= "ColdBox Dashboard",
			
			//Development Settings
			debugMode				= false,
			debugPassword			= "",
			reinitPassword			= "",
			handlersIndexAutoReload = false,
			configAutoReload		= false,
			
			//Implicit Events
			defaultEvent			= "main.dspFrameset",
			requestStartHandler		= "main.onRequestStart",
			requestEndHandler		= "",
			applicationStartHandler = "main.onAppStart",
			applicationEndHandler	= "",
			sessionStartHandler 	= "",
			sessionEndHandler		= "",
			missingTemplateHandler	= "",
			
			//Extension Points
			UDFLibraryFile 			= "includes/helpers/ApplicationHelper.cfm",
			coldboxExtensionsLocation = "",
			pluginsExternalLocation = "",
			viewsExternalLocation	= "",
			layoutsExternalLocation = "",
			handlersExternalLocation  = "",
			requestContextDecorator = "",
			
			//Error/Exception Handling
			exceptionHandler		= "",
			onInvalidEvent			= "main.dspFrameset",
			customErrorTemplate		= "",
				
			//Application Aspects
			handlerCaching 			= true,
			eventCaching			= true,
			proxyReturnCollection 	= false,
			flashURLPersistScope	= "session"	
		};
	
		// custom settings
		settings = {
			version = "2.2.5 Beta",
			tracSite = "http://ortus.svnrepository.com/coldbox/",
			officialSite = "http://www.coldbox.org",
			
			coldbox_location = "/coldbox/system",
			coldboxSamples_location = "/coldbox/samples",
			
			adobeAdmin = "/CFIDE/administrator/login.cfm",
			blueDragonAdmin = "/bluedragon",
			railoAdmin = "/railo-context/admin/index.cfm"
		};
		
		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			development = "^cf8.,^railo.,^cf9."
		};
		
		//LogBox
		logBoxConfig.appender(name="coldboxTracer",class="coldbox.system.logging.appenders.ColdboxTracerAppender");
		logBoxConfig.root(levelMax=logBoxConfig.logLevels.INFO,appenders="*");
		logBoxConfig.info("coldbox.system");
		
		//Layout Settings
		layoutSettings = {
			defaultLayout = "Layout.simple.cfm",
			defaultView   = ""
		};
		
		//Register Layouts
		layouts = {
			login = {
				file = "Layout.Login.cfm",
				views = "vwLogin"
			},
			main = {
				file = "Layout.Main.cfm",
				views = "home/gateway,settings/gateway,bugs/gateway,tools/gateway,update/gateway"
			}
		};
		
		//Interceptor Settings
		interceptorSettings = {
			throwOnInvalidStates = false,
			customInterceptors = ""
		};
		
		//Register interceptors as an array, we need order
		interceptors = [
			//Autowire
			{class="coldbox.system.interceptors.Autowire",
			 properties={}
			}
		];
		

	}// end configure()
	
	function development(){
		coldbox.handlerCaching = false;
		coldbox.handlersIndexAutoReload = true;
	}
	
</cfscript>
</cfcomponent>