<cfoutput>
<cfset rc = event.getCollection()>
<!--- HELPBOX --->
#renderView("tags/help")#

<form name="updateform" id="udpateform" action="javascript:doFormEvent('#Event.getValue("xehDoSave")#','content',document.updateform)" onSubmit="return confirmit()" method="post">
<div class="maincontentbox">

	<div class="contentboxes_header">
		<div class="contentboxes_title"><img src="images/icons/settings_27.gif" align="absmiddle" />&nbsp; Framework Conventions</div>
	</div>

	<!--- Messagebox --->
	#getPlugin("messagebox").renderit()#
	<div class="contentboxes">

	<p>
		Below you can fill out the framework conventions for the key pieces in a ColdBox Application. <br />
		<strong>IMPORTANT: IF YOU CHANGE THESE SETTINGS, YOUR APPLICATION(S) WILL FAIL UNTIL YOU RENAME THE DIRECTORIES AND FILES AS YOU DID BELOW</strong>
	</p>
	
	<br />
		
	<div style="margin: 5px">
    <table width="100%" border="0" cellspacing="0" cellpadding="5" class="tablelisting">
		<tr>
			<th>Setting</th>
			<th>Value</th>
		</tr>

	     <tr>
	     	<td align="right" width="40%" style="border-right:1px solid ##ddd">
	     	<strong>Config Location</strong>
	     	</td>
	     	<td>
	     	<input type="text" name="configLocation" value="#rc.Conventions.configLocation#" size="30">
	     	</td>
	     </tr>
	
	     <tr bgcolor="##f5f5f5">
	     	<td align="right" width="40%" style="border-right:1px solid ##ddd">
	     	<strong>Handlers Location</strong>
	     	</td>
	     	<td>
	     	<input type="text" name="handlerLocation" value="#rc.Conventions.handlerLocation#" size="30">
			</td>
	     </tr>
	
	     <tr>
	     	<td align="right" width="40%" style="border-right:1px solid ##ddd">
	     	<strong>Layouts Location</strong>
	     	</td>
	     	<td>
	     	<input type="text" name="layoutsLocation" value="#rc.Conventions.layoutslocation#" size="30">
			</td>
	     </tr>
	     
	     <tr bgcolor="##f5f5f5">
	     	<td align="right" width="40%" style="border-right:1px solid ##ddd">
	     	<strong>Views Location</strong>
	     	</td>
	     	<td>
	     	<input type="text" name="viewsLocation" value="#rc.Conventions.viewslocation#" size="30">
			</td>
	     </tr>
     
    </table>
	</div>

	<div align="center" style="margin-top:30px">
		<a class="action" href="javascript:document.updateform.submit()" title="Submit Changes">
			<span>Submit Changes</span>
		</a>
	</div>

	</div>
</div>
</form>
</cfoutput>