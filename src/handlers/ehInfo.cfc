<!---
Author			:	Luis Majano
Create Date		:	September 19, 2005
Update Date		:	September 25, 2006
Description		:

Informative handler.

--->
<cfcomponent name="ehInfo" extends="baseHandler" output="false">

	<!--- ************************************************************* --->
	<!--- HOME SECTION 													--->
	<!--- ************************************************************* --->

	<cffunction name="dspGateway" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">
		<cfset var rc = Event.getCollection()>
		<!--- EXIT HANDLERS: --->
		<cfset rc.xehSystemInfo = "ehInfo.dspSystemInfo">
		<cfset rc.xehResources = "ehInfo.dspOnlineResources">
		<cfset rc.xehCFCDocs = "ehInfo.dspCFCDocs">
		<!--- Set the Rollovers --->
		<cfset rc.qRollovers = getPlugin("queryHelper").filterQuery(rc.dbService.getService("settings").getRollovers(),"pagesection","home")>
		<!--- Set the View --->
		<cfset Event.setView("home/gateway")>
	</cffunction>

	<cffunction name="dspSystemInfo" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">
		<cfset var rc = Event.getCollection()>
		<!--- Check if install folder exists --->
		<cfset rc.InstallFolderExits = directoryExists(ExpandPath("/coldbox/install"))>
		<!--- Check if the samples folder exists --->
		<cfset rc.SampleFolderExists = directoryExists(ExpandPath("/coldbox/samples"))>
		<!--- Help --->
		<cfset rc.help = renderView("home/help/SystemInfo")>
		<!--- Set the View --->
		<cfset Event.setView("home/vwSystemInfo")>
	</cffunction>

	<cffunction name="dspOnlineResources" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">
		<cfset var rc = Event.getCollection()>
		<!--- Help --->
		<cfset rc.help = renderView("home/help/OnlineResources")>
		<!--- Set the View --->
		<cfset Event.setView("home/vwOnlineResources")>
	</cffunction>

	<cffunction name="dspCFCDocs" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">
		<cfset var rc = Event.getCollection()>
		<cfset var cbloc = getSetting("coldbox_location")>
		<cfset var cbloc2 = right(cbloc,len(cbloc)-1)>

		<!--- EXIT HANDLERS: --->
		<cfset rc.xehCFCDocs = "ehInfo.dspCFCDocs">
		<cfset rc.cfcViewer = getPlugin("cfcViewer")>
		<!---Help --->
		<cfset rc.help = renderView("home/help/CFCDocs")>
		<!---Logic --->
		<cfset Event.paramValue("show", "")>
		<cfif rc.show eq "plugins">
			<cfset rc.cfcViewer.setup("#cbloc#/plugins","#cbloc2#/plugins")>
		<cfelseif rc.show eq "beans">
			<cfset rc.cfcViewer.setup("#cbloc#/beans","#cbloc2#/beans")>
		<cfelseif rc.show eq "util">
			<cfset rc.cfcViewer.setup("#cbloc#/util","#cbloc2#/util")>
		<cfelse>
			<cfset rc.cfcViewer.setup("#cbloc#/","#cbloc2#/")>
		</cfif>
		<!--- Set the View --->
		<cfset Event.setView("home/vwCFCDocs")>
	</cffunction>

</cfcomponent>