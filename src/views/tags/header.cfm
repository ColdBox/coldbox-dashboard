<cfoutput>
<div class="logo"></div>

<div class="headerbar">
	
	<div style="float:right;clear:both;margin-right:10px">
		<!--- HOME --->
		<div id="topbuttons" >
			<a href="?event=#Event.getValue("xehHome")#" target="mainframe" onmouseover="rollover('btn_home')" onmouseout="rollout('btn_home')"><img  src="images/icons/home.gif" border="0" id="btn_home" srcoff="images/icons/home.gif" srcon="images/icons/home_on.gif"><br>
			Home</a>
		</div>
		<!--- SETTINGS --->
		<div id="topbuttons" >
			<a href="?event=#Event.getValue("xehSettings")#" target="mainframe" onmouseover="rollover('btn_settings')" onmouseout="rollout('btn_settings')"><img  src="images/icons/settings.gif" border="0" id="btn_settings" srcoff="images/icons/settings.gif" srcon="images/icons/settings_on.gif"><br>
			Settings</a>
		</div>
		<!--- TOOLS--->
		<div id="topbuttons" >
			<a href="?event=#Event.getValue("xehTools")#" target="mainframe" onmouseover="rollover('btn_tools')" onmouseout="rollout('btn_tools')"><img  src="images/icons/tools.gif" border="0" id="btn_tools" srcoff="images/icons/tools.gif" srcon="images/icons/tools_on.gif"><br>
			Tools</a>
		</div>
		<!--- CFADMIN --->
		<cfif getColdboxOCM().get("cfserver") eq "adobe">
		<div id="topbuttons" >
			<a href="#getSetting("admin.adobe")#" target="_blank" onmouseover="rollover('btn_cfadmin')" onmouseout="rollout('btn_cfadmin')"><img  src="images/icons/cfadmin.gif" border="0" id="btn_cfadmin" srcoff="images/icons/cfadmin.gif" srcon="images/icons/cfadmin_on.gif"><br>
			CF Admin</a>
		</div>
		<cfelseif getColdboxOCM().get("cfServer") eq "bluedragon">
		<div id="topbuttons" >
			<a href="#getSetting("admin.bluedragon")#" target="mainframe" onmouseover="rollover('btn_bd')" onmouseout="rollout('btn_bd')"><img  src="images/icons/bluedragon.gif" border="0" id="btn_bd" srcoff="images/icons/bluedragon.gif" srcon="images/icons/bluedragon_on.gif"><br>
			BlueDragon</a>
		</div>
		<cfelseif getColdboxOCM().get("cfServer") eq "railo">
		<div id="topbuttons" >
			<a href="#getSetting("admin.railo")#" target="mainframe" onmouseover="rollover('btn_bd')" onmouseout="rollout('btn_bd')"><img  src="images/icons/railo_27.gif" border="0" id="btn_bd" srcoff="images/icons/railo_27.gif" srcon="images/icons/railo_on.gif"><br>
			Admin</a>
		</div>
		</cfif>
		<!--- UPDATE --->
		<div id="topbuttons">
			<a href="?event=#Event.getValue("xehUpdate")#" target="mainframe" onmouseover="rollover('btn_update')" onmouseout="rollout('btn_update')"><img  src="images/icons/update.gif" border="0" id="btn_update" srcoff="images/icons/update.gif" srcon="images/icons/update_on.gif"><br>
			Update</a>
		</div>
		<!--- BUG REPORTS --->
		<div id="topbuttons">
			<a href="?event=#Event.getValue("xehBugs")#" target="mainframe" onmouseover="rollover('btn_bugs')" onmouseout="rollout('btn_bugs')"><img  src="images/icons/bugreports.gif" border="0" id="btn_bugs" srcoff="images/icons/bugreports.gif" srcon="images/icons/bugreports_on.gif"><br>
			Submit Bug</a>
		</div>
	</div>

</div>

<div class="statusbar">
	<form id="searchdocs" name="searchdocs" action="http://www.google.com/custom" method="get" target="mainframe">
		<input type="hidden" name="domains" value="ortus.svnrepository.com" />
		<input type="hidden" name="sitesearch" value="ortus.svnrepository.com/coldbox" />
		<input type="hidden" name="client" value="pub-0884459722343463"></input>
		<input type="hidden" name="forid" value="1"></input>
		<input type="hidden" name="channel" value="1066704285"></input>
		<input type="hidden" name="ie" value="ISO-8859-1"></input>
		<input type="hidden" name="oe" value="ISO-8859-1"></input>
		<input type="hidden" name="safe" value="active"></input>
		<input type="hidden" name="cof" value="GALT:##008000;GL:1;DIV:##336699;VLC:663399;AH:center;BGC:FFFFFF;LBGC:000000;ALC:0000FF;LC:0000FF;T:000000;GFNT:0000FF;GIMP:0000FF;LH:50;LW:217;L:http://www.coldboxframework.com/images/homepage_r2_c2.jpg;S:http://www.coldboxframework.com;FORID:1"></input>
		<input type="hidden" name="hl" value="en"></input>
		
		
	<div class="browserbuttonsbar">
		
		<cfif not findnocase("MSIE",cgi.HTTP_USER_AGENT)>
		<a href="javascript:parent.mainframe.history.back()" title="Go Back!" ><img src="images/icons/back_browser.gif" border="0" align="absmiddle" id="btn_browserback" srcoff="images/icons/back_browser.gif" srcon="images/icons/back_browser_on.gif" onMouseOver="rollover(this)" onMouseOut="rollout(this)"></a>
		<a href="javascript:parent.mainframe.history.forward()" title="Go Forward!"><img src="images/icons/forward_browser.gif" border="0" align="absmiddle" id="btn_browserforward" srcoff="images/icons/forward_browser.gif" srcon="images/icons/forward_browser_on.gif" onMouseOver="rollover(this)" onMouseOut="rollout(this)"></a>
		&nbsp;
		</cfif>
		
		<input type="text" name="q" size="20" accesskey="s" value="Search Docs" style="font-size:9px" onclick="(this.value=='Search Docs')?this.value='':null" title="Search the documentation, tickets and changeset" onBlur="(this.value=='')?this.value='Search Docs':null" />
		
		<a href="javascript:document.searchdocs.submit()" title="Search!"><img src="images/icons/search_icon.gif" align="absmiddle" border="0" alt="Search"></a>
	</div>

	<div id="myloader" style="display: none">
		<div class="myloader"><img src="images/ajax-loader.gif" width="220" height="19" align="absmiddle" title="Loading..." /></div>
	</div>
	</form>
</div>
</cfoutput>