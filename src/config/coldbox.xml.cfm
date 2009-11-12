<?xml version="1.0" encoding="ISO-8859-1"?>
<Config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:noNamespaceSchemaLocation="http://www.coldboxframework.com/schema/config_3.0.0.xsd">
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
		<Setting name="Version" 				value="2.2.5 Beta"/>
		<!-- Special Links -->
		<Setting name="TracSite"				value="http://ortus.svnrepository.com/coldbox/" />
		<Setting name="OfficialSite"			value="http://www.coldbox.org" />
		<Setting name="SchemaDocs" 				value="${OfficialSite}/documents/SchemaDocs"/>
		
		<!-- Where ColdBox Framework is installed, or which one you would like to manage -->
		<Setting name="Coldbox_Location" 		value="/coldbox/system"/>
		<Setting name="ColdboxSamples_Location" value="/coldbox/samples"/>
		
		<!-- Location of your CFML Engine Administrator -->
		<Setting name="AdobeAdmin" 				value="/CFIDE/administrator/login.cfm"/>
		<Setting name="BlueDragonAdmin" 		value="/bluedragon"/>
		<Setting name="RailoAdmin" 				value="/railo-context/admin/index.cfm"/>
	</YourSettings>
	
	<!-- 
		ColdBox Logging via LogBox
		Levels: -1=OFF,0=FATAL,1=ERROR,2=WARN,3=INFO,4=DEBUG
	-->
	<LogBox>
		<Appender name="coldboxTracer" class="coldbox.system.logging.appenders.ColdboxTracerAppender" />
		<!-- Log to ColdBox File
		<Appender name="fileLog" class="coldbox.system.logging.appenders.AsyncRollingFileAppender">
			<Property name="filePath">logs</Property>
			<Property name="fileName">${AppName}</Property>
		</Appender> -->
		<!-- Root Logger Definition -->
		<Root levelMin="FATAL" levelMax="INFO" appenders="*" />
		<!-- ColdBox Package Logging -->
		<Category name="coldbox.system" levelMax="INFO" />
	</LogBox>
	
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
