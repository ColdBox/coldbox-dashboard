<cfcomponent hint="A conventions bean" output="false">

	<cffunction name="init" access="public" output="false" returntype="conventionsBean">
		<cfscript>
		instance = structnew();
		instance.configLocation = "";
		instance.handlerLocation = "";
		instance.layoutsLocation = "";
		instance.viewsLocation = "";
		return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="getConfigLocation" access="public" output="false" returntype="string">
		<cfreturn instance.configLocation />
	</cffunction>

	<cffunction name="setConfigLocation" access="public" output="false" returntype="void">
		<cfargument name="configLocation" type="string" required="true" />
		<cfset instance.configLocation = arguments.configLocation />
	</cffunction>

	<cffunction name="getHandlerLocation" access="public" output="false" returntype="string">
		<cfreturn instance.handlerLocation />
	</cffunction>

	<cffunction name="setHandlerLocation" access="public" output="false" returntype="void">
		<cfargument name="handlerLocation" type="any" required="true" />
		<cfset instance.handlerLocation = arguments.handlerLocation />
	</cffunction>

	<cffunction name="getLayoutsLocation" access="public" output="false" returntype="string">
		<cfreturn instance.layoutsLocation />
	</cffunction>

	<cffunction name="setLayoutsLocation" access="public" output="false" returntype="void">
		<cfargument name="layoutsLocation" type="any" required="true" />
		<cfset instance.layoutsLocation = arguments.layoutsLocation />
	</cffunction>

	<cffunction name="getViewsLocation" access="public" output="false" returntype="string">
		<cfreturn instance.viewsLocation />
	</cffunction>

	<cffunction name="setViewsLocation" access="public" output="false" returntype="void">
		<cfargument name="viewsLocation" type="string" required="true" />
		<cfset instance.viewsLocation = arguments.viewsLocation />
	</cffunction>
	
	<cffunction name="validate" access="public" returntype="boolean" hint="Validates its contents." output="false" >
		<cfscript>
		var key = "";
		var validate = true;
		//Loop and verify
		for ( key in instance ){
			if ( len(trim(instance[key])) eq 0 ){
				validate = false;
				break;
			}
		}
		//return validation.
		return validate;
		</cfscript>
	</cffunction>
	
</cfcomponent>