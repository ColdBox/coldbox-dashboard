<!---
Author			:	Luis Majano
Create Date		:	September 19, 2005
Update Date		:	September 25, 2006
Description		:

This is the tools main handler.

--->
<cfcomponent name="ehTools" extends="baseHandler" output="false">

	<!--- ************************************************************* --->
	<!--- TOOLS SECTION 												--->
	<!--- ************************************************************* --->
	
	<cffunction name="dspGateway" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">
		<cfset var rc = event.getCollection()>
		<!--- EXIT HANDLERS: --->
		<cfset rc.xehGenerator = "ehGenerator.dspGenerator">
		<!--- Set the Rollovers For This Section --->
		<cfset rc.qRollovers = getPlugin("queryHelper").filterQuery(rc.dbService.getService("settings").getRollovers(),"pagesection","tools")>
		<!--- Set the View --->
		<cfset Event.setView("tools/gateway")>
	</cffunction>

	
</cfcomponent>