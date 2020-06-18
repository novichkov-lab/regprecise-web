<%@ page errorPage="error.jsp" %> 
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.List"%> 

<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.dto.CollectionStatDTO"%>
<%@page import="com.lbl.regprecise.dto.GenomeStatDTO"%>
<%@page import="com.lbl.regprecise.ent.Collection"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Regulon"%>
<%@page import="com.lbl.regprecise.ent.Genome"%>

<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int collectionId = Collection.COLLECTION_ID_PUBLIC_ALL; 	 

	List<GenomeStatDTO> genomeStats = dataProvider.getGenomeStatsDTO(false);
	request.setAttribute("clstat", dataProvider.getSummaryStatDTO() );		
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Browse regulons</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 
		<div>
			<div class="introduction">
				<h1>  Browse by genomes</h1>
				<h2 style="text-align: right"><a href="browse_regulogs.jsp">[browse by regulogs]</a></h2>			
			</div>
 
			<div class="vspace_separator"></div>


			<div>
			<table class="stattbl">
				<caption></caption>
				<thead>
					<tr>					
						<th class="sup_column2"></th>
						<th class="sup_column1" colspan="3">Reconstructed</th>
					</tr>					
					<tr>						
						<th style="text-align: left">Genome</th>
						<th>TF regulons</th>
						<th>RNA regulons</th>
						<th>Total regulons</th>
					</tr>
				</thead>
				<tbody>
					<%
						int i = 0;
						for (GenomeStatDTO gmStat : genomeStats) {
							i++;							
					%>
					<tr <% if(i%2 ==0){%>class="tbl_even_row"<%}%>>
						<td style="text-align: left"><a
							href="genome.jsp?genome_id=<%= gmStat.getGenomeId() %>"><%= gmStat.getGenomeName() %></a></td>
						<td><%= gmStat.getTfRegulonCount() %></td>						
						<td><%= gmStat.getRnaRegulonCount() %></td>
						<td><%= gmStat.getTotalRegulonCount() %></td>						
					</tr>
					<%
						}
					%>
			
				</tbody>
				</table>
			</div>
		</div>
	</div>
	<%@ include file="/footer.jsp" %>	
</div>
</body>
</html>