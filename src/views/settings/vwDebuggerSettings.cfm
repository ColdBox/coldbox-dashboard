<cfoutput><!--- HELPBOX --->#renderView("tags/help")#<form name="updateform" id="updateform" action="javascript:doFormEvent('#Event.getValue("xehDoSave")#','content',document.updateform)" onSubmit="return confirmit()" method="post"><div class="maincontentbox">	<div class="contentboxes_header">		<div class="contentboxes_title"><img src="images/icons/fileencoding_icon.gif" align="absmiddle" />&nbsp; Debugger Settings</div>	</div>		<!--- Messagebox --->	#getPlugin("messagebox").renderit()#		<div class="contentboxes">	<p>Below are the ColdBox's debugger settings that you can change.	</p>	<br>		<div style="margin: 5px">	    <table width="100%" border="0" cellspacing="0" cellpadding="5" class="tablelisting">	      	      <tr>			<th>Setting</th>			<th>Value</th>		  </tr>				 <tr bgcolor="##f5f5f5">	     	<td align="right" width="40%" style="border-right:1px solid ##ddd">	     	<strong>PersistentRequestProfiler</strong>	     	</td>	     	<td>	     	<select name="PersistentRequestProfiler" style="width:100px">	     		<option value="false" <cfif rc.fwSettings.PersistentRequestProfiler eq false>selected</cfif>>False</option>	     		<option value="true"  <cfif rc.fwSettings.PersistentRequestProfiler>selected</cfif>>True</option>	     	</select>	     	</td>	     </tr>	     	     <tr>	     	<td align="right" width="40%" style="border-right:1px solid ##ddd">	     	<strong>maxPersistentRequestProfilers</strong>	     	</td>	     	<td>	     	<input type="text" name="maxPersistentRequestProfilers" value="#rc.fwSettings.maxPersistentRequestProfilers#" size="5" maxlength="2">	     	</td>	     </tr>	     <tr bgcolor="##f5f5f5">	     	<td align="right" width="40%" style="border-right:1px solid ##ddd">	     	<strong>maxRCPanelQueryRows</strong>	     	</td>	     	<td>	     	<input type="text" name="maxRCPanelQueryRows" value="#rc.fwSettings.maxRCPanelQueryRows#" size="5" maxlength="4">	     	</td>	     </tr>	     	     <tr >	     	<td align="right" width="40%" style="border-right:1px solid ##ddd">	     	<strong>Tracer Panel</strong>	     	</td>	     	<td>	     	<strong>Show:</strong>	     	<select name="showTracerPanel" style="width:100px">	     		<option value="false" <cfif rc.fwSettings.showTracerPanel eq false>selected</cfif>>False</option>	     		<option value="true"  <cfif rc.fwSettings.showTracerPanel>selected</cfif>>True</option>	     	</select>	     		     	<strong>Expanded:</strong>	     	<select name="expandedTracerPanel" style="width:100px">	     		<option value="false" <cfif rc.fwSettings.expandedTracerPanel eq false>selected</cfif>>False</option>	     		<option value="true"  <cfif rc.fwSettings.expandedTracerPanel>selected</cfif>>True</option>	     	</select>	     	</td>	     </tr>     	     <tr bgcolor="##f5f5f5">	     	<td align="right" width="40%" style="border-right:1px solid ##ddd">	     	<strong>Info Panel</strong>	     	</td>	     	<td>	     	<strong>Show:</strong>	     	<select name="showInfoPanel" style="width:100px">	     		<option value="false" <cfif rc.fwSettings.showInfoPanel eq false>selected</cfif>>False</option>	     		<option value="true"  <cfif rc.fwSettings.showInfoPanel>selected</cfif>>True</option>	     	</select>	     		     	<strong>Expanded:</strong>	     	<select name="expandedInfoPanel" style="width:100px">	     		<option value="false" <cfif rc.fwSettings.expandedInfoPanel eq false>selected</cfif>>False</option>	     		<option value="true"  <cfif rc.fwSettings.expandedInfoPanel>selected</cfif>>True</option>	     	</select>	     	</td>	     </tr>	     	      <tr >	     	<td align="right" width="40%" style="border-right:1px solid ##ddd">	     	<strong>Cache Panel</strong>	     	</td>	     	<td>	     	<strong>Show:</strong>	     	<select name="showCachePanel" style="width:100px">	     		<option value="false" <cfif rc.fwSettings.showCachePanel eq false>selected</cfif>>False</option>	     		<option value="true"  <cfif rc.fwSettings.showCachePanel>selected</cfif>>True</option>	     	</select>	     		     	<strong>Expanded:</strong>	     	<select name="expandedCachePanel" style="width:100px">	     		<option value="false" <cfif rc.fwSettings.expandedCachePanel eq false>selected</cfif>>False</option>	     		<option value="true"  <cfif rc.fwSettings.expandedCachePanel>selected</cfif>>True</option>	     	</select>	     	</td>	     </tr>	     	     <tr bgcolor="##f5f5f5">	     	<td align="right" width="40%" style="border-right:1px solid ##ddd">	     	<strong>RC Panel</strong>	     	</td>	     	<td>	     	<strong>Show:</strong>	     	<select name="showRCPanel" style="width:100px">	     		<option value="false" <cfif rc.fwSettings.showRCPanel eq false>selected</cfif>>False</option>	     		<option value="true"  <cfif rc.fwSettings.showRCPanel>selected</cfif>>True</option>	     	</select>	     		     	<strong>Expanded:</strong>	     	<select name="expandedRCPanel" style="width:100px">	     		<option value="false" <cfif rc.fwSettings.expandedRCPanel eq false>selected</cfif>>False</option>	     		<option value="true"  <cfif rc.fwSettings.expandedRCPanel>selected</cfif>>True</option>	     	</select>	     	</td>	     </tr>        </table>		</div>		<div align="center" style="margin-top:30px">			<a class="action" href="javascript:document.updateform.submit()" title="Submit Changes">				<span>Submit Changes</span>			</a>		</div>	</div></div></form></cfoutput>