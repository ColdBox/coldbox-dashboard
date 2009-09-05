<?xml version="1.0" encoding="UTF-8"?>
<!-- 
For all possible configuration options please refer to the documentation:
http://ortus.svnrepository.com/coldbox/trac.cgi/wiki/cbConfigGuide
 -->
<Config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:noNamespaceSchemaLocation="http://www.coldbox.org/schema/config_3.0.0.xsd">
	<Settings>
		
		<!-- Application Setup-->
		<Setting name="AppName"						value="@APPNAME@"/>
		<!-- If you are using a coldbox app to power flex/remote apps, you NEED to set the AppMapping also. In Summary,
			 the AppMapping is either a CF mapping or the path from the webroot to this application root. If this setting
			 is not set, then coldbox will try to auto-calculate it for you. Please read the docs.
		<Setting name="AppMapping"					value="/MyApp"/> -->
		<Setting name="EventName"					value="@EVENT_NAME@" />
		
		<!-- Development Settings -->
		<Setting name="DebugMode" 					value="@DEBUG_MODE@"/>
		<Setting name="DebugPassword" 				value=""/>
		<Setting name="ReinitPassword" 				value=""/>
		<Setting name="HandlersIndexAutoReload" 	value="@HANDLER_AUTO_RELOAD@"/>
		<Setting name="ConfigAutoReload" 			value="@CONFIG_AUTO_RELOAD@"/>
		
		<!-- Implicit Events -->
		<Setting name="DefaultEvent" 				value="General.index"/>
		<Setting name="RequestStartHandler" 		value="Main.onRequestStart"/>
		<Setting name="RequestEndHandler" 			value=""/>
		<Setting name="ApplicationStartHandler" 	value="Main.onAppInit"/>
		<Setting name="SessionStartHandler" 		value=""/>
		<Setting name="SessionEndHandler" 			value=""/>
		<Setting name="MissingTemplateHandler"		value=""/>
		
		<!-- Extension Points -->
		<Setting name="UDFLibraryFile" 				value="includes/helpers/ApplicationHelper.cfm" />
		<Setting name="PluginsExternalLocation"   	value="" />
		<Setting name="ViewsExternalLocation" 		value=""/>
		<Setting name="LayoutsExternalLocation"   	value="" />
		<Setting name="HandlersExternalLocation"   	value="" />
		<Setting name="RequestContextDecorator" 	value=""/>
		
		<!-- Error/Exception Handling -->
		<Setting name="ExceptionHandler" 			value="@EXCEPTION_HANDLER@"/>
		<Setting name="onInvalidEvent" 				value=""/>
		<Setting name="CustomErrorTemplate"			value="@CUSTOM_ERROR_TEMPLATE@" />
		
		<!-- Application Aspects -->
		<Setting name="HandlerCaching" 				value="false"/>
		<Setting name="EventCaching" 				value="false"/>
		<Setting name="MessageboxStyleOverride"		value="false" />
		<Setting name="ProxyReturnCollection" 		value="false"/>
		<Setting name="FlashURLPersistScope" 		value="session"/>
	</Settings>
	
	<!-- Complex Settings follow JSON Syntax. www.json.org.  
		 *IMPORTANT: use single quotes in this xml file for JSON notation, ColdBox will translate it to double quotes.
	 -->
	<YourSettings>
		<!-- @YOURSETTINGS@ -->
	</YourSettings>
	
	<!--Model Integration -->
	<Models>
		<DefinitionFile>config/ModelMappings.cfm</DefinitionFile>
		<!--
		<SetterInjection>false</SetterInjection>
		<ObjectCaching>true</ObjectCaching>
		<ExternalLocation></ExternalLocation>
		<DICompleteUDF>onDIComplete</DICompleteUDF>
		<StopRecursion></StopRecursion>		
		<ParentFactory type="coldspring or lightwire">definition file</ParentFactory>
		-->
	</Models>
	
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
	</LogBox>
	
	<Layouts>
		<!--Declare the default layout, MANDATORY-->
		<DefaultLayout>Layout.Main.cfm</DefaultLayout>
		<!--
		Declare other layouts, with view/folder assignments if needed, else do not write them
		<Layout file="Layout.Popup.cfm" name="popup">
			<View>vwTest</View>
			<View>vwMyView</View>
			<Folder>tags</Folder>
		</Layout>
		-->
	</Layouts>

	<Interceptors>
		<!-- USE ENVIRONMENT CONTROL -->
		<Interceptor class="coldbox.system.interceptors.EnvironmentControl">
			<Property name='configFile'>config/environments.xml.cfm</Property>
		</Interceptor>
		<!-- USE AUTOWIRING -->
		<Interceptor class="coldbox.system.interceptors.Autowire" />
		<!-- USE SES -->
		<Interceptor class="coldbox.system.interceptors.SES">
			<Property name="configFile">config/Routes.cfm</Property>
		</Interceptor>		
		<!-- @SIDEBAR@ -->
	</Interceptors>
	
	<i18N>
		<!--Default Resource Bundle without locale and properties extension-->
		<!--<DefaultResourceBundle>includes/main</DefaultResourceBundle>-->
		<!--Java Standard Locale-->
		<!--<DefaultLocale>en_US</DefaultLocale>-->
		<!--session or client-->
		<!--<LocaleStorage>session</LocaleStorage>-->
		<!--<UknownTranslation>nothing</UknownTranslation>-->
	</i18N>
	
	<!-- Datasource Settings 
		<Datasources>
			<Datasource alias="MyDSNAlias" name="real_dsn_name"   dbtype="mysql"  username="" password="" />
		</Datasources>
	-->
	
	<!--IOC Integration
		<IOC>
			<Framework type="coldspring or lightwire" reload="true or false" objectCaching="true or false">definition file</Framework>
			<ParentFactory type="coldspring or lightwire>definition file</ParentFactory>
		</IOC>	
	-->
	
	<!-- Cache Settings 
	<Cache>
		<ObjectDefaultTimeout>60</ObjectDefaultTimeout>
		<ObjectDefaultLastAccessTimeout>30</ObjectDefaultLastAccessTimeout>
		<UseLastAccessTimeouts>true</UseLastAccessTimeouts>
		<ReapFrequency>1</ReapFrequency>
		<MaxObjects>100</MaxObjects>
		<FreeMemoryPercentageThreshold>0</FreeMemoryPercentageThreshold>
		<EvictionPolicy>LRU</EvictionPolicy>
	</Cache>
	-->
	
	<!-- Debugger Settings
	<DebuggerSettings>
		<EnableDumpVar>true</EnableDumpVar>
		<PersistentRequestProfiler>true</PersistentRequestProfiler>
		<maxPersistentRequestProfilers>10</maxPersistentRequestProfilers>
		<maxRCPanelQueryRows>50</maxRCPanelQueryRows>
		<TracerPanel 	show="true" expanded="true" />
		<InfoPanel 		show="true" expanded="true" />
		<CachePanel 	show="true" expanded="false" />
		<RCPanel		show="true" expanded="false" />
	</DebuggerSettings>	
	
	-->
	
	<!-- Mail Server Settings 
	<MailServerSettings>
		<MailServer></MailServer>
		<MailPort></MailPort>
		<MailUsername></MailUsername>
		<MailPassword></MailPassword>
	</MailServerSettings>
	-->

	<!-- Bug reporting aspect 
	<BugTracerReports enabled="false">
		<MailFrom>myemail@gmail.com</MailFrom>
		<CustomEmailBugReport>a custom bug report template</CustomEmailBugReport>
		<BugEmail>myemail@gmail.com</BugEmail> 
	</BugTracerReports>
	-->
	
	<!-- Web Services 
	<WebServices>
		<WebService name="TESTWS1" URL="http://www.test.com/test1.cfc?wsdl" />
	</WebServices>
	-->
	
</Config>