<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 
<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.Term"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.web.WebLinksProvider"%>
<%@page import="com.lbl.regprecise.dto.RiboswitchStatDTO"%>


<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	List<RiboswitchStatDTO> collectionStats = dataProvider.getRiboswitchStatDTO();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Collections of regulogs classified by RNA regulatory elements</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 

		<div >
			<div class="introduction">
				<h1>Collections of regulogs classified by RNA regulatory elements</h1> 
 				<h2>
 					Each RNA family collection organizes all reconstructed regulogs for a given family of regulatory RNA across different taxonomic groups of microorganisms. Genomic distribution and repertoires of controlled genes (regulons) were analyzed for 36 families of regulatory RNAs including 15 metabolite-sensing riboswitches, 6 ribosomal operons leadears, 4 amino acid-responsive attenuators, and multiple cis-acting regulatory RNAs of yet unknown regulatory mechanism. The large collection of T-box regulons for amino acid metabolism was classified by amino acid specifcities based on detailed analysis of T-box sequences.
					The RNA family regulon collections are valuable for evolutionary analysis of regulatory RNAs and their regulons from the same RNA family. 				
 				</h2>
			</div>
 			
			<div class="vspace_separator"></div>

			<div>
			<table class="stattbl">
				<caption></caption>
				<thead>
					<tr>
						<th class="sup_column2" colspan="2"></th>
						<th class="sup_column1" colspan="3">Reconstructed</th>
						<th class="sup_column2" colspan="1">Studied</th>
					</tr>						
					
					<tr>						
						<th style="text-align: left">RNA elemnet</th>
						<th>RFAM ID</th>
						<th>Regulogs</th>
						<th>RNA regulons</th>
						<th>RNA sites</th>
						<th>Genomes</th>		
					</tr>
				</thead>					
				
				<tbody>
					<%
						int i = 0;
						for (RiboswitchStatDTO collectionStat : collectionStats) {
							i++;
					%>
					<tr <% if(i%2 ==0){%>class="tbl_even_row"<%}%>>
						<td style="text-align: left">
							<a href="collection_rfam.jsp?riboswitch_id=<%= collectionStat.getRiboswitchId()%>"><%= collectionStat.getRiboswitchName() %></a>
						</td>						
						<td><%=  WebLinksProvider.getRFAMRefHTML( collectionStat.getRfamId())  %></td>
						<td><%= collectionStat.getRegulogCount()%></td>
						<td><%= collectionStat.getRegulonCount()%></td>
						<td><%= collectionStat.getSiteCount() %></td>
						<td><%= collectionStat.getGenomeCount()%></td>
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