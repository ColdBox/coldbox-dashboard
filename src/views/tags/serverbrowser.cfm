<cfoutput>
<div id="FileBrowser">

	<form name="fileviewer_form" id="fileviewer_form">
	<div class="container">
		
		<!--- Roots --->
		<div style="float:right;margin-right:3px">
			<strong>Volumes:</strong>
			<select name="roots" id="roots" onChange="javascript:doEventNOUI('#rc.xehBrowser#','FileBrowser',{computerRoot:this.value})" style="width:50px">
				<cfloop from="1" to="#arrayLen(rc.roots)#" index="i">
				<option value="#rc.roots[i].getAbsolutePath()#" <cfif rc.roots[i].getAbsolutePath() eq rc.computerRoot>selected=selected</cfif>>#rc.roots[i].getAbsolutePath()#</option>
				</cfloop>
			</select>
		</div>
		
		<!--- Your Current Location --->
		<div class="browser_titlebar">
		   <a href="javascript:doEventNOUI('#rc.xehBrowser#', 'FileBrowser',{dir:'#jsstringFormat(rc.currentroot)#'})" title="Refresh Listing"><img src="images/icons/arrow_refresh.png" align="absmiddle" border="0" title="Refresh Listing."></a>
			You are Here: #rc.currentroot#
		</div>
		
		<!--- Show the File Listing --->
		<div class="filelisting">
		    <!--- Messagebox --->
		    #getPlugin("messagebox").renderit()#
		    
		    <!--- Display back links --->
			<cfif listlen(rc.currentroot,"/") gte 1>
				<cfset tmpHREF = "javascript:doEventNOUI('#rc.xehBrowser#','FileBrowser',{dir:'#JSStringFormat(rc.oSession.getVar('oldRoot'))#'})">
				<a href="#tmpHREF#"><img src="images/icons/folder.png" border="0" align="absmiddle" alt="Folder"></a>
				<a href="#tmpHREF#">..</a><br>
			</cfif>
			
			<!--- Display directories --->
			<cfif rc.qryDir.recordcount>
			<cfloop query="rc.qryDir">
			<cfif rc.qryDir.type eq "Dir" and left(rc.qryDir.name,1) neq ".">
				<cfset vURL = "#rc.currentroot##iif(rc.currentroot eq "/","''","'/'")##urlEncodedFormat(rc.qryDir.name)#">
				<cfset plainURL = "#rc.currentroot##iif(rc.currentroot eq "/","''","'/'")##rc.qryDir.name#">
				<cfset tmpHREF = "javascript:doEventNOUI('#rc.xehBrowser#','FileBrowser',{dir:'#vURL#'})">
				<cfset validIDName = JSStringFormat(replace(rc.qryDir.name,".","_","all")) >
				
				<div id="#validIDName#" 
					 onClick="selectdirectory('#validIDName#','#plainURL#')" 
					 style="cursor: pointer;"
					 onDblclick="#tmpHREF#">
					<a href="#tmpHREF#"><img src="images/icons/folder.png" border="0" align="absmiddle" alt="Folder"></a>
					#rc.qryDir.name#
				</div>
			</cfif>
			</cfloop>
			</cfif>
			
		</div>
	
		<!--- Selcted Folder --->
		<div class="selectedBar">
			Selected Folder:&nbsp;<span id="span_selectedfolder"></span>
		</div>
	
		<!--- The Bottom Bar --->
		<div class="bottomBar">
			<input type="hidden" name="selecteddir" id="selecteddir" value="">
			<input type="hidden" name="currentroot" id="currentroot" value="#rc.currentroot#">
			<!--- Selection Buttons --->
			<input type="button" id="sb_cancel_btn" 	value="Cancel" 			onClick="closeBrowser()" class="jqmClose"> &nbsp;
			<input type="button" id="sb_createdir_btn"  value="New Folder"  	onClick="newFolder('#rc.xehNewFolder#','#JSStringFormat(rc.currentroot)#')"> &nbsp;
			<input type="button" id="sb_selectdir_btn"  value="Choose Folder" 	onClick="chooseFolder('#rc.oSession.getVar('callbackItem')#')" disabled="true" class="jqmClose">
		</div>
		
	</div>
	</form>
</div>
</cfoutput>