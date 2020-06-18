
<%
	Integer _genomesCount  = (Integer) request.getAttribute("genomesCount");
	
	Integer _tfRegulogsCount = (Integer) request.getAttribute("tfRegulogsCount");
	Integer _tfRegulonsCount = (Integer) request.getAttribute("tfRegulonsCount");
	Integer _tfSitesCount  = (Integer) request.getAttribute("tfSitesCount");

	Integer _rnaRegulogsCount	 = (Integer) request.getAttribute("rnaRegulogsCount");
	Integer _rnaRegulonsCount = (Integer) request.getAttribute("rnaRegulonsCount");
	Integer _rnaSitesCount  = (Integer) request.getAttribute("rnaSitesCount");
	
%>

<table class="stattbl"> 
	<caption class="tbl_caption">General statistics</caption>
	<tbody>
	
		<% if( _genomesCount != null){ %>
			<tr>
				<td class="first">Genomes</td>
				<td><%= _genomesCount %></td>
			</tr>								
		<%}%>
	
		<% if( _tfRegulogsCount != null){ %>
			<tr>
				<td class="first">TF regulogs</td>
				<td><%= _tfRegulogsCount %></td>
			</tr>								
		<%}%>
		
		<% if( _tfRegulonsCount != null){ %>
			<tr>
				<td class="first">TF regulons</td>
				<td><%= _tfRegulonsCount %></td>
			</tr>								
		<%}%>			
	
		<% if( _tfSitesCount != null){ %>
			<tr>
				<td class="first">TF binding sites</td>
				<td><%= _tfSitesCount %></td>
			</tr>								
		<%}%>	
	
		<% if( _rnaRegulogsCount != null){ %>
			<tr>
				<td class="first">RNA regulogs</td>
				<td><%= _rnaRegulogsCount %></td>
			</tr>								
		<%}%>	
	
	
		<% if( _rnaRegulonsCount != null){ %>
			<tr>
				<td class="first">RNA regulons</td>
				<td><%= _rnaRegulonsCount %></td>
			</tr>								
		<%}%>
		
		<% if( _rnaSitesCount != null){ %>
			<tr>
				<td class="first">RNA sites</td>
				<td><%= _rnaSitesCount %></td>
			</tr>								
		<%}%>
								
	</tbody>
</table>