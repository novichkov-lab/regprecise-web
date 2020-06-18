<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 

<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.dto.CollectionStatDTO"%>
<%@page import="com.lbl.regprecise.dto.RegulogStatDTO"%>
<%@page import="com.lbl.regprecise.ent.Collection"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Regulon"%>
<%@page import="com.lbl.regprecise.ent.Genome"%>
<%@page import="com.lbl.regprecise.web.WebLinksProvider"%>
<%@page import="com.lbl.regprecise.web.Formatter"%>

<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int collectionId = 1;
	String val = request.getParameter("collection_id");
	if (val != null) {
		collectionId = Integer.valueOf(val);
	} 

	CollectionStatDTO collectionStat = dataProvider.getCollectionStatDTO(collectionId);
	request.setAttribute("genomesCount", collectionStat.getTotlaGenomeCount().intValue());   
	request.setAttribute("tfRegulogsCount", collectionStat.getTfRegulogCount().intValue());
	request.setAttribute("tfRegulonsCount", collectionStat.getTfRegulonCount().intValue());
	request.setAttribute("tfSitesCount", collectionStat.getTfSiteCount().intValue());	
	
	
	List<RegulogStatDTO> regulogs = dataProvider.getRegulogStatsDTO(collectionId);
	Collection cl = dataProvider.getCollection(collectionId);
	
	String description1 = Formatter.getDescriptionPart1( cl.getDescription());
	description1 = WebLinksProvider.changePMIDIds2Refs(description1);
	String description2 = Formatter.getDescriptionPart2( cl.getDescription());
	description2 = WebLinksProvider.changePMIDIds2Refs(description2);		
	// to get access in block_description_more.jsp
	request.setAttribute("description1", description1);
	request.setAttribute("description2", description2);	
	
	RegulogStatDTO.sortByPhylumTaxonomyRegnameName(regulogs);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Collection of regulogs for the <%=cl.getName()%> transcription factor</title>
<script type="text/javascript" src="js/base.js"></script>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 
			<div class="introduction">
				<h1>Collection of regulogs for <span class="titleItem"><%=cl.getName()%></span> transcription factor</h1>

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
						<th style="text-align: left;">Phylum</th>
						<th style="text-align: left;">Regulog</th>
						<th scope="col">TF regulons (studied genomes)</th>						
						<th scope="col">TFBSs</th>
						<th>Logo</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (RegulogStatDTO regulog : regulogs) {
					%>
					<tr>
						<td style="text-align: left"> <%=regulog.getPhylum()%></td>
						<td style="text-align: left"><a href="regulog.jsp?regulog_id=<%= regulog.getRegulogId() %>"> <%= regulog.getName()%></a></td>
						<td> <b><%= regulog.getRegulonCount() %></b> (<%= regulog.getGenomeCount() %>)</td>
						<td ><a href="sites.jsp?regulog_id=<%= regulog.getRegulogId() %>"><%= regulog.getSiteCount() %></a></td>
						<td><img style="margin-bottom: -30px; padding:0;" src="logos/<%= regulog.getRegulogId() %>_small.png" /></td>
					</tr>
					<%
						}
					%>
			
				</tbody>
				</table>
			</div> 
	</div>
	<div class="clear"></div>
	<div class="vspace_separator"></div>
 
	<%@ include file="/footer.jsp" %>	
</div>
</body>
</html>