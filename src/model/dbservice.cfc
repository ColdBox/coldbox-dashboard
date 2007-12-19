<cfcomponent output="false" displayname="dbservice" hint="I am the Main Dashboard Service.">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

	<cffunction name="init" access="public" returntype="dbservice" output="false">
		<cfargument name="coldbox" required="true" type="any" hint="The coldbox controller">
		<cfscript>
			instance = structnew();
			instance.coldbox = arguments.coldbox;

			//Create Services
			instance.settings = CreateObject("component","services.settings").init(coldbox);
			instance.fwsettings = CreateObject("component","services.fwsettings").init(coldbox);
			instance.generator = CreateObject("component","services.generator").init(coldbox);

			//Set generator dependency
			instance.generator.setapptemplatePath(expandPath('model/templates/apptemplate.zip'));

			//Bug Email address
			setBugEmail('bugs@coldboxframework.com');
			return this;
		</cfscript>
	</cffunction>

<!------------------------------------------- PUBLIC ------------------------------------------->

	<cffunction name="getService" access="public" returntype="any" output="false">
		<cfargument name="model" required="true" type="string" >
		<cfreturn instance["#arguments.model#"]>
	</cffunction>

	<cffunction name="getBean" access="public" returntype="any" output="false" hint="The domain objects factory">
		<cfargument name="bean" required="true" type="string" hint="the name of the domain objects to create.">
		<cfscript>
		var oBean = "";

		//Case
		switch (arguments.bean){

			case "conventions":
				oBean =  CreateObject("component","beans.conventionsBean").init();
				break;
			case "generatorbean":
				oBean =  CreateObject("component","beans.generatorBean").init();
				break;
		}

		//return bean
		return oBean;
		</cfscript>
	</cffunction>

	<cffunction name="sendbugreport" access="public" returntype="void" output="false">
		<cfargument name="requestCollection" required="true" type="any" >
		<cfargument name="fwSettings"		 required="true" type="any">
		<cfargument name="OS" 				 required="true" type="string">
		<!--- Send Bug Report. --->
		<cfset var myBugreport = "">
		<!--- Save the Report --->
		<cfsavecontent variable="mybugreport">
		<cfoutput>
		=========================================================
		BUG DETAILS
		=========================================================
		Date: #dateFormat(now(),"mmmm dd, YYYY")#
		Time: #TimeFormat(now(), "long")#
		From: #arguments.requestCollection.name#
		=========================================================
		BUG REPORT
		=========================================================
		#arguments.requestCollection.bugreport#
		=========================================================
		COLDBOX DETAILS
		=========================================================
		Version:    #arguments.fwSettings.version#
		Codename:   #arguments.fwSettings.codename#
		Suffix:     #arguments.fwSettings.suffix#
		O.S:        #arguments.OS#
		CF Engine:  #server.ColdFusion.ProductName#
		CF Version: #server.ColdFusion.ProductVersion#
		=========================================================
		</cfoutput>
		</cfsavecontent>
		<!--- Send the bug report --->
		<cfmail to="#getBugEmail()#"
				from="#arguments.requestCollection.email#"
				subject="Bug Report">
		#mybugreport#
		</cfmail>
	</cffunction>

<!------------------------------------------- PRIVATE ------------------------------------------->

	<cffunction name="getbugEmail" access="public" output="false" returntype="string" hint="Get bugEmail">
		<cfreturn instance.bugEmail/>
	</cffunction>

	<cffunction name="setbugEmail" access="public" output="false" returntype="void" hint="Set bugEmail">
		<cfargument name="bugEmail" type="string" required="true"/>
		<cfset instance.bugEmail = arguments.bugEmail/>
	</cffunction>

</cfcomponent>