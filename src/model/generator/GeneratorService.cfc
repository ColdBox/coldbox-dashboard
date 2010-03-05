<cfcomponent name="GeneratorService" hint="The generator service">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

	<!--- ************************************************************* --->

	<cffunction name="init" access="public" returntype="GeneratorService" output="false">
		<cfargument name="coldbox" required="true" type="any" hint="The coldbox controller">
		<cfscript>
			instance = structnew();
			instance.coldbox = arguments.coldbox;
			instance.apptemplatePath = "";
			return this;
		</cfscript>
	</cffunction>

	<!--- ************************************************************* --->

<!------------------------------------------- PUBLIC ------------------------------------------->

	<cffunction name="generate" access="public" returntype="void" hint="Generate an application" output="false" >
		<cfargument name="generatorBean" required="true" type="any" hint="The app configs">
		<cfscript>
		var ConfigFileContents = "";
		var EclipseProjectContents = "";
		var ConfigFile = "";
		var EclipseFile = "";
		var removeUnitTestFramework = "cfcunit";
		var FS = "/";
		var devURLS = "";
		var i = 1;
		var expandedAppLocation = arguments.generatorBean.getApplocation();

		//First step is to unzip the template to the destination directory.
		getColdbox().getPlugin("Zip").extract(zipFilePath=getappTemplatePath(),extractPath=expandedAppLocation,overwriteFiles=true);

		//Where are the files to manipulate.
		ConfigFile = expandedAppLocation & "#fs#config#fs#coldbox.xml.cfm";
		EclipseFile = expandedAppLocation & "#fs#.project";
		routesFile = expandedApplocation & "#fs#config#fs#Routes.cfm";
		
		//Read the templates
		ConfigFileContents = readFile(ConfigFile);
		EclipseProjectContents = readFile(EclipseFile);
		routesContents = readFile(routesFile);
		
		//Replace Tokens.
		ConfigFileContents = replacenocase(ConfigFileContents,"@APPNAME@",arguments.generatorBean.getAppName());
		ConfigFileContents = replacenocase(ConfigFileContents,"@HANDLER_AUTO_RELOAD@",arguments.generatorBean.gethandlersindexautoreload());
		ConfigFileContents = replacenocase(ConfigFileContents,"@CONFIG_AUTO_RELOAD@",arguments.generatorBean.getconfigautoreload());
		ConfigFileContents = replacenocase(ConfigFileContents,"@EVENT_NAME@",arguments.generatorBean.geteventname());
		ConfigFileContents = replacenocase(ConfigFileContents,"@DEBUG_MODE@",arguments.generatorBean.getDebugMode());
		
		/* SideBar Setup */
		if( arguments.generatorBean.getSideBar() ){
			ConfigFileContents = replacenocase(ConfigFileContents,"@SIDEBAR_SETTING@",getSideBarSetting());
			ConfigFileContents = replacenocase(ConfigFileContents,"@SIDEBAR_INTERCEPTOR@",getSideBarInterceptor());
		}
		else{
			ConfigFileContents = replacenocase(ConfigFileContents,"@SIDEBAR_SETTING@",'');
			ConfigFileContents = replacenocase(ConfigFileContents,"@SIDEBAR_INTERCEPTOR@",'');
		}
			
		//Create Generic error Template
		if ( arguments.generatorBean.getCustom_error_template() ){
			ConfigFileContents = replacenocase(ConfigFileContents,"@CUSTOM_ERROR_TEMPLATE@","includes/templates/generic_error.cfm");
		}
		else{
			ConfigFileContents = replacenocase(ConfigFileContents,"@CUSTOM_ERROR_TEMPLATE@","");
			removeFile(expandedAppLocation & "#fs#includes#fs#templates#fs#generic_error.cfm");
		}
		//Create Exception Handler
		if( arguments.generatorBean.getException_handler() ){
			ConfigFileContents = replacenocase(ConfigFileContents,"@EXCEPTION_HANDLER@","main.onException");
		}
		else{
			ConfigFileContents = replacenocase(ConfigFileContents,"@EXCEPTION_HANDLER@","");
		}
		
		//Replace eclipse project tokens
		EclipseProjectContents = replacenocase(EclipseProjectContents,"@APPNAME@",arguments.generatorBean.getAppName());
		
		//Rewrite Eninge
		if( arguments.generatorBean.getrewriteengine() eq "mod_rewrite"){
			removeFile(expandedAppLocation & "#fs#IsapiRewrite4.ini");
		}
		else if( arguments.generatorBean.getrewriteengine() eq "isapi"){
			removeFile(expandedAppLocation & "#fs#.htaccess");
		}
		else{
			removeFile(expandedAppLocation & "#fs#.htaccess");
			removeFile(expandedAppLocation & "#fs#IsapiRewrite4.ini");
			routesContents = replacenocase(routesContents,"@REWRITE@","/index.cfm");
		}
		//ReWrite File
		writeFile(ConfigFile,ConfigFileContents);
		writeFile(EclipseFile,EclipseProjectContents);
		writeFile(routesFile,routesContents);
		
		</cfscript>
	</cffunction>


<!------------------------------------------- ACCESSORS/MUTATORS ------------------------------------------->


	<cffunction name="getapptemplatePath" access="public" output="false" returntype="string" hint="Get apptemplatePath">
		<cfreturn instance.apptemplatePath/>
	</cffunction>

	<cffunction name="setapptemplatePath" access="public" output="false" returntype="void" hint="Set apptemplatePath">
		<cfargument name="apptemplatePath" type="string" required="true"/>
		<cfset instance.apptemplatePath = arguments.apptemplatePath/>
	</cffunction>

	<cffunction name="getcoldbox" access="public" output="false" returntype="any" hint="Get coldbox">
		<cfreturn instance.coldbox/>
	</cffunction>

	<cffunction name="setcoldbox" access="public" output="false" returntype="void" hint="Set coldbox">
		<cfargument name="coldbox" type="any" required="true"/>
		<cfset instance.coldbox = arguments.coldbox/>
	</cffunction>

<!------------------------------------------- PRIVATE ------------------------------------------->

	<cffunction name="getSidebarSetting" access="public" returntype="string" hint="Get the sidebar Setting" output="false" >
		<cfset var setting = '<Setting name="ColdBoxSideBar" value="true" />'>
		<cfreturn setting>
	</cffunction>
	
	<cffunction name="getSideBarInterceptor" access="public" returntype="string" hint="Get the sidebar Interceptor" output="false" >
		<cfset var sidebar = "">
		<cfsavecontent variable="sidebar">
		<!-- ColdBox SIDEBAR -->
		<Interceptor class="coldbox.system.interceptors.coldboxSideBar" />
		</cfsavecontent>
		<cfreturn sidebar>
	</cffunction>

	<cffunction name="removeDirectory" access="private" returntype="void" hint="Remove a directory" output="false" >
		<cfargument name="dirPath" required="true" type="string" hint="">
		<cfdirectory action="delete" directory="#arguments.dirpath#" recurse="true">
	</cffunction>

	<cffunction name="readFile" access="private" hint="Facade to Read a file's content" returntype="Any" output="false">
		<!--- ************************************************************* --->
		<cfargument name="FileToRead"	 		type="String"  required="yes" 	 hint="The absolute path to the file.">
		<!--- ************************************************************* --->
		<cfset var FileContents = "">
		<cffile action="read" file="#arguments.FileToRead#" variable="FileContents">
		<cfreturn FileContents>
	</cffunction>

	<cffunction name="writeFile" access="private" hint="Facade to write a file's content" returntype="Any" output="false">
		<!--- ************************************************************* --->
		<cfargument name="FileToWrite"	 		type="String"   required="yes" 	 hint="The absolute path to the file.">
		<cfargument name="Contents" 			type="String"	 	required="true"  hint="The string to write">
		<!--- ************************************************************* --->
		<cffile action="write" file="#arguments.FileToWrite#" output="#arguments.Contents#">
	</cffunction>
	
	<cffunction name="removeFile" access="public" returntype="void" hint="Facade to remove a file" output="false" >
		<!--- ************************************************************* --->
		<cfargument name="FileToRemove" required="true" type="string" hint="File To Remove">
		<!--- ************************************************************* --->
		<cffile action="delete" file="#arguments.FileToRemove#">
	</cffunction>
	
</cfcomponent>