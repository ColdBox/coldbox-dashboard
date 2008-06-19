<?xml version="1.0" encoding="ISO-8859-1"?>
<Config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:noNamespaceSchemaLocation="http://www.coldboxframework.com/schema/config_2.6.0.xsd">
	<Settings>
		<Setting name="AppName" 					value="ColdboxDashboard"/>
		<Setting name="DebugMode"					value="false"/>
		<Setting name="DebugPassword"				value=""/>
		<Setting name="ReinitPassword" 				value=""/>
		<Setting name="EventName"					value="event" />
		<Setting name="EnableDumpVar" 				value="false"/>
		<Setting name="EnableColdfusionLogging" 	value="false"/>
		<Setting name="EnableColdboxLogging" 		value="true"/>
		<Setting name="ColdboxLogsLocation" 		value="logs"/>
		<Setting name="DefaultEvent" 				value="main.dspFrameset"/>
		<Setting name="RequestStartHandler" 		value="main.onRequestStart"/>
		<Setting name="ApplicationStartHandler" 	value="main.onAppStart"/>
		<!-- Please fill your owner email here! -->
		<Setting name="OwnerEmail" 					value="myemail@email.com"/>
		<Setting name="EnableBugReports" 			value="false"/>
		<Setting name="MessageboxStyleOverride"	    value="false" />
		<Setting name="HandlersIndexAutoReload"   	value="false" />
		<Setting name="ConfigAutoReload"			value="false" />
		<Setting name="HandlerCaching" 				value="true"/>
		<Setting name="EventCaching" 				value="true"/>
		<Setting name="onInvalidEvent"				value="main.dspFrameset" />
	</Settings>
	
	<YourSettings>
		<!-- Software Version DO NOT MODIFY -->
		<Setting name="Version" 				value="2.2.3"/>
		<!-- Special Links -->
		<Setting name="TracSite"				value="http://ortus.svnrepository.com/coldbox/" />
		<Setting name="OfficialSite"			value="http://www.coldboxframework.com" />
		<Setting name="SchemaDocs" 				value="http://www.coldboxframework.com/documents/SchemaDocs/"/>
		<!-- Where ColdBox Framework is installed, or which one you would like to manage -->
		<Setting name="Coldbox_Location" 		value="/coldbox/system"/>
		<Setting name="ColdboxSamples_Location" value="/coldbox/samples"/>
		<!-- Location of your CFML Engine Administrator -->
		<Setting name="AdobeAdmin" 				value="/CFIDE/administrator/login.cfm"/>
		<Setting name="BlueDragonAdmin" 		value="/bluedragon"/>
		<Setting name="RailoAdmin" 				value="/railo-context/admin/index.cfm"/>
	</YourSettings>
	
	<!-- Custom Conventions for this application -->
	<Conventions>
		<handlersLocation>handlers</handlersLocation>
		<pluginsLocation>plugins</pluginsLocation>
		<layoutsLocation>layouts</layoutsLocation>
		<viewsLocation>views</viewsLocation>
		<eventAction>index</eventAction>		
	</Conventions>		
	
	<!--Optional,if blank it will use the CFMX administrator settings.-->
	<MailServerSettings>
		<MailServer />
		<MailUsername/>
		<MailPassword/>
	</MailServerSettings>
	
	<BugTracerReports>
		<!--<BugEmail>email@domain.com</BugEmail>-->
	</BugTracerReports>
	
	<DevEnvironments />
			
	<Layouts>
		<DefaultLayout>Layout.simple.cfm</DefaultLayout>
		<Layout file="Layout.Login.cfm" name="login">
			<View>vwLogin</View>
		</Layout>
		<Layout file="Layout.Main.cfm" name="main">
			<View>home/gateway</View>
			<View>settings/gateway</View>
			<View>bugs/gateway</View>
			<View>tools/gateway</View>
			<View>update/gateway</View>
		</Layout>
	</Layouts>
	
	<Cache>
		<ObjectDefaultTimeout>60</ObjectDefaultTimeout>
		<ObjectDefaultLastAccessTimeout>30</ObjectDefaultLastAccessTimeout>
		<UseLastAccessTimeouts>true</UseLastAccessTimeouts>
		<ReapFrequency>3</ReapFrequency>
		<MaxObjects>50</MaxObjects>
		<FreeMemoryPercentageThreshold>1</FreeMemoryPercentageThreshold>
		<EvictionPolicy>LRU</EvictionPolicy>
	</Cache>
	
	<Interceptors>
		<Interceptor class="coldbox.system.interceptors.environmentControl">
			<Property name="configFile">config/environments.xml.cfm</Property>
			<Property name="fireOnInit">true</Property>
		</Interceptor>		
	</Interceptors>		
		
</Config>
