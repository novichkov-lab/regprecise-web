<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 
<%@page import="java.util.Collections"%> 


<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.dto.CollectionStatDTO"%>
<%@page import="com.lbl.regprecise.ent.Collection"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Regulon"%>
<%@page import="com.lbl.regprecise.ent.Genome"%>
<%@page import="com.lbl.regprecise.ent.Ortholog"%>
<%@page import="com.lbl.regprecise.ent.Site"%>

<%@page import="com.lbl.regprecise.web.WebLinksProvider"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.web.Formatter"%>


<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();

	int regulogId = 1;
	String val = request.getParameter("regulog_id");
	if (val != null) {
		regulogId = Integer.valueOf(val);
	}

	Regulog regulog = dataProvider.getRegulog(regulogId);
	
	// to get access in block_logo.jsp
	request.setAttribute("regulog", regulog);   	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title><%= regulog.getName()%>: logo</title>
<link rel="shortcut icon" href="images/favicon.ico" />
<link rel="stylesheet" type="text/css" href="styles/base.css" />
<style type="text/css">

#content{
	margin-left: 100px;
	margin-right: 100px;
}

h1 {
	font-size: 1em;
	border-bottom: 1px solid #AAA;
}




#gmstattbl{
	width : 780px;
	margin-left: 10px; 
	margin-top: 40px; 
	font-size: 0.8em; 
	border: 1px dotted #CCC; 
	float: left;"
}




</style>
</head>
<body>

<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 
			<div class="introduction">
				<h1> Profile of regulator <%= regulog.getRegulatorName()%> in <%= regulog.getTaxonName()%></h1> 
				<div id="propblock">
						<table class="proptbl">
						<caption class="tbl_caption">Properties</caption>						
						<tbody>
							
							<tr>
								<td class="first">Regulator family:</td>
								<td><%= Formatter.toNotNull(regulog.getRegulatorFamily())%></td>
							</tr>
							<tr>
								<td class="first">Regulation mode:</td>
								<td><%= Formatter.toNotNull(regulog.getRegulatorModeOfAction())%></td>
							</tr>
							<tr>
								<td class="first">Biological process:</td>
								<td><%= Formatter.toNotNull(regulog.getPathwayNames())%></td>
							</tr>
							<tr>
								<td>Effector:</td>
								<td><%= Formatter.toNotNull(regulog.getEffectorNames())%></td>
							</tr>
							<tr>
								<td>Regulog:</td>
								<td><a href="regulog.jsp?regulog_id=<%= regulog.getId() %>">
								<%= regulog.getName() %></a></td>
							</tr>
						</tbody>
						</table>
				</div>

				<div id="logoblock">
					<img src="logos/<%= regulog.getId() %>_large.png" />
				</div>

			</div> 
			<div class="clear"></div> 	
			<div class="vspace_separator"></div>	


			<%@ include file="/block_member_of_collections.jsp" %>			
			<div class="vspace_separator"></div>	

			<div id="data">
				<div class="tbl_caption">Transcription factor binding sites</div> 
					<table class="tbl_sites">
						<tbody>
						<tr>
							<th width="20px"></th>
							<th style="	text-align: left;">Locus Tag</th>
							<th style="	text-align: left;">Name</th>
							<th>Position</th>
							<th>Score</th>
							<th>Sequence</th>
						</tr>
						<%
							for (Regulon regulon : regulog.getRegulons()) {
								if(regulon.getSites().size() == 0) continue;
						%>
						<tr> 						
							<td colspan="6" style="text-align: left; font-style:italic; background: #EEE" >
								<%= regulon.getGenomeName() %>
							</td>
						</tr>								
						<%
						
								for(Site site: regulon.getSites() )
								{
						%>
						<tr> 
							<td></td>
							<td style="	text-align: left;"><%=  WebLinksProvider.getMicrobesOnlineRefHTML(site.getRelativeGene()) %></td>
							<td style="	text-align: left;"><%= site.getRelativeGene().getName() %></td>
							<td style="	text-align: center;"><%= site.getRelativePosition() %></td>
							<td style="	text-align: center;"><%= Formatter.formatSiteScore(site.getScore()) %></td>
							<td class="sequence"><%= site.getSequence() %></td>
						</tr>
						<%
								}
							}
						%>
						</tbody>
					</table>
				</div>


		<div class="vspace_separator"></div>	
		<div class="vspace_separator"></div>	
					
		<table class="tblexport">
			<caption class="tbl_caption">Export</caption>
			<tr>
				<td valign=middle style="width:32px; height:40px;">
					<img src="images/fastalogo.png" style="width:32px; height:32px; align:center;" />
				</td>
				<td>
					Regulatory Sites
				</td>
				<td>
					[ FASTA format ]
				</td>
				<td>
					 <a href="ExportServlet?type=site&regulogId=<%= regulog.getId()%>"><b>DOWNLOAD</b></a>  
				</td>
			</tr>
		</table>
	</div>
	
						
	</div>

	<%@ include file="/footer.jsp" %>	
</body>
</html>