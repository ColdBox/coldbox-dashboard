<cfoutput>
#renderView("tags/rollovers")#

<!--- Title Bar --->
<div class="sidemenu_title">
    <div class="sidemenu_title_img"  ><img src="images/icons/settings_27.gif"></div>
	<div class="sidemenu_title_text" >Settings</div>
</div>

<!--- Sub Menu Links --->
<ul>
	<li><a href="javascript:doEvent('#requestContext.getValue("xehSettings")#', 'content', {})" onMouseOver="getHint('frameworksettings')" onMouseOut="resetHint()">General Settings</a></li>
	
	<li><a href="javascript:doEvent('#requestContext.getValue("xehLogSettings")#', 'content', {})" onMouseOver="getHint('logfilesettings')" onMouseOut="resetHint()">Log File Settings</a></li>
	
	<li><a href="javascript:doEvent('#requestContext.getValue("xehEncodingSettings")#', 'content', {})" onMouseOver="getHint('encodingsettings')" onMouseOut="resetHint()">File Encoding Settings</a></li>
	
	<li><a href="javascript:doEvent('#requestContext.getValue("xehPassword")#', 'content', {})" onMouseOver="getHint('passwordsettings')" onMouseOut="resetHint()">Change Dashboard Password</a></li>
	
	<li><a href="javascript:doEvent('#requestContext.getValue("xehProxy")#', 'content', {})" onMouseOver="getHint('proxysettings')" onMouseOut="resetHint()">Proxy Settings</a></li>
</ul>

<script language="javascript">
//Populate system info
doEvent('#requestContext.getValue("xehSettings")#', 'content', {});
</script>
</cfoutput>