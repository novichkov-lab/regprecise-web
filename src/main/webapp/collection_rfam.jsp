<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 

<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.dto.RegulogStatDTO"%>
<%@page import="com.lbl.regprecise.ent.Riboswitch"%>
<%@page import="com.lbl.regprecise.web.WebLinksProvider"%>
<%@page import="com.lbl.regprecise.web.Formatter"%>



<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int riboswitchId = 1;
	String val = request.getParameter("riboswitch_id");
	if (val != null) {
		riboswitchId = Integer.valueOf(val);
	} 
	
	Riboswitch riboswitch = dataProvider.getRiboswitch(riboswitchId);
	
	String description1 = Formatter.getDescriptionPart1( riboswitch.getDescription());
	description1 = WebLinksProvider.changePMIDIds2Refs(description1);
	String description2 = Formatter.getDescriptionPart2( riboswitch.getDescription());
	description2 = WebLinksProvider.changePMIDIds2Refs(description2);	
			
	// to get access in block_description_more.jsp
	request.setAttribute("description1", description1);
	request.setAttribute("description2", description2);
	
	List<RegulogStatDTO> regulogStats = dataProvider.getRegulogStatsDTO(riboswitch);
	RegulogStatDTO.sortByPhylumRegnameTaxonomy(regulogStats);		
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Collection of regulogs for the <%= riboswitch.getName() %> RNA regulatory element</title>
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
				<h1>Collection of regulogs for <span class="titleItem"><%= riboswitch.getName() %> (<%=  WebLinksProvider.getRFAMRefHTML( riboswitch.getRfamId())  %>)</span> RNA regulatory element</h1>				
			</div>
			<%@ include file="/block_description_more.jsp" %>			 
			<div id="logoblock" style="width: 250px"  align="center" >			
					<img  width="130" src="<%= riboswitch.getImageRef() %>" /> 
			</div>
			 
			
			<div class="clear"></div>
			<div class="vspace_separator"></div>
			
			<div>
			<table class="stattbl">
				<caption></caption>
				<thead>
					<tr>
						<th class="sup_column2" colspan="4"></th>
					</tr>					
					<tr>						
						<th style="text-align: left;">Phylum</th>
						<th style="text-align: left;">Regulog</th>
						<th>RNA regulons (studied genomes)</th>
						<th>RNA sites</th>
					</tr>
				</thead>				
				<tbody>
					<%
						int i = 0;						
						for (RegulogStatDTO regulog : regulogStats) {
							i++;
					%> 
					<tr <% if(i%2 ==0){%>class="tbl_even_row"<%}%>>
						<td  style="text-align: left"> <%=regulog.getPhylum()%></td>
						<td  style="text-align: left"><a href="regulog.jsp?regulog_id=<%= regulog.getRegulogId() %>">
							<%=regulog.getRegulatorName()%> - <%=regulog.getTaxonName()%></a></td>
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