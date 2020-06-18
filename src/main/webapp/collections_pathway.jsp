<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 
<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.Term"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.dto.PathwayStatDTO"%>
<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	List<PathwayStatDTO> collectionStats = dataProvider.getPathwaysStatDTO();		
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Collections of regulogs classified by metabolic pathways of regulated genes</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 

		<div >
			<div class="introduction">
				<h1>Collections of regulogs classified by metabolic pathways of regulated genes</h1> 
 				<h2>Each metabolic pathway-specific collection organizes all reconstructed regulogs that control genes from a given metabolic pathway or biological process.  The collected biochemical pathways are classified by major classes of biomolecules, such as amino acids, carbohydrates, nucleoides etc. The biopathway-specific collections may combine regulons operated by transcription factors and regulatory RNAs, such as the collection of regulons for Glycine metabolism.</h2> 				
			</div>
 			
			<div class="vspace_separator"></div>

			<div>
			<table class="stattbl">
				<caption></caption>
				<thead>
					<tr>
						<th class="sup_column2" scope="col"></th>
						<th class="sup_column1" colspan="3">Reconstructed</th>
						<th class="sup_column2" colspan="1">Studied</th>
					</tr>						
					
					<tr>						
						<th style="text-align: left">Pathway</th>
						<th>TF regulogs (regulons)</th>
						<th>RNA regulogs (regulons)</th>
						<th>Total regulogs (regulons)</th>
						<th>Genomes</th>
					</tr>
				</thead>		
				
				<tbody>
					<%
						int i = 0;
						String eathwayClassName = "";
						for (PathwayStatDTO collectionStat : collectionStats) 
						{
							i++;
							if(!eathwayClassName.equals(collectionStat.getPathwayClassName()))
							{
					%>
						<tr>
						<td colspan="7" class="effector_pathway_class" >
							<%= collectionStat.getPathwayClassName() %>
						</td>			
						</tr>			
					<%
								eathwayClassName = collectionStat.getPathwayClassName();
							}
								
					%>
					<tr <% if(i%2 ==0){%>class="tbl_even_row"<%}%>>
						<td style="text-align: left">
							<a href="collection_pathway.jsp?pathway_id=<%= collectionStat.getPathwayId() %>"><%= collectionStat.getPathwayName() %></a>
						</td>						
						<td><%= collectionStat.getTfRegulogCount() %> (<%= collectionStat.getTfRegulonCount() %>)</td>
						<td><%= collectionStat.getRnaRegulogCount() %> (<%= collectionStat.getRnaRegulonCount() %>)</td>
						<td><%= collectionStat.getTotalRegulogCount()  %> (<%= collectionStat.getTotalRegulogCount()  %>)</td>
						<td><%= collectionStat.getTotalGenomeCount()%></td>		
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