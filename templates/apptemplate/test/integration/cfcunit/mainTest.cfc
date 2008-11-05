<!-----------------------------------------------------------------------
Author 	 :	Luis Majano
Date     :	September 25, 2005
Description :

	Unit test for the ehMain Handler.

----------------------------------------------------------------------->
<cfcomponent name="mainTest" extends="coldbox.system.extras.testing.baseTest" output="false">

	<cfscript>
		//Uncomment the following if you dont' need the controller in application scope for testing.
		//this.PERSIST_FRAMEWORK = false;
	</cfscript>
	
	<cffunction name="setUp" returntype="void" access="public" output="false">
		<cfscript>
		//Setup ColdBox Mappings For this Test
		setAppMapping("@APP_MAPPING@");
		setConfigMapping(ExpandPath(instance.AppMapping & "/config/coldbox.xml.cfm"));
		
		//Call the super setup method to setup the app.
		super.setup();
		
		//EXECUTE THE APPLICATION START HANDLER: UNCOMMENT IF NEEDED AND FILL IT OUT.
		//getController().runEvent("main.onAppInit");

		//EXECUTE THE ON REQUEST START HANDLER: UNCOMMENT IF NEEDED AND FILL IT OUT
		//getController().runEvent("main.onRequestStart");
		</cfscript>
	</cffunction>
	
	<cffunction name="testonAppInit" access="public" returntype="void" output="false">
		<cfscript>
		var event = "";
		
		//Place any variables on the form or URL scope to test the handler.
		//FORM.name = "luis"
		event = execute("main.onAppInit");
			
		//Do your asserts below
				
		</cfscript>
	</cffunction>

	<cffunction name="testonRequestStart" access="public" returntype="void" output="false">
		<cfscript>
		var event = "";
		
		//Place any variables on the form or URL scope to test the handler.
		//FORM.name = "luis"
		event = execute("main.onRequestStart");
			
		//Do your asserts below
				
		</cfscript>
	</cffunction>

	<cffunction name="testonRequestEnd" access="public" returntype="void" output="false">
		<cfscript>
		var event = "";
		
		//Place any variables on the form or URL scope to test the handler.
		//FORM.name = "luis"
		event = execute("main.onRequestEnd");
			
		//Do your asserts below
			
		</cfscript>
	</cffunction>
	
	<cffunction name="testSessionStart" access="public" returntype="void" output="false">
		<cfscript>
		var event = "";
		
		//Place any variables on the form or URL scope to test the handler.
		//FORM.name = "luis"
		event = execute("main.onSessionStart");
			
		//Do your asserts below
			
		</cfscript>
	</cffunction>
	
	<cffunction name="testSessionEnd" access="public" returntype="void" output="false">
		<cfscript>
		var event = "";
		var sessionReference = "";
		
		//Place a fake session structure here, it mimics what the handler receives
		FORM.sessionReference = structnew();
		
		event = execute("main.onSessionEnd");
			
		//Do your asserts below
			
		</cfscript>
	</cffunction>
	
	<cffunction name="testonException" access="public" returntype="void" output="false">
		<cfscript>
		//You need to create an exception bean first and place it on the request context FIRST as a setup.
		var exceptionBean = CreateObject("component","coldbox.system.beans.exceptionBean");
		var event = "";
		
		//Initialize an exception
		exceptionBean.init(erroStruct=structnew(), extramessage="My unit test exception", extraInfo="Any extra info, simple or complex");
		//Place it on form or url scope to attach it to request
		FORM.exceptionBean = exceptionBean;
		
		//TEST EVENT EXECUTION
		event = execute("main.onException");
		
		//Do your asserts HERE

		</cfscript>
	</cffunction>


</cfcomponent>