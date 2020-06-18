<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>

<%@page import="com.lbl.regprecise.ent.PropagatedCollection"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Genome"%>
<%@page import="com.lbl.regprecise.dto.PropagatedRegulonStatDTO"%>
<%@page import="com.lbl.regprecise.dto.PropagatedCollectionStatDTO"%>
<%@page import="com.lbl.regprecise.dto.PropagatedGenomeStatDTO"%>

<%
	int prpCollectionId = 1;
	String val = request.getParameter("pg_collection_id");
	if (val != null) {
		prpCollectionId = Integer.valueOf(val);
	}

	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	
	PropagatedCollection pgpCollection = dataProvider.getPropagatedCollection(prpCollectionId);
	HashSet<Integer> refGenomeIds = new HashSet<Integer>();
	for(Genome genome: pgpCollection.getCollection().getGenomes()){
		refGenomeIds.add(genome.getId());
	}

	List<Regulog> pgpRegulogs = new ArrayList<Regulog>();
	
	List<Genome> pgpGenomes = new ArrayList<Genome>();
	dataProvider.populatePropagatedLists(prpCollectionId, pgpRegulogs, pgpGenomes);	
	Hashtable<Integer,Hashtable<Integer,PropagatedRegulonStatDTO>> pgpRegulons 
		= dataProvider.getRegulogId2GenomeId2PropagatedRegulonStatDTOHash(prpCollectionId);
	
	PropagatedCollectionStatDTO stat = dataProvider.getPropagatedCollectionStatDTO(prpCollectionId);
	
	List<PropagatedGenomeStatDTO> genomeStats = dataProvider.getPropagatedGenomeStatsDTO(prpCollectionId);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Propagations</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
<style type="text/css">

.gene_reg{
	background-color: #9F5;
	color: black;
	text-align:center;
}

.gene_noreg{
	background-color: #F5F5F5;
	text-align:center;
}

.nogene_reg{
	background-color: #9F5;
	color: white;
	text-align:center;
}

.nogene_noreg{
	background-color: #F5F5F5;
	color: #F5F5F5;
	text-align:center;	
}

.genome_name{
	text-align:left;
	border-bottom: 1px dotted #CCC;
	font-size: 0.9em; 
}



</style>
</head>
<body>

<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 


			<div class="introduction">
				<h1>Draft regulons reconstructed by automated <i>conservative</i> propagation</h1>

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
					<tr >
						<td style="text-align: left">
							<a href="collection_tax.jsp?collection_id=<%= stat.getSourceRegulogCollectionId()%>"><%= stat.getSourceRegulogCollectionName()%></a>
						</td>						
						<td><%= stat.getSourceGenomeCount() %> </td>
						<td><%= stat.getSourceRegulonCount() %> </td>
						<td>&#10144;</td>	
						<td style="text-align: left">
							<%= stat.getTargetTaxonName()%>
						</td>
											
						<td><b><%= stat.getTargetGenomeCount() %> </b></td>
						<td><b><%= stat.getTargetRegulonCount() %> </b></td>
					</tr>
				</tbody>
				</table>
			</div>
			
 			<div class="vspace_separator"></div>
			
			<table class="stattbl"> 
				<caption class="tbl_caption">Studied genomes and reconstructed regulon statistics</caption>
				<thead>
					<tr>						
						<th></th>
						<th style="text-align: left">Genomes</th>
						<th>Regulons</th>
						<th>Sites</th>
					</tr>
				</thead>
				<tbody>
						<%
							int i = 0;
							for (PropagatedGenomeStatDTO genomeStat : genomeStats) {
								//genome = URLEncoder.encode(genome);
						%>						
						<tr <% if(i++%2 ==0){%>class="tbl_even_row"<%}%>>
							<td style="color: #A00; width: 0px">
								<%= (refGenomeIds.contains(genomeStat.getGenomeId()) ? "*" : "") %>
							</td>
							<td style="text-align: left">
								<a href="propagated_genome.jsp?pgp_collection_id=<%= prpCollectionId%>&genome_id=<%= genomeStat.getGenomeId() %>"><%= genomeStat.getGenomeName() %></a>								
							</td>
							<td><%= genomeStat.getRegulonCount() %></td>
							<td><%= genomeStat.getSiteCount() %></td>
						</tr>
						<%}%>
				</tbody>											
			</table>
			<div class="vspace_separator"></div>	
			<table cellpadding="1" cellspacing="2" width="100%">			
				<tbody style="font-size: 0.9em">
						<tr>
							<td style="color: #A00">*</td>
							<td style="text-align: left"> - reference regulons from this genome have been used as a template for the conservative propagation</td>
						</tr>
				</tbody>
			</table>
 
			<div class="vspace_separator"></div>	
			
			
			
			<div id="data">

			<div class="tbl_caption" style="margin-bottom:5px;">Genomic distribution of propagated regulons</div>
			
 			<div class="vspace_separator"></div>
 			<div style="overflow: auto; scrollbar-base-color:#ffeaff">
			<table cellpadding="1" cellspacing="2" >
				<thead>
					<tr>						
						<th scope="col" rowspan="1" style="text-align: left; vertical-align: bottom; border: 0; border-bottom: 1px solid #CCC;">Reference regulog</th>
						<%
							for (Genome genome : pgpGenomes) {
								int reference = refGenomeIds.contains(genome.getId()) ? 1 : 0;
						%>
 						<th scope="col" width="20" class="datacol" style="border: 0; border-bottom: 1px solid #CCC;"><img src="ImageGenomeNameServlet?genomeId=<%=genome.getId()%>&selected=<%= reference %>" /> </th>
 
						<%
							}
						%>						
					</tr>
				</thead>
				<tbody>
					<%
						for(Regulog regulog: pgpRegulogs)
						{
							Hashtable<Integer,PropagatedRegulonStatDTO> pgpRegulogRegulons = pgpRegulons.get(regulog.getId());
					%>
					<tr>
						<td class="genome_name" style="text-align: left;">
						<a href="regulog.jsp?regulog_id=<%= regulog.getId() %>"> <%=regulog.getRegulatorName()%></a></td>
						<%
							for (Genome genome: pgpGenomes) {
								PropagatedRegulonStatDTO regulon = pgpRegulogRegulons.get(genome.getId());
								if(regulon == null) {
									out.print("<td></td>");
									continue;
								}
								boolean hasGenome = false;
						%>
						
						<% if(regulon.getGeneCount() > 0) {%>
						<td class="<%= (regulon.getRegulatorCount() >0 ? "gene_reg" : "gene_noreg") %>">
							<div class="tooltip">
							<a href="propagated_regulon.jsp?pg_regulon_id=<%= regulon.getPropagatedRegulonId() %>"><%= regulon.getGeneCount() %>	
							</a> <span><%= regulog.getRegulatorName() %> <br></br> <i><%=  genome.getName()%></i></span>
							</div> 														
						</td>
						<%} else {%>
						<td class="<%= (regulon.getRegulatorCount() > 0 ? "nogene_reg" : "nogene_noreg") %>">-</td>
						<%} %>

						<%
							}
						%>
					</tr>
					<%
						}
					%>
			
				</tbody>
				</table>
				<div class="vspace_separator"></div>
				</div>
				
			<span style="font-weight:bold;font-size: 0.9em;">-- Legend --</span>
			<table cellpadding="1" cellspacing="2" width="100%">			
				<tbody style="font-size: 0.9em">
						<tr>
							<td class="gene_reg">5</td>
							<td style="text-align: left"> Orthologous regulator is detected and five members of regulon are predicted in a target genome</td>
						</tr>
						<tr>
							<td class="nogene_reg">-</td>
							<td style="text-align: left"> Orthologous regulator is detected in a target genome but no potential members of regulon where identified</td>
						</tr>
						<tr>
							<td class="gene_noreg">3</td>
							<td style="text-align: left"> Three potential members of regulon were found, but orthologous regulator could not be detected in a target genome. </td>
						</tr>
						<tr>
							<td class="nogene_noreg">3</td>
							<td style="text-align: left"> Neither orthologous regulator no potential members of regulon were found in a target genome</td>
						</tr>

				</tbody>
			</table>
	</div>
	
	</div>
	<%@ include file="/footer.jsp" %>	
</div>
</body>
</html>