<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 
<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.Term"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.dto.TFFamiliyStatDTO"%>
<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	List<TFFamiliyStatDTO> collectionStats = dataProvider.getTFFamiliyStatDTO();		
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Collections of regulogs classified by transcription factor families</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 

		<div >
			<div class="introduction">
				<h1>Collections of regulogs classified by transcription factor families</h1> 
 				<h2>Each transcription factor family collection organizes all reconstructed regulogs for a given protein family of homologous regulators across different taxonomic groups of microorganisms. These collections of reconstructed TF regulons covers both large and diverse families such as LacI, GntR, and TetR, that contain more than 50 different groups of orthologous transcription factors, and small families such as ArgR, BirA and LexA, containing orthologous transcription factors of the same function. The TF family regulon collections are valuable for evolutionary analysis of TF binding site motifs and effector specificities of homologous transcription factors from the same protein family.</h2>
			</div>
 			
			<div class="vspace_separator"></div>

			<div>
			<table class="stattbl">
				<caption></caption>
				<thead>
					<tr>
						<th class="sup_column2"></th>
						<th class="sup_column1" colspan="3">Reconstructed</th>
						<th class="sup_column2">Studied</th>
					</tr>						
					<tr>						
						<th style="text-align: left">TF family</th>
						<th>Regulogs</th>
						<th>TF regulons</th>
						<th>TF binding sites</th>
						<th>Genomes</th>					
					</tr>
				</thead>									
				<tbody>
					<%
						int i = 0;
						for (TFFamiliyStatDTO collectionStat : collectionStats) {
							i++;
					%>					
					<tr <% if(i%2 ==0){%>class="tbl_even_row"<%}%>>
						<td style="text-align: left">
							<a href="collection_tffam.jsp?tffamily_id=<%= collectionStat.getTfFamilyId()%>"><%= collectionStat.getTfFamilyName() %></a>
						</td>						
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