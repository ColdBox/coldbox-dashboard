<cfoutput>
<cfset rc = event.getCollection()>
<cfset oSession = getPlugin("sessionstorage")>
<div id="FileBrowser">

	<form name="fileviewer_form" id="fileviewer_form">
	<div class="container">
		
		<div class="browser_titlebar">
		   <a href="javascript:doEventNOUI('#rc.xehBrowser#', 'FileBrowser',{dir:'#jsstringFormat(rc.currentroot)#'})" title="Refresh Listing"><img src="images/icons/arrow_refresh.png" align="absmiddle" border="0" title="Refresh Listing."></a>
			You are Here: #rc.currentroot#
		</div>
		
		<div class="filelisting">
		   
		    #getPlugin("messagebox").renderit()#
		    
			<cfif listlen(rc.currentroot,"/") gte 1>
				<cfset tmpHREF = "javascript:doEventNOUI('#rc.xehBrowser#','FileBrowser',{dir:'#JSStringFormat(oSession.getVar('oldRoot'))#'})">
				<a href="#tmpHREF#"><img src="images/icons/folder.png" border="0" align="absmiddle" alt="Folder"></a>
				<a href="#tmpHREF#">..</a><br>
			</cfif>
			
			<cfloop query="rc.qryDir">
				<cfif rc.qryDir.type eq "Dir">
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
			
		</div>
	
		<div class="selectedBar">
			Selected Folder:&nbsp;<span id="span_selectedfolder"></span>
		</div>
	
		<div class="bottomBar">
			<input type="hidden" name="selecteddir" id="selecteddir" value="">
			<input type="hidden" name="currentroot" id="currentroot" value="#rc.currentroot#">
			
			<input type="button" id="sb_cancel_btn" 	value="Cancel" 			onClick="closeBrowser()" class="jqmClose"> &nbsp;
			<input type="button" id="sb_createdir_btn"  value="New Folder"  	onClick="newFolder('#rc.xehNewFolder#','#JSStringFormat(rc.currentroot)#')"> &nbsp;
			<input type="button" id="sb_selectdir_btn"  value="Choose Folder" 	onClick="chooseFolder('#oSession.getVar('callbackItem')#')" disabled="true" class="jqmClose">
		</div>
		
	</div>
	</form>
</div>
</cfoutput>