<?xml version="1.0" encoding="utf-8"?>
<Config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:noNamespaceSchemaLocation="http://www.coldboxframework.com/schema/config_3.0.0.xsd">
	<Settings>
		<!--The name of your application.-->
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

	<YourSettings>
		@SIDEBAR_SETTING@
	</YourSettings>
	
	<!--Declare Layouts for your application here-->
	<Layouts>
		<!--Declare the default layout, MANDATORY-->
		<DefaultLayout>Layout.Main.cfm</DefaultLayout>
	</Layouts>

	<Interceptors>
		<!-- USE ENVIRONMENT CONTROL -->
		<Interceptor class="coldbox.system.interceptors.environmentControl">
			<Property name='configFile'>config/environments.xml.cfm</Property>
		</Interceptor>
		<!-- USE AUTOWIRING -->
		<Interceptor class="coldbox.system.interceptors.autowire" />
		<!-- USE SES -->
		<Interceptor class="coldbox.system.interceptors.ses">
			<Property name="configFile">config/routes.cfm</Property>
		</Interceptor>
		@SIDEBAR_INTERCEPTOR@
	</Interceptors>
	
</Config>
