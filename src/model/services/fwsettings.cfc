<cfcomponent output="false" displayname="fwsettings" hint="I am the Dashboard Framework Settings model.">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

	<cffunction name="init" access="public" returntype="fwsettings" output="false">
		<cfargument name="coldbox" required="true" type="any" hint="The coldbox controller">
		<cfscript>
			variables.instance = structnew();
			variables.instance.coldbox = arguments.coldbox;
			variables.instance.settingsFilePath = ExpandPath("#getColdbox().getSetting("coldbox_location")#/config/settings.xml");
			variables.instance.qSettings = queryNew("");
			variables.instance.Conventions = structnew();
			variables.instance.xmlObj = "";
			parseSettings();
			return this;
		</cfscript>
	</cffunction>

<!------------------------------------------- PUBLIC ------------------------------------------->

	<cffunction name="saveConventions" access="public" returntype="void" output="false">
		<cfargument name="conventionBean" required="true" type="any">
		<cfscript>
			//save conventions
			var xmlConventions = instance.xmlObj.xmlRoot.Conventions;
			var key = "";
			var Conventions = getConventions();

			//Save XML
			xmlConventions[1].configLocation.xmlText = arguments.conventionBean.getConfigLocation();
			xmlConventions[1].handlerLocation.xmlText = arguments.conventionBean.gethandlerLocation();
			xmlConventions[1].layoutsLocation.xmlText = arguments.conventionBean.getlayoutsLocation();
			xmlConventions[1].viewsLocation.xmlText = arguments.conventionBean.getviewsLocation();

			//Save structure
			for ( key in Conventions ){
				Conventions[key] = evaluate("arguments.conventionBean.get#key#()");
			}
			//save file.
			saveSettings();
		</cfscript>
	</cffunction>

	<cffunction name="saveLogFileSettings" access="public" returntype="void" output="false">
		<!--- ************************************************************* --->
		<cfargument name="LogFileEncoding" 		required="true" type="string">
		<cfargument name="LogFileBufferSize" 	required="true" type="string">
		<cfargument name="LogFileMaxSize" 		required="true" type="string">
		<cfargument name="DefaultLogDirectory"  required="true" type="string">
		<!--- ************************************************************* --->
		<cfscript>
		var x = 1;
		var settingArray = instance.xmlObj.xmlRoot.settings.xmlChildren;
		for (x=1; x lte ArrayLen(settingArray); x=x+1){
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"DefaultLogDirectory") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.DefaultLogDirectory);
			}
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"LogFileEncoding") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.logFileEncoding);
			}
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"LogFileBufferSize") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.LogFileBufferSize);
			}
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"LogFileMaxSize") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.LogFileMaxSize);
			}
		}
		saveSettings();
		</cfscript>
	</cffunction>

	<cffunction name="saveGeneralSettings" access="public" returntype="void" output="false">
		<!--- ************************************************************* --->
		<cfargument name="DefaultFileCharacterSet"		required="true" type="string">
		<cfargument name="MessageBoxStorage" 	        required="true" type="string">
		<cfargument name="ColdspringBeanFactory" 	    required="true" type="string">
		<cfargument name="LightwireBeanFactory" 	    required="true" type="string">
		<cfargument name="EventName" 					required="true" type="string" />
		<!--- ************************************************************* --->
		<cfscript>
		var x = 1;
		var settingArray = instance.xmlObj.xmlRoot.settings.xmlChildren;
		for (x=1; x lte ArrayLen(settingArray); x=x+1){
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"DefaultFileCharacterSet") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.DefaultFileCharacterSet);
			}
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"MessageBoxStorage") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.MessageBoxStorage);
			}
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"ColdspringBeanFactory") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.ColdspringBeanFactory);
			}
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"LightWireBeanFactory") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.LightWireBeanFactory);
			}
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"EventName") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.EventName);
			}
		}
		saveSettings();
		</cfscript>
	</cffunction>

	<cffunction name="saveCacheSettings" access="public" returntype="void" output="false">
		<!--- ************************************************************* --->
		<cfargument name="CacheObjectDefaultTimeout"			required="true" type="string">
		<cfargument name="CacheObjectDefaultLastAccessTimeout" 	required="true" type="string">
		<cfargument name="CacheReapFrequency" 	    			required="true" type="string">
		<cfargument name="CacheMaxObjects" 	    				required="true" type="string">
		<cfargument name="CacheFreeMemoryPercentageThreshold"	required="true" type="string">
		<!--- ************************************************************* --->
		<cfscript>
		var x = 1;
		var settingArray = instance.xmlObj.xmlRoot.settings.xmlChildren;
		for (x=1; x lte ArrayLen(settingArray); x=x+1){
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"CacheObjectDefaultTimeout") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.CacheObjectDefaultTimeout);
			}
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"CacheObjectDefaultLastAccessTimeout") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.CacheObjectDefaultLastAccessTimeout);
			}
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"CacheReapFrequency") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.CacheReapFrequency);
			}
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"CacheMaxObjects") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.CacheMaxObjects);
			}
			if ( Comparenocase(settingArray[x].xmlAttributes.name,"CacheFreeMemoryPercentageThreshold") eq 0){
				settingArray[x].xmlAttributes.value = trim(arguments.CacheFreeMemoryPercentageThreshold);
			}
		}
		saveSettings();
		</cfscript>
	</cffunction>

<!------------------------------------------- ACCESSORS/MUTATORS ------------------------------------------->

	<cffunction name="getcoldbox" access="public" output="false" returntype="any" hint="Get coldbox">
		<cfreturn instance.coldbox/>
	</cffunction>

	<cffunction name="setcoldbox" access="public" output="false" returntype="void" hint="Set coldbox">
		<cfargument name="coldbox" type="any" required="true"/>
		<cfset instance.coldbox = arguments.coldbox/>
	</cffunction>

	<cffunction name="getSettings" access="public" returntype="query" output="false">
		<cfreturn instance.qSettings>
	</cffunction>

	<cffunction name="getConventions" access="public" output="false" returntype="struct" hint="Get Conventions">
		<cfreturn instance.Conventions/>
	</cffunction>
	
<!------------------------------------------- PRIVATE ------------------------------------------->

	<!--- ************************************************************* --->

	<cffunction name="parseSettings" access="private" returntype="void" output="false">
		<cfset var xmlString = "">
		<cfset var xmlSettings = ArrayNew(1)>
		<cfset var xmlConventions = ArrayNew(1)>
		<cfset var x = 1>

		<cflock type="exclusive" name="fwSettingsOperation" timeout="120">
			<!--- Read File --->
			<cffile action="read" file="#instance.settingsFilePath#" variable="xmlString">
		</cflock>

		<!--- Parse File --->
		<cfset instance.xmlObj = XMLParse(trim(xmlString))>
		<!--- Get XML NODES --->
		<cfset xmlSettings = instance.xmlObj.xmlRoot.Settings.xmlChildren>
		<cfset xmlConventions = instance.xmlObj.xmlRoot.Conventions>

		<!--- Create Conventions Struct --->
		<cfset structInsert(getConventions(),"configLocation",xmlConventions[1].configLocation.xmlText)>
		<cfset structInsert(getConventions(),"handlerLocation",xmlConventions[1].handlerLocation.xmlText)>
		<cfset structInsert(getConventions(),"layoutsLocation",xmlConventions[1].layoutsLocation.xmlText)>
		<cfset structInsert(getConventions(),"viewsLocation",xmlConventions[1].viewsLocation.xmlText)>

		<!--- Create Query --->
		<cfscript>
			QueryAddRow(instance.qSettings,1);
			for (x=1; x lte ArrayLen(xmlSettings); x=x+1){
				QueryAddColumn(instance.qSettings, trim(xmlSettings[x].xmlAttributes.name), "varchar" , ArrayNew(1));
				QuerySetCell(instance.qSettings, trim(xmlSettings[x].xmlAttributes.name), trim(xmlSettings[x].xmlAttributes.value),1);
			}
		</cfscript>
	</cffunction>

	<!--- ************************************************************* --->

	<cffunction name="saveSettings" access="private" returntype="void" output="false">
		<cflock type="exclusive" name="fwSettingsOperation" timeout="120">
			<cffile action="write" file="#instance.settingsFilePath#" output="#toString(instance.xmlObj)#">
		</cflock>
	</cffunction>

	<!--- ************************************************************* --->

</cfcomponent>