<?xml version="1.0" encoding="ISO-8859-1"?>
<Config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:noNamespaceSchemaLocation="http://www.coldboxframework.com/schema/config_2.6.0.xsd">
	<Settings>
		<Setting name="AppName" 					value="ColdboxDashboard"/>
		<Setting name="ReinitPassword" 				value=""/>
		<Setting name="HandlersIndexAutoReload"   	value="false" />
		<Setting name="ConfigAutoReload"			value="false" />
		
		<!-- implicit events -->
		<Setting name="DefaultEvent" 				value="main.dspFrameset"/>
		<Setting name="RequestStartHandler" 		value="main.onRequestStart"/>
		<Setting name="ApplicationStartHandler" 	value="main.onAppStart"/>
		<Setting name="onInvalidEvent"				value="main.dspFrameset" />
		
		<!-- Extension Points -->
		<Setting name="UDFLibraryFile" 				value="includes/helpers/ApplicationHelper.cfm"/>
		<Setting name="HandlerCaching" 				value="true"/>
		<Setting name="EventCaching" 				value="true"/>
	</Settings>
	
	<YourSettings>
		<!-- Software Version DO NOT MODIFY -->
		<Setting name="Version" 				value="2.2.4"/>
		<!-- Special Links -->
		<Setting name="TracSite"				value="http://ortus.svnrepository.com/coldbox/" />
		<Setting name="OfficialSite"			value="http://www.coldboxframework.com" />
		<Setting name="SchemaDocs" 				value="${OfficialSite}/documents/SchemaDocs/"/>
		
		<!-- Where ColdBox Framework is installed, or which one you would like to manage -->
		<Setting name="Coldbox_Location" 		value="/coldbox/system"/>
		<Setting name="ColdboxSamples_Location" value="/coldbox/samples"/>
		
		<!-- Location of your CFML Engine Administrator -->
		<Setting name="AdobeAdmin" 				value="/CFIDE/administrator/login.cfm"/>
		<Setting name="BlueDragonAdmin" 		value="/bluedragon"/>
		<Setting name="RailoAdmin" 				value="/railo-context/admin/index.cfm"/>
	</YourSettings>
	
	<LogBox>
		<!-- Log to console -->
		<Appender name="console" class="coldbox.system.logging.appenders.ConsoleAppender" />
		<!-- Log to ColdBox Files -->
		<Appender name="coldboxfile" class="coldbox.system.logging.appenders.AsyncRollingFileAppender">
			<Property name="filePath">logs</Property>
			<Property name="fileName">${AppName}</Property>
			<Property name="autoExpand">true</Property>
			<Property name="fileMaxSize">2000</Property>
			<Property name="fileMaxArchives">2</Property>		
		</Appender>
		<!-- Root Logger Definition -->
		<Root levelMin="FATAL" levelMax="TRACE" appenders="*" />
		<!-- Category Definitions Below -->
	</LogBox>
	
	<!-- Custom Conventions for this application -->
	<Conventions>
		<handlersLocation>handlers</handlersLocation>
		<pluginsLocation>plugins</pluginsLocation>
		<layoutsLocation>layouts</layoutsLocation>
		<viewsLocation>views</viewsLocation>
		<eventAction>index</eventAction>		
	</Conventions>		
	
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
	
	<Interceptors>
		<Interceptor class="coldbox.system.interceptors.environmentControl">
			<Property name="configFile">config/environments.xml.cfm</Property>
		</Interceptor>	
		<Interceptor class="coldbox.system.interceptors.autowire" />			
	</Interceptors>		
		
</Config>
