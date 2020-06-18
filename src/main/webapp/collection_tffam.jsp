<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 

<%@page import="com.lbl.regprecise.dto.CollectionStatDTO"%>
<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.dto.RegulogStatDTO"%>
<%@page import="com.lbl.regprecise.ent.TFFamily"%>
<%@page import="com.lbl.regprecise.web.WebLinksProvider"%>
<%@page import="com.lbl.regprecise.web.Formatter"%>

<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int tfFamilyId = 1;
	String val = request.getParameter("tffamily_id");
	if (val != null) {
		tfFamilyId = Integer.valueOf(val);
	} 
	
	TFFamily tfFamily = dataProvider.getTFFamily(tfFamilyId); 
	String description1 = Formatter.getDescriptionPart1( tfFamily.getDescription());
	description1 = WebLinksProvider.changePMIDIds2Refs(description1);
	String description2 = Formatter.getDescriptionPart2( tfFamily.getDescription());
	description2 = WebLinksProvider.changePMIDIds2Refs(description2);	
	
	// to get access in block_description_more.jsp
	request.setAttribute("description1", description1);
	request.setAttribute("description2", description2);	
	
	
	List<RegulogStatDTO> regulogStats = dataProvider.getRegulogStatsDTO(tfFamily);
	RegulogStatDTO.sortByRegnamePhylumTaxonomy(regulogStats);

	int tfRegulogsCount = regulogStats.size();
	int tfRegulonsCount = 0;
	int tfSitesCount = 0;
	
	for(RegulogStatDTO stat: regulogStats)
	{
		tfRegulonsCount += stat.getRegulonCount().intValue();
		tfSitesCount += stat.getSiteCount().intValue();
	}
	
	request.setAttribute("tfRegulogsCount", tfRegulogsCount);
	request.setAttribute("tfRegulonsCount", tfRegulonsCount);
	request.setAttribute("tfSitesCount", tfSitesCount);		
	
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Collection of regulogs for <span class="titleItem"><%= tfFamily.getName() %></span> transcription factor family</title>
<script type="text/javascript" src="js/base.js"></script>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
<style type="text/css">
.sep{
	border-top: 1px solid #EEE;
}
</style>
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 
			<div class="introduction">
				<h1>Collection of regulogs for <span class="titleItem"><%= tfFamily.getName() %></span> transcription factor family</h1>
				<div style="float: right; margin: 1em 0 20px 0;">  
					<%@ include file="/block_general_stat_table.jsp" %>
				</div>	
				<%@ include file="/block_description_more.jsp" %>					
				
			</div> 

			<div class="clear"></div>
			<div class="vspace_separator"></div>

			<div>
			<table class="stattbl">
				<caption></caption>
				<thead>
					<tr>
						<th class="sup_column2" colspan="5"></th>
					</tr>					
					<tr>		
 					 <!--<th style="text-align: left;">TF</th>  -->	
						<th style="text-align: left;">Phylum</th>
						<th style="text-align: left;">Regulog</th>
						<th>TF regulons (studied genomes)</th>
						<th>TFBSs</th>
						<th>Logo</th>
					</tr>
				</thead>
				<tbody>
					<%
						String regName = "";
						boolean sepRequired = false;
						int regIndex = 0;
						
						for (RegulogStatDTO regulog : regulogStats) {
							String curRegName = regulog.getRegulatorName();
							if(curRegName.equals(regName))
							{
								curRegName = "";
								sepRequired = false;
							} 
							else {
								regName = curRegName;
								sepRequired = (regIndex > 0);
								regIndex++;
							}							
					%> 								
					<tr>
						<td <%if(sepRequired){%>class="sep"<%}%> style="text-align: left"> <%=regulog.getPhylum()%></td>						
						<td <%if(sepRequired){%>class="sep"<%}%> style="text-align: left"><a href="regulog.jsp?regulog_id=<%= regulog.getRegulogId() %>"><%=regulog.getName()%></a></td>
						<td <%if(sepRequired){%>class="sep"<%}%>><b><%= regulog.getRegulonCount() %></b> (<%= regulog.getGenomeCount() %>)</td>
						<td <%if(sepRequired){%>class="sep"<%}%>><a href="sites.jsp?regulog_id=<%= regulog.getRegulogId() %>"><%= regulog.getSiteCount() %></a></td>
						<td <%if(sepRequired){%>class="sep"<%}%>><img style="margin-bottom: -30px; padding:0;" src="logos/<%= regulog.getRegulogId()%>_small.png" /></td>
					</tr>
					<%
						}
					%>
			
				</tbody>
				</table>
			</div> 
		<div class="clear"></div>
		<div class="vspace_separator"></div>
 	</div>
 
	<%@ include file="/footer.jsp" %>	
</div>
</body>
</html>