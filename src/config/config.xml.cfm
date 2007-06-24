<?xml version="1.0" encoding="ISO-8859-1"?>
<Config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:noNamespaceSchemaLocation="http://www.coldboxframework.com/schema/config_2.0.2.xsd">
	<Settings>
		<Setting name="AppName" 					value="ColdboxDashboard"/>
		<Setting name="DebugMode"					value="false"/>
		<Setting name="DebugPassword"				value="coldbox"/>
		<Setting name="ReinitPassword" 				value="coldbox"/>
		<Setting name="EventName"					value="event" />
		<Setting name="EnableDumpVar" 				value="false"/>
		<Setting name="EnableColdfusionLogging" 	value="false"/>
		<Setting name="EnableColdboxLogging" 		value="true"/>
		<Setting name="ColdboxLogsLocation" 		value="logs"/>
		<Setting name="DefaultEvent" 				value="main.dspFrameset"/>
		<Setting name="RequestStartHandler" 		value="main.onRequestStart"/>
		<Setting name="RequestEndHandler" 			value=""/>
		<Setting name="ApplicationStartHandler" 	value="main.onAppStart"/>
		<Setting name="OwnerEmail" 					value="myemail@email.com"/>
		<Setting name="EnableBugReports" 			value="false"/>
		<Setting name="UDFLibraryFile" 				value="" />		
		<Setting name="CustomErrorTemplate"			value="" />
		<Setting name="MessageboxStyleClass"	    value="" />
		<Setting name="HandlersIndexAutoReload"   	value="false" />
		<Setting name="ConfigAutoReload"			value="false" />
		<Setting name="ExceptionHandler"     		value="" />
		<Setting name="HandlerCaching" 				value="true"/>
		<Setting name="onInvalidEvent"				value="main.dspFrameset" />
	</Settings>
	
	<YourSettings>
		<Setting name="Version" 				value="2.2.0"/>
		<Setting name="TracSite"				value="http://ortus.svnrepository.com/coldbox/" />
		<Setting name="OfficialSite"			value="http://www.coldboxframework.com" />
		<Setting name="SchemaDocs" 				value="http://www.coldboxframework.com/documents/SchemaDocs/"/>
		<Setting name="Coldbox_Location" 		value="/coldbox/system"/>
		<Setting name="ColdboxSamples_Location" value="/coldbox/samples"/>
		<Setting name="admin.adobe"	 			value="/CFIDE/administrator/login.cfm"/>
		<Setting name="admin.bluedragon" 		value="/bluedragon"/>
		<Setting name="admin.railo" 			value="/railo-context/admin/index.cfm"/>
	</YourSettings>
	
	<!--Optional,if blank it will use the CFMX administrator settings.-->
	<MailServerSettings>
		<MailServer />
		<MailUsername/>
		<MailPassword/>
	</MailServerSettings>
	
	<BugTracerReports>
		<!--<BugEmail>email@domain.com</BugEmail>-->
	</BugTracerReports>
	
	<DevEnvironments>
		<url>localhost</url>
		<url>jfetmac</url>
	</DevEnvironments>
		
	<Layouts>
		<DefaultLayout>Layout.simple.cfm</DefaultLayout>
		<Layout file="Layout.Login.cfm" name="login">
			<View>vwLogin</View>
		</Layout>
		<Layout file="Layout.Main.cfm" name="simple">
			<View>home/gateway</View>
			<View>settings/gateway</View>
			<View>bugs/gateway</View>
			<View>tools/gateway</View>
			<View>update/gateway</View>
		</Layout>
	</Layouts>
	
</Config>
