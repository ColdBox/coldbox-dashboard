<!-----------------------------------------------------------------------
Author 	 :	Luis Majano
Date     :	September 25, 2005
Description :

	Unit test for the ehMain Handler.

----------------------------------------------------------------------->
<cfcomponent name="mainTest" extends="coldbox.system.testing.BaseTestCase" output="false">
	
	<cfscript>
		//Uncomment the following if you dont' need the controller in application scope for testing.
		//this.PERSIST_FRAMEWORK = false;
	</cfscript>
	
	<cffunction name="setup" returntype="void" output="false">
		<cfscript>
		//Setup ColdBox Mappings For this Test
		setAppMapping("/coldbox/ApplicationTemplate");
		setConfigMapping(ExpandPath(instance.AppMapping & "/config/coldbox.xml.cfm"));
		
		//Call the super setup method to setup the app.
		super.setup();
		
		//EXECUTE THE APPLICATION START HANDLER: UNCOMMENT IF NEEDED AND FILL IT OUT WITH THE CORRECT HANDLER
		//getController().runEvent("main.onAppInit");

		//EXECUTE THE ON REQUEST START HANDLER: UNCOMMENT IF NEEDED AND FILL IT OUT WITH THE CORRECT HANDLER
		//getController().runEvent("main.onRequestStart");
		</cfscript>
	</cffunction>
	
	<cffunction name="testonAppInit" returntype="void" output="false">
		<cfscript>
		var event = "";
		
		//Place any variables on the form or URL scope to test the handler.
		//FORM.name = "luis"
		event = execute("main.onAppInit");
			
		//Do your asserts below
				
		</cfscript>
	</cffunction>

	<cffunction name="testonRequestStart" returntype="void" output="false">
		<cfscript>
		var event = "";
		
		//Place any variables on the form or URL scope to test the handler.
		//FORM.name = "luis"
		event = execute("main.onRequestStart");
			
		//Do your asserts below
				
		</cfscript>
	</cffunction>

	<cffunction name="testonRequestEnd" returntype="void" output="false">
		<cfscript>
		var event = "";
		
		//Place any variables on the form or URL scope to test the handler.
		//FORM.name = "luis"
		event = execute("main.onRequestEnd");
			
		//Do your asserts below
			
		</cfscript>
	</cffunction>
	
	<cffunction name="testSessionStart" returntype="void" output="false">
		<cfscript>
		var event = "";
		
		//Place any variables on the form or URL scope to test the handler.
		//FORM.name = "luis"
		event = execute("main.onSessionStart");
			
		//Do your asserts below
			
		</cfscript>
	</cffunction>
	
	<cffunction name="testSessionEnd" returntype="void" output="false">
		<cfscript>
		var event = "";
		var sessionReference = "";
		
		//Place a fake session structure here, it mimics what the handler receives
		URL.sessionReference = structnew();
		URL.applicationReference = structnew();
		
		event = execute("main.onSessionEnd");
			
		//Do your asserts below
			
		</cfscript>
	</cffunction>

	<cffunction name="testonException" returntype="void" output="false">
		<cfscript>
		//You need to create an exception bean first and place it on the request context FIRST as a setup.
		var exceptionBean = CreateObject("component","coldbox.system.beans.ExceptionBean");
		var event = "";
		
		//Initialize an exception
		exceptionBean.init(erroStruct=structnew(), extramessage="My unit test exception", extraInfo="Any extra info, simple or complex");
		//Place it on form or url scope to attach it to request
		URL.exceptionBean = exceptionBean;
		
		//TEST EVENT EXECUTION
		event = execute("main.onException");
		
		//Do your asserts HERE

		</cfscript>
	</cffunction>


</cfcomponent>