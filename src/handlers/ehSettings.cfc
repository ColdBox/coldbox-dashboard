<!---
Author			:	Luis Majano
Create Date		:	September 19, 2005
Update Date		:	September 25, 2006
Description		:

This is the settings handler

--->
<cfcomponent name="ehSettings" extends="baseHandler" output="false">

	<!--- ************************************************************* --->
	<!--- SETTINGS SECTION 												--->
	<!--- ************************************************************* --->

	<cffunction name="dspGateway" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<!--- EXIT HANDLERS: --->
		<cfset rc.xehSettings = "ehSettings.dspOverview">
		<cfset rc.xehLogSettings = "ehSettings.dspLogSettings">
		<cfset rc.xehGeneralSettings = "ehSettings.dspGeneralSettings">
		<cfset rc.xehConventions = "ehSettings.dspConventions">
		<cfset rc.xehPassword = "ehSettings.dspChangePassword">
		<cfset rc.xehProxy = "ehSettings.dspProxySettings">
		<cfset rc.xehCacheSettings = "ehSettings.dspCachesettings">
		<!--- Set the Rollovers For This Section --->
		<cfset rc.qRollovers = getPlugin("queryHelper").filterQuery(rc.dbService.getService("settings").getRollovers(),"pagesection","settings")>
		<!--- Set the View --->
		<cfset Event.setView("settings/gateway")>
	</cffunction>

	<cffunction name="dspOverview" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<cfset rc.fwSettings = rc.dbService.getService("fwsettings").getSettings()>
		<!--- Help --->
		<cfset rc.help = renderView("settings/help/Overview")>
		<!--- Set the View --->
		<cfset Event.setView("settings/vwOverview")>
	</cffunction>

	<cffunction name="dspGeneralSettings" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<cfset var fwSettings = rc.dbservice.getService("fwsettings").getSettings()>
		<!--- Get general Settings --->
		<cfset rc.AvailableCFCharacterSets = fwSettings["AvailableCFCharacterSets"]>
		<cfset rc.DefaultFileCharacterSet = fwSettings["DefaultFileCharacterSet"]>
		<cfset rc.ColdspringBeanFactory = fwSettings["ColdspringBeanFactory"]>
		<cfset rc.LightWireBeanFactory = fwSettings["LightWireBeanFactory"]>
		<cfset rc.MessageBoxStorage = fwSettings["MessageBoxStorage"]>
		<cfset rc.EventName = fwSettings["EventName"]>
		<!--- EXIT HANDLERS: --->
		<cfset rc.xehDoSave = "ehSettings.doSaveGeneralSettings">
		<!--- Help --->
		<cfset rc.help = renderView("settings/help/GeneralSettings")>
		<!--- Set the View --->
		<cfset Event.setView("settings/vwGeneralSettings")>
	</cffunction>
	
	<cffunction name="doSaveGeneralSettings" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfscript>
			var rc = event.getCollection();
			var fwSettings = rc.dbservice.getService("fwsettings").getSettings();
			var setCharacterSet = fwSettings["DefaultFileCharacterSet"];
			var errors = "";
			
			//Error Checks
			if( len(trim(rc.ColdspringBeanFactory)) eq 0 or 
			    len(Trim(rc.EventName)) eq 0 or
			    len(trim(rc.LightWireBeanFactory)) eq 0){
				getPlugin("messagebox").setMessage("error","Please enter all the required fields.");
				setNextEvent("ehSettings.dspGeneralSettings");
			}
			else{
				rc.dbservice.getService("fwsettings").saveGeneralSettings(rc.DefaultFileCharacterSet,rc.MessageBoxStorage,rc.ColdspringBeanFactory,rc.LightWireBeanFactory,rc.EventName);
				getPlugin("messagebox").setMessage("info","Settings have been updated successfully. Please remember to reinitialize the framework on your applications for the changes to take effect.");
				setNextEvent("ehSettings.dspGeneralSettings","fwreinit=#getSetting('ReinitPassword')#");
			}
			
		</cfscript>
	</cffunction>
	
	<cffunction name="dspConventions" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<cfset rc.Conventions = rc.dbservice.getService("fwsettings").getConventions()>
		<!--- EXIT HANDLERS: --->
		<cfset rc.xehDoSave = "ehSettings.doSaveConventions">
		<!--- Help --->
		<cfset rc.help = renderView("settings/help/conventions")>
		<!--- Set the View --->
		<cfset Event.setView("settings/vwConventions")>
	</cffunction>
	
	<cffunction name="doSaveConventions" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfscript>
			var rc = event.getCollection();
			//var Get Bean
			var oConventions = rc.dbservice.getBean("conventions");
			//Populate bean with form data
			getPlugin("beanFactory").populateBean(oConventions);
			//Validate Bean.
			if ( oConventions.validate() ){
				//Save results
				rc.dbService.getService("fwsettings").saveConventions(oConventions);
				//messagebox
				getPlugin("messagebox").setMessage("warning", "Changes made sucessfully. Please note that once you reinitialize the framework IT WILL FAIL! Please make sure you change your conventions appropiately.");
				//Relocate
				setNextEvent("ehSettings.dspConventions");
			}
			else{
				getPlugin("messagebox").setMessage("info","Please fill out all the values");
				setNextEvent("ehSettings.dspConventions");
			}			
		</cfscript>		
	</cffunction>

	<cffunction name="dspLogSettings" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<cfset var fwSettings = rc.dbservice.getService("fwsettings").getSettings()>
		<cfset rc.LogFileEncoding = fwSettings["LogFileEncoding"]>
		<cfset rc.AvailableLogFileEncodings = fwSettings["AvailableLogFileEncodings"]>
		<cfset rc.LogFileBufferSize = fwSettings["LogFileBufferSize"]>
		<cfset rc.LogFileMaxSize = fwSettings["LogFileMaxSize"]>
		<cfset rc.DefaultLogDirectory = fwSettings["DefaultLogDirectory"]>
		<!--- EXIT HANDLERS: --->
		<cfset rc.xehDoSave = "ehSettings.doSaveLogFileSettings">
		<!--- Help --->
		<cfset rc.help = renderView("settings/help/LogFileSettings")>
		<!--- Set the View --->
		<cfset Event.setView("settings/vwLogFileSettings")>
	</cffunction>

	<cffunction name="doSaveLogFileSettings" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<cfset var fwSettings = rc.dbservice.getService("fwsettings").getSettings()>
		<cfset var errors = false>
		<!--- Validate blanks --->
		<cfif len(trim(rc.DefaultLogDirectory)) eq 0 or len(trim(rc.LogFileEncoding)) eq 0 or len(trim(rc.LogFileBufferSize)) eq 0 or len(trim(rc.LogFileMaxSize)) eq 0>
			<cfset getPlugin("messagebox").setMessage("error","Please make sure you fill out all the values.")>
			<cfset errors = true>
		</cfif>
		<!--- Validate Buffer --->
		<cfif not isNumeric(rc.LogFileBufferSize) or rc.LogFileBufferSize gt 64000 or rc.LogFileBufferSize lt 8000>
			<cfset getPlugin("messagebox").setMessage("error","The Log File Buffer Size you sent in is not numeric or you choose a number not betwee 8000-64000 bytes. Please try again")>
			<cfset errors = true>
		</cfif>
		<!--- ValidateMax Size ---->
		<cfif not isNumeric(rc.LogFileMaxSize)>
			<cfset getPlugin("messagebox").setMessage("error","The Log File Max Size you sent in is not numeric. Please try again")>
			<cfset errors = true>
		</cfif>
		<!--- Check for Errors --->
		<cfif not errors>
			<!--- Update the settings --->
			<cfset rc.dbservice.getService("fwsettings").saveLogFileSettings(rc.LogFileEncoding,rc.LogFileBufferSize,rc.LogFileMaxSize, rc.DefaultLogDirectory)>
			<cfset getPlugin("messagebox").setMessage("info","Settings have been updated successfully. Please remember to reinitialize the framework on your applications for the changes to take effect.")>
			<!--- Relocate --->
			<cfset setNextEvent("ehSettings.dspLogSettings","fwreinit=#getSetting('ReinitPassword')#")>
		<cfelse>
			<!--- Relocate --->
			<cfset setNextEvent("ehSettings.dspLogSettings")>
		</cfif>
	</cffunction>

	<cffunction name="dspChangePassword" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<!--- EXIT HANDLERS: --->
		<cfset rc.xehDoSave = "ehSettings.doChangePassword">
		<!--- Help --->
		<cfset rc.help = renderView("settings/help/Password")>
		<!--- Set the View --->
		<cfset Event.setView("settings/vwPassword")>
	</cffunction>

	<cffunction name="doChangePassword" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<cfset var errors = false>
		<cfset var rtnStruct = "">
		<!--- Validate Passwords --->
		<cfif len(trim(rc.oldpassword)) eq 0 or len(trim(rc.newpassword)) eq 0 or len(trim(rc.newpassword2)) eq 0>
			<cfset getPlugin("messagebox").setMessage("error", "Please fill out all the necessary fields.")>
		<cfelse>
			<!--- Save the new password --->
			<cfset rtnStruct = rc.dbservice.getService("settings").changePassword(rc.oldpassword,rc.newpassword,rc.newpassword2)>
			<!--- Validate --->
			<cfif not rtnStruct.results>
				<cfset getPlugin("messagebox").setMessage("error", "#rtnStruct.message#")>
			<cfelse>
				<cfset getPlugin("messagebox").setMessage("info", "Your new password has been updated successfully.")>
			</cfif>
		</cfif>
		<!--- Move to new event --->
		<cfset setnextEvent("ehSettings.dspChangePassword")>
	</cffunction>

	<cffunction name="dspCacheSettings" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<cfset var settings = rc.dbservice.getService("fwsettings").getSettings()>
		<cfset rc.CacheObjectDefaultTimeout = settings["CacheObjectDefaultTimeout"]>
		<cfset rc.CacheObjectDefaultLastAccessTimeout = settings["CacheObjectDefaultLastAccessTimeout"]>
		<cfset rc.CacheReapFrequency = settings["CacheReapFrequency"]>
		<cfset rc.CacheMaxObjects = settings["CacheMaxObjects"]>
		<cfset rc.CacheFreeMemoryPercentageThreshold = settings["CacheFreeMemoryPercentageThreshold"]>
		<!--- EXIT HANDLERS: --->
		<cfset rc.xehDoSave = "ehSettings.doSaveCacheSettings">
		<!--- Help --->
		<cfset rc.help = renderView("settings/help/CachingSettings")>
		<!--- Set the View --->
		<cfset Event.setView("settings/vwCachingSettings")>

	</cffunction>

	<cffunction name="doSaveCacheSettings" access="public" returntype="void" output="false">
		<cfargument name="event" type="any" required="true">
		<cfset var rc = event.getCollection()>
		<cfset var fwSettings = rc.dbservice.getService("fwsettings").getSettings()>
		<cfset var errors = false>
		<!--- Validate blanks --->
		<cfif len(trim(rc.CacheObjectDefaultTimeout)) eq 0 or
		      len(trim(rc.CacheObjectDefaultLastAccessTimeout)) eq 0 or
		      len(Trim(rc.CacheReapFrequency)) eq 0 or
		      len(trim(rc.CacheMaxObjects)) eq 0 or
		      len(trim(rc.CacheFreeMemoryPercentageThreshold)) eq 0>
			<cfset getPlugin("messagebox").setMessage("error","You cannot leave any empty configurations.")>
			<cfset setNextEvent("ehSettings.dspCacheSettings")>
		<cfelseif not isNumeric(rc.CacheObjectDefaultTimeout) or
				  not isNumeric(rc.CacheObjectDefaultLastAccessTimeout) or
				  not isNumeric(rc.CacheReapFrequency) or
				  not isNumeric(rc.CacheMaxObjects) or
				  not isNumeric(rc.CacheFreeMemoryPercentageThreshold)>
			<cfset getPlugin("messagebox").setMessage("error","Only numerical values are allowed.")>
			<cfset setNextEvent("ehSettings.dspCacheSettings")>
		<cfelse>
			<cfset rc.dbservice.getService("fwsettings").saveCacheSettings(rc.CacheObjectDefaultTimeout,
																	rc.CacheObjectDefaultLastAccessTimeout,
																	rc.CacheReapFrequency,
																	rc.CacheMaxObjects,
																	rc.CacheFreeMemoryPercentageThreshold)>
			<cfset getPlugin("messagebox").setMessage("info","Settings have been updated successfully. Please remember to reinitialize the framework on your applications for the changes to take effect.")>
			<!--- Relocate --->
			<cfset setNextEvent("ehSettings.dspCacheSettings","fwreinit=#getSetting('ReinitPassword')#")>
		</cfif>
	</cffunction>

</cfcomponent>