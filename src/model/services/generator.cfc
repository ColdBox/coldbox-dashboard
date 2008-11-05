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
		var unitTest1 = "";
		var unitTest1Contents = "";
		var unitTest2 = "";
		var unitTest2Contents = "";
		var unitTestFramework = arguments.generatorBean.getunittesting_framework();
		var removeUnitTestFramework = "cfcunit";
		var FS = getColdbox().getSetting("OSFileSeparator",true);
		var devURLS = "";
		var bugEmails = "";
		var i = 1;
		var expandedAppLocation = arguments.generatorBean.getapplocation();

		//First step is to unzip the template to the destination directory.
		getColdbox().getPlugin("zip").extract(zipFilePath=getappTemplatePath(),extractPath=expandedAppLocation,overwriteFiles=true);

		//Tokenize the bug emails
		for ( i = 1; i lte listlen(arguments.generatorBean.getbugemails()); i=i+1){
			bugEmails = bugEmails & chr(9) & chr(9) & "<BugEmail>#listgetAt(arguments.generatorBean.getbugemails(),i)#</BugEmail>#chr(13)#";
		}
		
		/* Unit Test */
		if( unitTestFramework eq "mxunit" ){
			removeUnitTestFramework = "cfcunit";
		}
		else{
			removeUnitTestFramework = "mxunit";
		}

		//Where are the files to manipulate.
		ConfigFile = expandedAppLocation & "#fs#config#fs#coldbox.xml.cfm";
		EclipseFile = expandedAppLocation & "#fs#.project";
		unitTest1 = expandedAppLocation  & "#fs#test#fs#integration#fs##unitTestFramework##fs#generalTest.cfc";
		unitTest2 = expandedAppLocation  & "#fs#test#fs#integration#fs##unitTestFramework##fs#mainTest.cfc";
		
		//Read the templates
		ConfigFileContents = readFile(ConfigFile);
		EclipseProjectContents = readFile(EclipseFile);
		unitTest1Contents = readFile(unitTest1);
		unitTest2Contents = readFile(unitTest2);
		
		//Replace Tokens.
		ConfigFileContents = replacenocase(ConfigFileContents,"@APPNAME@",arguments.generatorBean.getAppName());
		ConfigFileContents = replacenocase(ConfigFileContents,"@COLDFUSION_LOGGING@",arguments.generatorBean.getcoldfusionlogging());
		ConfigFileContents = replacenocase(ConfigFileContents,"@COLDBOX_LOGGING@",arguments.generatorBean.getcoldboxlogging());
		ConfigFileContents = replacenocase(ConfigFileContents,"@COLDBOX_LOGS_LOCATION@",arguments.generatorBean.getcoldboxlogslocation());
		ConfigFileContents = replacenocase(ConfigFileContents,"@OWNER_EMAIL@",arguments.generatorBean.getowneremail());
		ConfigFileContents = replacenocase(ConfigFileContents,"@BUG_REPORTS@",arguments.generatorBean.getenablebugreports());
		ConfigFileContents = replacenocase(ConfigFileContents,"@HANDLER_AUTO_RELOAD@",arguments.generatorBean.gethandlersindexautoreload());
		ConfigFileContents = replacenocase(ConfigFileContents,"@CONFIG_AUTO_RELOAD@",arguments.generatorBean.getconfigautoreload());
		ConfigFileContents = replacenocase(ConfigFileContents,"@EVENT_NAME@",arguments.generatorBean.geteventname());
		ConfigFileContents = replacenocase(ConfigFileContents,"@BUG_EMAILS@",bugEmails);
				
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
		
		//Replace Unit Test Mappings
		unitTest1Contents = replacenocase(unitTest1Contents,"@APP_MAPPING@",arguments.generatorBean.getAppLocation());
		unitTest2Contents = replacenocase(unitTest2Contents,"@APP_MAPPING@",arguments.generatorBean.getAppLocation());
		
		//ReWrite File
		writeFile(ConfigFile,ConfigFileContents);
		writeFile(EclipseFile,EclipseProjectContents);
		writeFile(unitTest1, unitTest1Contents);
		writeFile(unitTest2, unitTest2Contents);
		
		/* Directory Removals */
		removeDirectory(expandedAppLocation  & "#fs#test#fs#integration#fs##removeUnitTestFramework#");
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