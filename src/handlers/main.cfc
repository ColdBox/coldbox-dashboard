<!---
Author			:	Luis Majano
Create Date		:	September 19, 2005
Update Date		:	September 25, 2006
Description		:

This is the main event handler for the ColdBox dashboard.

--->
<cfcomponent name="main" extends="baseHandler" output="false">

	<!--- ************************************************************* --->

	<cffunction name="onAppStart" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">
		<cfscript>
			var MyService = "";
			var dbService = "";
			
			//Setup My Service
			if ( getSetting("AppMapping") eq "")
				MyService = "model.dbservice";
			else
				MyService = getSetting("AppMapping") & ".model.dbservice";
			
			//Setup the Service
			dbService = CreateObject("component",MyService).init(getController());
			
			//place dashboard service factory in cache
			getColdboxOCM().set("dbservice",dbService,0);
		
		</cfscript>
	</cffunction>
	
	<!--- ************************************************************* --->

	<cffunction name="onRequestStart" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">
		<!--- Get Session Plugin --->
		<cfset var storage = getPlugin("sessionstorage")>
		
		<!--- Check if the dbservice is set, else set it in cache --->
		<cfif not getColdboxOCM().lookup("dbservice")>
			<cfset onAppStart()>
		</cfif>
		
		<!--- GLOBAL EXIT HANDLERS: --->
		<cfset Event.setValue("xehLogout","ehSecurity.doLogout")>
		
		<!--- Inject dbservice to Eventon every request for usage --->
		<cfset Event.setValue("dbService",getColdBoxOCM().get("dbservice"))>
		
		<!--- Authorization --->
		<cfif (not storage.exists("authorized") or storage.getvar("authorized") eq false) and Event.getCurrentEvent() neq "ehSecurity.doLogin">
			<cfset getPlugin("logger").logEntry("information", "Login not authorized #session.toString()#", "")>
			<cfset Event.overrideEvent("ehSecurity.dspLogin")>
		</cfif>
	</cffunction>

	<!--- ************************************************************* --->
	<!--- FRAMESET SECTION												--->
	<!--- ************************************************************* --->
	
	<cffunction name="dspFrameset" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">
		<cfset var rc = Event.getCollection()>
		<!--- EXIT HANDLERS: --->
		<cfset rc.xehHome = "ehInfo.dspGateway">
		<cfset rc.xehHeader = "main.dspHeader">
		<!--- Set the View --->
		<cfset Event.setView("vwFrameset",true)>
	</cffunction>
	
	<cffunction name="dspHeader" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">
		<cfset var rc = Event.getCollection()>
		<!--- EXIT HANDLERS: --->
		<cfset rc.xehHome = "ehInfo.dspGateway">
		<cfset rc.xehSettings = "ehSettings.dspGateway">
		<cfset rc.xehTools = "ehTools.dspGateway">
		<cfset rc.xehUpdate = "ehUpdater.dspGateway">
		<cfset rc.xehBugs = "ehBugs.dspGateway">
		<!--- Set the View --->
		<cfset Event.setView("tags/header")>
	</cffunction>
		
</cfcomponent>