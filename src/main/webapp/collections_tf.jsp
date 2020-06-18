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
	List<CollectionStatDTO> collectionStats = dataProvider.getCollectionsStatDTO(Term.COLLECTION_TYPE_BY_REGULATOR);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Collections of regulogs classified by transcription factors</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 

		<div >
			<div class="introduction">
				<h1>Collections of regulogs classified by transcription factors</h1> 
 				<h2>
 					Each transcription factor collection organizes all reconstructed regulogs 
 					for a given set of orthologous regulators across different taxonomic groups of microorganisms. 
 					
 					These collections represent regulons for a <b>selected subset</b> of transcription factors.  
 					 					
 					The collections include both widespread transcription 
 					factors such as NrdR, LexA, and Zur, that are present in more than 25 diverse taxonomic 
 					groups of Bacteria, and narrowly distributed transcription factors such as Irr and PurR. 
 					
 					The TF regulon collections are valuable for comparative and evolutionary analysis 
 					of TF binding site motifs and regulon content for orthologous transcription factors.
 				</h2>
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
						<th style="text-align: left"> Transcription factors</th>
						<th>Regulogs</th>
						<th>TF regulons</th>
						<th>TF binding sites</th>
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
							<a href="collection_tf.jsp?collection_id=<%= collectionStat.getCollectionId()%>"><%= collectionStat.getCollectionName() %></a>
						</td>			
						
						<td><%= collectionStat.getTfRegulogCount()%></td>
						<td><%= collectionStat.getTfRegulonCount()%></td>
						<td><%= collectionStat.getTfSiteCount() %></td>
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