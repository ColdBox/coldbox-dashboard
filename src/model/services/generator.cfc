<cfcomponent name="generator" hint="The generator service">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

	<!--- ************************************************************* --->

	<cffunction name="init" access="public" returntype="generator" output="false">
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
		var FS = getColdbox().getSetting("OSFileSeparator",true);
		var devURLS = "";
		var bugEmails = "";
		var i = 1;

		//Expand the Path of the appLocation
		arguments.generatorBean.setAppLocation(expandPath(arguments.generatorBean.getapplocation()));
		//First step is to unzip the template to the destination directory.
		getColdbox().getPlugin("zip").extract(zipFilePath=getappTemplatePath(),extractPath=arguments.generatorBean.getapplocation(),overwriteFiles=true);

		//Tokenise the dev urls
		for ( i = 1; i lte listlen(arguments.generatorBean.getDevurls()); i=i+1){
			devURLS = devURLS & "<url>#listgetAt(arguments.generatorBean.getDevURLS(),i)#</url>#chr(13)#";
		}
		//Tokenize the bug emails
		for ( i = 1; i lte listlen(arguments.generatorBean.getbugemails()); i=i+1){
			bugEmails = bugEmails & "<BugEmail>#listgetAt(arguments.generatorBean.getbugemails(),i)#</BugEmail>#chr(13)#";
		}

		//Where is the config file
		ConfigFile = arguments.generatorBean.getAppLocation() & "#fs#config#fs#config.xml.cfm";
		EclipseFile = arguments.generatorBean.getAppLocation()&"#fs#.project";
		//Read the templates
		ConfigFileContents = readFile(ConfigFile);
		EclipseProjectContents = readFile(EclipseFile);

		//Replace Tokens.
		ConfigFileContents = replacenocase(ConfigFileContents,"@APPNAME@",arguments.generatorBean.getAppName());
		ConfigFileContents = replacenocase(ConfigFileContents,"@COLDFUSION_LOGGING@",arguments.generatorBean.getcoldfusionlogging());
		ConfigFileContents = replacenocase(ConfigFileContents,"@COLDBOX_LOGGING@",arguments.generatorBean.getcoldboxlogging());
		ConfigFileContents = replacenocase(ConfigFileContents,"@COLDBOX_LOGS_LOCATION@",arguments.generatorBean.getcoldboxlogslocation());
		ConfigFileContents = replacenocase(ConfigFileContents,"@OWNER_EMAIL@",arguments.generatorBean.getowneremail());
		ConfigFileContents = replacenocase(ConfigFileContents,"@BUG_REPORTS@",arguments.generatorBean.getenablebugreports());
		ConfigFileContents = replacenocase(ConfigFileContents,"@HANDLER_AUTO_RELOAD@",arguments.generatorBean.gethandlersindexautoreload());
		ConfigFileContents = replacenocase(ConfigFileContents,"@CONFIG_AUTO_RELOAD@",arguments.generatorBean.getconfigautoreload());
		ConfigFileContents = replacenocase(ConfigFileContents,"@BUG_EMAILS@",bugEmails);
		ConfigFileContents = replacenocase(ConfigFileContents,"@DEV_URLS@",devURLS);
		EclipseProjectContents = replacenocase(EclipseProjectContents,"@APPNAME@",arguments.generatorBean.getAppName());
		//ReWrite File
		writeFile(ConfigFile,ConfigFileContents);
		writeFile(EclipseFile,EclipseProjectContents);
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
</cfcomponent>