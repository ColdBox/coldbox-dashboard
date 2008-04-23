<!---
Author			:	Luis Majano
Create Date		:	September 19, 2006
Update Date		:	September 25, 2006
Description		:

This is the File Browser Handler

--->
<cfcomponent name="ehServerBrowser" extends="baseHandler" output="false">
	
	<!--- Pre Handler --->
	<cffunction name="preHandler" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any" required="true">
		<cfset event.setLayout("Layout.Ajax")>
	</cffunction>
	
	<!--- dsp Browser --->
	<cffunction name="dspBrowser" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<cfset var slash = "/">
		<cfset var currentRootLen = 0>
		
		<!--- EXIT HANDLERS: --->
		<cfset rc.xehBrowser = "ehServerBrowser.dspBrowser">
		<cfset rc.xehNewFolder = "ehServerBrowser.doNewFolder">
		
		<cfset rc.oSession = getPlugin("sessionstorage")>
		
		<!--- Check for callback. --->
		<cfif event.valueExists("callbackItem")>
			<cfset rc.oSession.setvar("callBackItem", event.getValue("callbackItem") )>
		<cfelseif not rc.oSession.exists("callBackItem")>
			<cfdump var="You need a callBackItem in order to use the browser chooser">
			<cfaborT>
		</cfif>
		
		<!--- Get Computer Roots --->
		<cfset rc.roots = createObject("java","java.io.File").listRoots()>
		
		<!--- Select Default Computer Root if not set. --->
		<cfif not rc.oSession.exists("computerRoot")>
			<cfset rc.oSession.setVar("computerRoot", rc.roots[1].getAbsolutePath())>
		</cfif>
		<!--- Check if there is no incoming computer root change --->
		<cfif not event.valueExists('computerRoot')>
			<!--- Set Computer Root, from session storage --->
			<cfset rc.computerRoot = rc.oSession.getVar('computerRoot')>
		<cfelse>
			<cfset rc.computerRoot = urlDecode(rc.computerRoot)>
			<cfset rc.oSession.setVar("computerRoot", rc.computerRoot)>
			<cfset rc.dir = rc.computerRoot>
		</cfif>
		
		<!--- Test if incoming directory is blank --->
		<cfif not event.valueExists("dir") or event.getValue("dir") eq "">
			<!--- Test if we have an old location, else set back to the root --->
			<cfif rc.oSession.getVar("currentRoot") neq "">
				<cfset event.setValue("dir",rc.oSession.getVar("currentRoot"))>
			<cfelse>
				<cfset event.setValue("dir",rc.computerRoot)>
			</cfif>
		<cfelse>
			<cfset rc.dir = urlDecode(rc.dir)>
		</cfif>
		
		<!--- Init The Current Root. --->
		<cfset rc.currentRoot = rc.dir>
		
		<!--- Setup the old root if unequal to current root. --->
		<cfset currentRootLen = listlen(rc.currentRoot,slash)>
		<cfif currentRootLen neq 0>
			<cfset rc.oSession.setvar("oldRoot",listdeleteAt(rc.currentRoot, currentRootLen, slash))>
		</cfif>
		
		<cftry>
			<!--- Get Dir Listing --->
			<cfdirectory action="list" directory="#rc.currentRoot#" name="rc.qryDir" sort="name">
			<!--- Sort --->
			<cfset rc.qryDir = getPlugin("queryHelper").sortQuery(rc.qryDir,"Type,Name")>
			<!--- Save the current root --->
			<cfset rc.oSession.setVar("currentRoot", rc.currentRoot)>
			
			<cfcatch type="any">
				<cfset rc.qryDir = QueryNew("")>
				<cfset getPlugin("messagebox").setMessage("warning", "An error occurred reading directory. #cfcatch.message# - #cfcatch.detail#")>	
			</cfcatch>
		</cftry>	
				
		<!--- Set the view --->
		<cfset event.setView("tags/serverbrowser")>
	</cffunction>
	
	
	<!--- Create a new folder --->
	<cffunction name="doNewFolder" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<cfset var newDir = "">
		
		<!--- Check for incoming params --->
		<cfif len(trim(event.getValue("newFolder",""))) eq 0>
			<cfset getPlugin("messagebox").setMessage("warning", "Please enter a valid folder name.")>
		<cfelse>
		    <cfset newDir = event.getValue("dir") & "/" & event.getValue("NewFolder")>
			<cfdirectory action="create" directory="#newDir#">
			<cfset getPlugin("messagebox").setMessage("info", "Folder Created Successfully")>
		</cfif>
		
		<!--- Set the next event --->
		<cfset setNextEvent("ehServerBrowser.dspBrowser","dir=#event.getValue("dir")#")>
	</cffunction>
	
	<!--- ************************************************************* --->
</cfcomponent>