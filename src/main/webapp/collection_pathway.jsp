<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 

<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.dto.RegulogStatDTO"%>
<%@page import="com.lbl.regprecise.ent.Pathway"%>
<%@page import="com.lbl.regprecise.ent.Term"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int pathwayId = 1;
	String val = request.getParameter("pathway_id");
	if (val != null) {
		pathwayId = Integer.valueOf(val);
	} 
	
	Pathway pathway = dataProvider.getPathway(pathwayId); 
	List<RegulogStatDTO> regulogStats = dataProvider.getRegulogStatsDTO(pathway);
	RegulogStatDTO.sortByRegtypePhylumRegnameTaxonomy(regulogStats);		
%>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Collection of regulogs involved in <%= pathway.getName() %></title>
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
				<h1>Collection of regulogs involved in <span class="titleItem"><%= pathway.getName() %></span></h1>				
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
						<th style="text-align: center;">Type</th>
						<th style="text-align: left;">Phylum</th>
						<th style="text-align: left;">Regulog</th>
						<th>Regulons (studied genomes)</th>
						<th>Regulatory sites</th>					
					</tr>
				</thead>
				<tbody>
					<%
						int i = 0;						
						for (RegulogStatDTO regulog : regulogStats) {
							i++;
							String regType = regulog.getRegulationTypeTermId() == Term.TERM_REGULATION_TYPE_TF ? "TF" : "RNA";
					%> 					
					<tr <% if(i%2 ==0){%>class="tbl_even_row"<%}%>>
						<td> <span class="<%= regType %>" > <%= regType %> </span> </td>
						<td  style="text-align: left"> <%=regulog.getPhylum()%></td>
						<td  style="text-align: left"><a href="regulog.jsp?regulog_id=<%= regulog.getRegulogId() %>">
						<%= regulog.getRegulatorName()%> - <%=regulog.getTaxonName()%></a></td>
						<td><b><%= regulog.getRegulonCount() %></b> (<%= regulog.getGenomeCount() %>)</td>
						<td><%= regulog.getSiteCount() %></td> 
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