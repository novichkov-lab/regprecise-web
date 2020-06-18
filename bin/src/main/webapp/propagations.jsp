<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 
<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.Term"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.dto.PropagatedCollectionStatDTO"%>
<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	List<PropagatedCollectionStatDTO> stats = dataProvider.getPropagatedCollectionStatsDTO();
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Collections of regulons reconstructed by conservative propagation</title>
<script type="text/javascript" src="js/base.js"></script>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 
			<div class="introduction">
				<h1>Collections of draft regulons reconstructed by <i>automated conservative</i> propagation</h1> 
				
 				<h2 class="text_description">
 					Reference TF regulogs manually curated in the selected subset of genomes from 14 taxonomic groups were used for large-scale annotation of regulatory interactions in all closely related genomes from the same taxa. The propagated regulons were obtained by an automated conservative propagation procedure and represents a large set of draft regulons. 
 					
		
					<span class="more"> <a href="javascript:void(0);" onclick="toggle_visibility('description_more');">more</a></span>
					<div id="description_more" class="hidden">
					To propagate a particular TF regulog to a target genome, we identified orthologs for both a TF gene and each of the previously described members of a reference TF regulog using the pre-computed ortholog groups in <a href="http://www.microbesonline.org">MicrobesOnline</a>. For the identified gene orthologs in target genomes, we perform search for candidate TFBSs in their upstream regions (from -350 to +50 bp relative to the start codon, excluding the coding regions of upstream genes). For search of putative binding sites we utilized a PWM that is associated with the reference regulog and was used for its original reconstruction. Each propagated regulon has one or more candidate regulated genes, their upstream binding sites, and, in most cases, an attributed orthologous TF. Moreover, we explicitly provide comparative genomics evidences supporting for each predicted regulatory interaction.  
					</div>
					 	 					
 				</h2>
			</div>
 			
			<div class="vspace_separator"></div>

			<div>
			<table class="stattbl">
				<caption></caption>
				<thead>
					<tr>
						<th class="sup_column2" colspan="3">Template (reference) regulons</th>
						<th class="sup_column1"  colspan="4">Propagated regulons</th>
					</tr>						
					
					<tr>						
						<th style="text-align: left">Regulog collection</th>
						<th>Genomes</th>
						<th>TF regulons</th>
						<th></th>
						<th style="text-align: left">Taxonomic group</th>
						<th>Genomes</th>
						<th>TF regulons</th>
					</tr>
				</thead>
				<tbody>
					<%
						int i = 0;
						for (PropagatedCollectionStatDTO stat : stats) {
							i++;
					%>
					<tr <% if(i%2 ==0){%>class="tbl_even_row"<%}%>>
						<td style="text-align: left">
							<a href="collection_tax.jsp?collection_id=<%= stat.getSourceRegulogCollectionId()%>"><%= stat.getSourceRegulogCollectionName()%></a>
						</td>						
						<td><%= stat.getSourceGenomeCount() %> </td>
						<td><%= stat.getSourceRegulonCount() %> </td>
						<td>&#10144;</td>
						<td style="text-align: left">
							<a href="propagated_collection.jsp?pg_collection_id=<%= stat.getPropagatedCollectionId()%>"><%= stat.getTargetTaxonName() %></a>
						</td>						
						<td><b><%= stat.getTargetGenomeCount() %></b></td>
						<td><b><%= stat.getTargetRegulonCount() %></b></td>

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