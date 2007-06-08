<!---
Author			:	Luis Majano
Create Date		:	September 19, 2006
Update Date		:	September 25, 2006
Description		:

This is the File Browser Handler

--->
<cfcomponent name="ehServerBrowser" extends="baseHandler" output="false">
	
	<cffunction name="preHandler" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any" required="true">
		<cfset event.setLayout("Layout.Ajax")>
	</cffunction>
	
	<!--- ************************************************************* --->

	<cffunction name="dspBrowser" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<cfset var oSession = getPlugin("sessionstorage")>
		
		<!--- EXIT HANDLERS: --->
		<cfset rc.xehBrowser = "ehServerBrowser.dspBrowser">
		<cfset rc.xehNewFolder = "ehServerBrowser.doNewFolder">
		
		<cfif event.valueExists("callbackItem")>
			<cfset oSession.setvar("callBackItem", event.getValue("callbackItem") )>
		<cfelseif not oSession.exists("callBackItem")>
			<cfdump var="You need a callBackItem in order to use the browser chooser">
			<cfaborT>
		</cfif>
		
		<!--- Test for dir param,else set to / --->
		<cfset event.paramValue("dir","/")>
		
		<!--- Test if param is blank --->
		<cfif event.getValue("dir") eq "">
			<cfset event.setValue("dir","/")>
		<cfelse>
			<cfset rc.dir = urlDecode(rc.dir)>
		</cfif>
		
		<!--- Init Options --->
		<cfif rc.dir eq "/">
			<cfset rc.currentRoot = "/">
			<cfset oSession.setvar("oldRoot","/")>
			<cfset oSession.setvar("currentRoot","/")>
		<cfelse>
			<cfset rc.currentRoot = rc.dir>
			<cfset oSession.setvar("oldRoot",listdeleteAt(rc.currentRoot, listlen(rc.currentRoot,"/"), "/"))>
			<cfif oSession.getVar("oldRoot") eq "">
				<cfset oSession.setvar("oldRoot","/")>
			</cfif>
			<cfset oSession.setvar("currentRoot",rc.currentRoot)>
		</cfif>
		
		<!--- Get Dir Listing --->
		<cfdirectory action="list" directory="#expandPath(rc.currentRoot)#" name="rc.qryDir" sort="asc">
		
		<!--- Sort --->
		<cfset rc.qryDir = getPlugin("queryHelper").sortQuery(rc.qryDir,"Type,Name")>
		
		<!--- Set the view --->
		<cfset event.setView("tags/serverbrowser")>
	</cffunction>
	
	<!--- ************************************************************* --->
	
	<cffunction name="doNewFolder" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<cfset var newDir = "">
		<!--- Check for incoming params --->
		<cfif len(trim(event.getValue("newFolder",""))) eq 0>
			<cfset getPlugin("messagebox").setMessage("warning", "Please enter a valid folder name.")>
		<cfelse>
		    <cfset newDir = event.getValue("dir") & "/" & event.getValue("NewFolder")>
			<cfdirectory action="create" directory="#ExpandPath(newDir)#">
			<cfset getPlugin("messagebox").setMessage("info", "Folder Created Successfully")>
		</cfif>
		
		<!--- Set the next event --->
		<cfset setNextEvent("ehServerBrowser.dspBrowser","dir=#event.getValue("dir")#")>
	</cffunction>
	
	<!--- ************************************************************* --->
</cfcomponent>