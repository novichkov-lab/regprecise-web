<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 

<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.dto.CollectionStatDTO"%>
<%@page import="com.lbl.regprecise.dto.RegulogStatDTO"%>
<%@page import="com.lbl.regprecise.ent.Collection"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Regulon"%>
<%@page import="com.lbl.regprecise.ent.Genome"%>
<%@page import="com.lbl.regprecise.ent.Term"%>

<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.web.Formatter"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int collectionId = Collection.COLLECTION_ID_PUBLIC_ALL; 	 

	List<RegulogStatDTO> regulogs = dataProvider.getRegulogStatsDTO();
	
	String sortType = request.getParameter("sort");
	if (sortType == null) {
		sortType = "tf";
	}
	
	if(sortType.equals("tf"))
	{
		RegulogStatDTO.sortByRegnameTaxonomy(regulogs);
	} else if (sortType.equals("funct"))
	{
		RegulogStatDTO.sortByPathwayRegnameTaxonomy(regulogs);
	} else if (sortType.equals("eff"))
	{
		RegulogStatDTO.sortByEffectorRegnameTaxonomy(regulogs);
	} else if (sortType.equals("fam"))
	{
		RegulogStatDTO.sortByFamilyRegnameTaxonomy(regulogs);
	} else if (sortType.equals("genomes"))
	{
		RegulogStatDTO.sortByGenomesCount(regulogs, false);
	} else if (sortType.equals("sites"))
	{
		RegulogStatDTO.sortBySitesCount(regulogs, false);
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Browse regulons</title>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
	<link rel="shortcut icon" href="images/favicon.ico" />
	<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>
	<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content">
		
		<div class="introduction">
			<h1>Browse by regulogs </h1>
			<h2 style="text-align: right"> <a href="browse_genomes.jsp">[browse by genomes]</a></h2>				
		</div>
 
		<div class="vspace_separator"></div>

		<div>
			<table class="stattbl">
				<caption></caption>
				<thead>
					<tr>					
						<th class="sup_column2" colspan="7"></th>
					</tr>					
					<tr>						
						<th>Type</th>
						<th style="text-align: left"><a href="browse_regulogs.jsp?sort=tf">Regulog</a></th>
						<th style="text-align: left"><a href="browse_regulogs.jsp?sort=funct">Function</a></th>
						<th style="text-align: left"><a href="browse_regulogs.jsp?sort=eff">Effector</a></th>
						<th style="text-align: left"><a href="browse_regulogs.jsp?sort=fam">Family</a></th>
						<th ><a href="browse_regulogs.jsp?sort=genomes">Genomes</a></th>
						<th ><a href="browse_regulogs.jsp?sort=sites">Sites</a></th>
					</tr>
				</thead>
				<tbody>
					<%
						int i = 0;
						for (RegulogStatDTO regulog : regulogs) {
							i++;
							String regType = regulog.getRegulationTypeTermId() == Term.TERM_REGULATION_TYPE_TF ? "TF" : "RNA";							
							%>
					<tr <% if(i%2 ==0){%>class="tbl_even_row"<%}%>>
						<td> <span class="<%= regType %>" > <%= regType %> </span> </td>					
						<td style="text-align: left"><a
							href="regulog.jsp?regulog_id=<%= regulog.getRegulogId() %>"><%= regulog.getName() %></a></td>
						<td style="text-align: left"> <%= Formatter.toNotNull(regulog.getPathway())  %></td>
						<td style="text-align: left"> <%= Formatter.toNotNull(regulog.getEffector()) %></td>
						<td style="text-align: left"> <%= Formatter.toNotNull(regulog.getRegulatorFamily()) %></td>
						<td><%= regulog.getGenomeCount() %></td>						
						<td><a href="sites.jsp?regulog_id=<%= regulog.getRegulogId() %>"><%= regulog.getSiteCount() %></a></td>
					</tr>
					<%
						}
					%>
			
				</tbody>
			</table>
		</div>
	
	</div>	
	<%@ include file="/footer.jsp" %>	
	</div>
</body>
</html>