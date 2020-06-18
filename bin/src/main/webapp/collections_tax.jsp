<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 
<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.Term"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.dto.CollectionStatDTO"%>
<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	List<CollectionStatDTO> collectionStats = dataProvider.getCollectionsStatDTO(Term.COLLECTION_TYPE_BY_TAXONOMY);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Collections of regulogs classified by taxonomic group</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 

		<div >
			<div class="introduction">
				<h1>Collections of regulogs classified by taxonomic group</h1> 
 				<h2>Each taxonomy collection organizes all reconstructed regulogs for a given set of taxonomically related microbial genomes. The taxonomy collections represent results of large-scale reconstruction of regulon operated by either transcription factors or RNA regulatory elements. The taxonomical collections of regulons are valuable for modeling the evolution of transcriptional regulatory networks and could be used as a framework for interpretation of high-throughput gene expression data.</h2>
			</div>
 			
			<div class="vspace_separator"></div>

			<div>
			<table class="stattbl">
				<caption></caption>
				<thead>
					<tr>
						<th class="sup_column2"></th>
						<th class="sup_column1"  colspan="3">Reconstructed</th>
						<th class="sup_column2">Studied</th>
					</tr>						
					
					<tr>						
						<th style="text-align: left">Taxonomic group</th>
						<th>TF regulogs (regulons)</th>
						<th>RNA regulogs (regulons)</th>
						<th>Total regulogs (regulons)</th>
						<th>Genomes</th>
					</tr>	
				</thead>
				<tbody>
					<%
						int i = 0;
						for (CollectionStatDTO collectionStat : collectionStats) {
							i++;
					%>
					<tr <% if(i%2 ==0){%>class="tbl_even_row"<%}%>>
						<td style="text-align: left">
							<a href="collection_tax.jsp?collection_id=<%= collectionStat.getCollectionId()%>"><%= collectionStat.getCollectionName() %></a>
						</td>						
						<td><%= collectionStat.getTfRegulogCount() %> (<%= collectionStat.getTfRegulonCount() %>)</td>
						<td><%= collectionStat.getRnaRegulogCount() %> (<%= collectionStat.getRnaRegulonCount() %>)</td>
						<td><%= collectionStat.getTotalRegulogCount() %> (<%= collectionStat.getTotalRegulonCount() %>)</td>
						<td><%= collectionStat.getTotlaGenomeCount() %></td>

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