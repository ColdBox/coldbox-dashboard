<!---
Author			:	Luis Majano
Create Date		:	September 19, 2006
Update Date		:	September 25, 2006
Description		:

This is the app Builder handler.

--->
<cfcomponent name="ehGenerator" extends="coldbox.system.eventhandler" output="false">

<!------------------------------------------- PUBLIC ------------------------------------------->

	<!--- ************************************************************* --->

	<cffunction name="dspGenerator" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any" required="true">
		<cfscript>
			var rc = event.getCollection();
			// EXIT HANDLERS
			rc.xehServerBrowser = "tools.ehServerBrowser.dspBrowser";
			rc.xehGenerate = "tools.ehGenerator.generateApplication";
			// Help
			rc.help = renderView("tools/help/generator");
			// Set the View
			event.setView("tools/vwGenerator");
		</cfscript>
	</cffunction>

	<!--- ************************************************************* --->

	<cffunction name="generateApplication" access="public" returntype="void" output="false">
		<cfargument name="Event" type="coldbox.system.beans.requestContext">
		<cfscript>
			var rc = event.getCollection();
			var oGeneratorBean = rc.dbService.getBean("generatorbean");
			var oGeneratorService = rc.dbService.getService("generator");
			var appRelocation = "";
			//Populate bean with form data
			getPlugin("beanFactory").populateBean(oGeneratorBean);
			//Set appRelocation
			appRelocation = oGeneratorBean.getAppLocation();
			try{
				//Generate Application
				oGeneratorService.generate(oGeneratorBean);
				//Set message
				getPlugin("messagebox").setMessage("info", "Generation completed with no errors.");
				//Relocate
				setNextEvent("tools.ehGenerator.dspGeneratedSummary","appRelocation=#urlEncodedFormat(appRelocation)#");
			}
			Catch(Any e){
				getPlugin("messagebox").setMessage("error", "An error occurred generating your application. Please look at the logs for more information. Diagnostic: #e.detail# #e.message#");
				getPlugin("logger").logError("Error generating application",e);
				setNextEvent("tools.ehGenerator.dspGenerator");
			}
		</cfscript>
	</cffunction>

	<!--- ************************************************************* --->

	<cffunction name="dspGeneratedSummary" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any" required="true">
		<cfscript>
			var rc = event.getCollection();
			rc.appRelocation = urlDecode(rc.appRelocation);
			rc.qAppListing = getDirectoryListing(rc.appRelocation);
			rc.qAppListing = getPlugin("queryHelper").sortQuery(rc.qAppListing,"directory");
			// Set the View
			event.setView("tools/vwGeneratorSummary");
		</cfscript>
	</cffunction>

	<!--- ************************************************************* --->

<!------------------------------------------- PRIVATE ------------------------------------------->

	<cffunction name="getDirectoryListing" output="false" access="private" returntype="query" hint="Get Directory Listing of generated Application">
		<cfargument name="appDirectory" type="string" required="true"/>
		<cfset var qListing = "">
		<cfdirectory action="list" directory="#expandPath(arguments.appDirectory)#" recurse="true" name="qListing">
		<cfreturn qListing>
	</cffunction>

</cfcomponent>