<cfcomponent hint="A generator bean." output="false">

	<cffunction name="init" access="public" returntype="generatorBean" hint="Constructor" output="false" >
		<cfscript>
		instance = structnew();
		instance.appname = "";
		instance.applocation = "";
		instance.owneremail = "";
		instance.configautoreload = true;
		instance.handlersindexautoreload = true;
		instance.devurls = "";
		instance.coldboxlogging = true;
		instance.coldboxlogslocation = "";
		instance.coldfusionlogging = false;
		instance.enablebugreports = false;
		instance.bugemails = "";
		instance.custom_error_template = false;
		instance.exception_handler = false;
		instance.eventname = "";
		instance.defaultview = false;
		instance.unittesting_framework = "mxunit";
		//return
		return this;
		</cfscript>
	</cffunction>

	<cffunction name="getMemento" access="public" output="false" returntype="struct" hint="Get Memento">
		<cfreturn instance/>
	</cffunction>

	<cffunction name="setMemento" access="public" output="false" returntype="void" hint="Set Memento">
		<cfargument name="Memento" type="struct" required="true"/>
		<cfset instance = arguments.Memento/>
	</cffunction>

	<cffunction name="getappname" access="public" output="false" returntype="string" hint="Get appname">
		<cfreturn instance.appname/>
	</cffunction>

	<cffunction name="setappname" access="public" output="false" returntype="void" hint="Set appname">
		<cfargument name="appname" type="string" required="true"/>
		<cfset instance.appname = arguments.appname/>
	</cffunction>

	<cffunction name="getapplocation" access="public" output="false" returntype="string" hint="Get applocation">
		<cfreturn instance.applocation/>
	</cffunction>

	<cffunction name="setapplocation" access="public" output="false" returntype="void" hint="Set applocation">
		<cfargument name="applocation" type="string" required="true"/>
		<cfset instance.applocation = arguments.applocation/>
	</cffunction>

	<cffunction name="getowneremail" access="public" output="false" returntype="string" hint="Get owneremail">
		<cfreturn instance.owneremail/>
	</cffunction>

	<cffunction name="setowneremail" access="public" output="false" returntype="void" hint="Set owneremail">
		<cfargument name="owneremail" type="string" required="true"/>
		<cfset instance.owneremail = arguments.owneremail/>
	</cffunction>

	<cffunction name="getconfigautoreload" access="public" output="false" returntype="boolean" hint="Get configautoreload">
		<cfreturn instance.configautoreload/>
	</cffunction>

	<cffunction name="setconfigautoreload" access="public" output="false" returntype="void" hint="Set configautoreload">
		<cfargument name="configautoreload" type="boolean" required="true"/>
		<cfset instance.configautoreload = arguments.configautoreload/>
	</cffunction>

	<cffunction name="gethandlersindexautoreload" access="public" output="false" returntype="boolean" hint="Get handlersindexautoreload">
		<cfreturn instance.handlersindexautoreload/>
	</cffunction>

	<cffunction name="sethandlersindexautoreload" access="public" output="false" returntype="void" hint="Set handlersindexautoreload">
		<cfargument name="handlersindexautoreload" type="boolean" required="true"/>
		<cfset instance.handlersindexautoreload = arguments.handlersindexautoreload/>
	</cffunction>

	<cffunction name="getdevurls" access="public" output="false" returntype="string" hint="Get devurls">
		<cfreturn instance.devurls/>
	</cffunction>

	<cffunction name="setdevurls" access="public" output="false" returntype="void" hint="Set devurls">
		<cfargument name="devurls" type="string" required="true"/>
		<cfset instance.devurls = arguments.devurls/>
	</cffunction>

	<cffunction name="getcoldboxlogging" access="public" output="false" returntype="boolean" hint="Get coldboxlogging">
		<cfreturn instance.coldboxlogging/>
	</cffunction>

	<cffunction name="setcoldboxlogging" access="public" output="false" returntype="void" hint="Set coldboxlogging">
		<cfargument name="coldboxlogging" type="boolean" required="true"/>
		<cfset instance.coldboxlogging = arguments.coldboxlogging/>
	</cffunction>

	<cffunction name="getcoldboxlogslocation" access="public" output="false" returntype="string" hint="Get coldboxlogslocation">
		<cfreturn instance.coldboxlogslocation/>
	</cffunction>

	<cffunction name="setcoldboxlogslocation" access="public" output="false" returntype="void" hint="Set coldboxlogslocation">
		<cfargument name="coldboxlogslocation" type="string" required="true"/>
		<cfset instance.coldboxlogslocation = arguments.coldboxlogslocation/>
	</cffunction>

	<cffunction name="getcoldfusionlogging" access="public" output="false" returntype="boolean" hint="Get coldfusionlogging">
		<cfreturn instance.coldfusionlogging/>
	</cffunction>

	<cffunction name="setcoldfusionlogging" access="public" output="false" returntype="void" hint="Set coldfusionlogging">
		<cfargument name="coldfusionlogging" type="boolean" required="true"/>
		<cfset instance.coldfusionlogging = arguments.coldfusionlogging/>
	</cffunction>

	<cffunction name="getenablebugreports" access="public" output="false" returntype="boolean" hint="Get enablebugreports">
		<cfreturn instance.enablebugreports/>
	</cffunction>

	<cffunction name="setenablebugreports" access="public" output="false" returntype="void" hint="Set enablebugreports">
		<cfargument name="enablebugreports" type="boolean" required="true"/>
		<cfset instance.enablebugreports = arguments.enablebugreports/>
	</cffunction>

	<cffunction name="getbugemails" access="public" output="false" returntype="string" hint="Get bugemails">
		<cfreturn instance.bugemails/>
	</cffunction>

	<cffunction name="setbugemails" access="public" output="false" returntype="void" hint="Set bugemails">
		<cfargument name="bugemails" type="string" required="true"/>
		<cfset instance.bugemails = arguments.bugemails/>
	</cffunction>

	<cffunction name="getcustom_error_template" access="public" returntype="boolean" output="false">
			<cfreturn instance.custom_error_template>
	</cffunction>

	<cffunction name="setcustom_error_template" access="public" returntype="void" output="false">
		<cfargument name="custom_error_template" type="boolean" required="true">
		<cfset instance.custom_error_template = arguments.custom_error_template>
	</cffunction>

	<cffunction name="getexception_handler" access="public" returntype="boolean" output="false">
			<cfreturn instance.exception_handler>
	</cffunction>

	<cffunction name="setexception_handler" access="public" returntype="void" output="false">
		<cfargument name="exception_handler" type="boolean" required="true">
		<cfset instance.exception_handler = arguments.exception_handler>
	</cffunction>
	
	<cffunction name="geteventname" access="public" returntype="string" output="false">
		<cfreturn instance.eventname>
	</cffunction>
	
	<cffunction name="seteventname" access="public" returntype="void" output="false">
		<cfargument name="eventname" type="string" required="true">
		<cfset instance.eventname = arguments.eventname>
	</cffunction>
	
	<cffunction name="getdefaultView" access="public" output="false" returntype="string" hint="Get defaultView">
		<cfreturn instance.defaultView/>
	</cffunction>
	
	<cffunction name="setdefaultView" access="public" output="false" returntype="void" hint="Set defaultView">
		<cfargument name="defaultView" type="string" required="true"/>
		<cfset instance.defaultView = arguments.defaultView/>
	</cffunction>

	<cffunction name="getunittesting_framework" access="public" output="false" returntype="string" hint="Get unittesting_framework">
		<cfreturn instance.unittesting_framework/>
	</cffunction>
	
	<cffunction name="setunittesting_framework" access="public" output="false" returntype="void" hint="Set unittesting_framework">
		<cfargument name="unittesting_framework" type="string" required="true"/>
		<cfset instance.unittesting_framework = arguments.unittesting_framework/>
	</cffunction>

</cfcomponent>