<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 
<%@page import="java.util.Hashtable"%> 


<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.dto.CollectionStatDTO"%>
<%@page import="com.lbl.regprecise.dto.RegulonStatDTO"%>
<%@page import="com.lbl.regprecise.dto.GenomeStatDTO"%>

<%@page import="com.lbl.regprecise.ent.Collection"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Regulon"%>
<%@page import="com.lbl.regprecise.ent.Genome"%>
<%@page import="com.lbl.regprecise.ent.Term"%>


<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int collectionId = 1;
	String val = request.getParameter("collection_id");
	if (val != null) { 
		collectionId = Integer.valueOf(val);
	}
	
	CollectionStatDTO collectionStat = dataProvider.getCollectionStatDTO(collectionId);
	request.setAttribute("genomesCount", collectionStat.getTotlaGenomeCount().intValue());   
	request.setAttribute("tfRegulogsCount", collectionStat.getTfRegulogCount().intValue());
	request.setAttribute("tfRegulonsCount", collectionStat.getTfRegulonCount().intValue());
	request.setAttribute("tfSitesCount", collectionStat.getTfSiteCount().intValue());
	
	request.setAttribute("rnaRegulogsCount", collectionStat.getRnaRegulogCount().intValue());
	request.setAttribute("rnaRegulonsCount", collectionStat.getRnaRegulonCount().intValue());
	request.setAttribute("rnaSitesCount", collectionStat.getRnaSiteCount().intValue());
		
	
	Collection cl = dataProvider.getCollection(collectionId); 
	List<Genome> genomes =  cl.getGenomes(); 
	List<Regulog> regulogs = dataProvider.getRegulogs(cl.getId());	
		
	Regulog.sortByRegtypeFamilyRegnameTaxonomy(regulogs); 			
	Hashtable<Integer, Hashtable<Integer, RegulonStatDTO>> regulonsHash = dataProvider.getRegulonStatsDTOHash(collectionId);
	
	List<GenomeStatDTO> genomeStats = dataProvider.getGenomeStatsDTO(collectionId, true);	
	
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Collection of regulogs in the <%=cl.getName()%> taxonomic group</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />

<style type="text/css">

#content{
	margin-left: 50px;
	margin-right: 50px;
}
</style>

</head>
<body>
<div id="page">

	<%@ include file="/header.jsp" %>	
	<div id="content"> 
		<div>
			<div class="introduction">
				<h1>Collection of regulogs in <span class="titleItem"><%=cl.getName()%></span> taxonomic group</h1>

 

				<div style="float: right; margin: 1em 0 20px 0;">  
					<%@ include file="/block_general_stat_table.jsp" %>
				</div>
				<h2 class="text_description" style="margin-right: 300px;">
					This collection involves all regulons that were tentatively predicted by applying integrative comparative genomic approach to a single taxonomic group of closely-related genomes. To infer the regulons operated by transcription factors (TFs), we combined the identification of TF binding sites and cross-genome comparison of regulons with the analysis of the genomic and functional context of candidate target genes. To infer the regulons operated by regulatory RNAs such as riboswitches, we identified candidate RNA regulatory elements using HMM profiles and further analyzed their genomic and functional context.				
				 </h2>
				
				<div class="clear"></div>
			</div> 

			<div class="vspace_separator"></div>		
			
			<table class="stattbl"> 
				<caption class="tbl_caption">Studied genomes and reconstructed regulon statistics</caption>
				
				
				<thead>
					<tr>					
						<th class="sup_column2"></th>
						<th class="sup_column1" colspan="2">TF</th>
						<th class="sup_column1" colspan="2">RNA</th>
						<th class="sup_column1" colspan="2">Total</th>
					</tr>										
					<tr>						
						<th style="text-align: left">Genomes</th>
						<th>Regulons</th>
						<th>Sites</th>
						<th>Regulons</th>
						<th>Sites</th>
						<th>Regulons</th>
						<th>Sites</th>
					</tr>
				</thead>
				<tbody>
						<%
							int i = 0;
							for (GenomeStatDTO genomeStat : genomeStats) {
								//genome = URLEncoder.encode(genome);
						%>						
						<tr <% if(i++%2 ==0){%>class="tbl_even_row"<%}%>>
							<td style="text-align: left">
								<a href="genome.jsp?genome_id=<%= genomeStat.getGenomeId() %>"><%= genomeStat.getGenomeName() %></a>								
							</td>
							<td><%= genomeStat.getTfRegulonCount() %></td>
							<td><%= genomeStat.getTfSiteCount() %></td>
							<td><%= genomeStat.getRnaRegulonCount() %></td>
							<td><%= genomeStat.getRnaSiteCount() %></td>
							<td><%= genomeStat.getTotalRegulonCount() %></td>
							<td><%= genomeStat.getTotalSiteCount() %></td>
						</tr>
						<%}%>
				</tbody>											
			</table>
 
			<div class="vspace_separator"></div>	
			<div>
			

			<table id="regtbl" cellpadding="1" cellspacing="2" width="100%">
				<caption class="tbl_caption">Genomic distribution of regulons</caption>
				<thead>
					<tr>						
						<th scope="col" rowspan="1" class="datacol" style="text-align: left; vertical-align: bottom;">Family</th>
						<th scope="col" rowspan="1" class="datacol" style="text-align: center; vertical-align: bottom;">Type</th>
						<th scope="col" rowspan="1" class="datacol" style="text-align: left; vertical-align: bottom;">Regulator</th>
						<%
							for (Genome genome : genomes) {
						%>
 							<th scope="col" width="20" class="datacol"><img src="ImageGenomeNameServlet?genomeId=<%=genome.getId()%>" /> </th>
 
						<%
							}
						%>
						<th scope="col" rowspan="1" class="datacol" style="text-align: left; vertical-align: bottom; padding-left: 15px;">Function</th>
					</tr>
				</thead>
				<tbody>
					<%
						String family = "";
						int familyIndex = 0;
						boolean sepRequired = false;
						for (Regulog regulog : regulogs) {
							String curFamily = regulog.getRegulatorFamily();												
							if(curFamily.equals(family))
							{
								curFamily = "";
								sepRequired = false;
							} 
							else {
								family = curFamily;
								sepRequired = (familyIndex > 0);
								familyIndex++;
							}
							
							String regType = regulog.getRegulationTypeTermId() == Term.TERM_REGULATION_TYPE_TF ? "TF" : "RNA"; 
					%>
					<tr>
						<td  <%if(sepRequired){%>class="sep"<%}%> style="text-align: left;"><%=curFamily%></td>
						<td  <%if(sepRequired){%>class="sep"<%}%>> <span class="<%= regType %>" > <%= regType %> </span> </td>						
						<td  <%if(sepRequired){%>class="sep"<%}%> style="text-align: left;">
						<a href="regulog.jsp?regulog_id=<%= regulog.getId() %>"> <%=regulog.getRegulatorName()%></a></td>
						<%
							for (Genome genome : genomes) {
									RegulonStatDTO regulonStat = null;
									Hashtable<Integer, RegulonStatDTO> gmId2Stat = regulonsHash.get(regulog.getId());
									if(gmId2Stat != null )
									{
										regulonStat = gmId2Stat.get(genome.getId());	
									}
									
									boolean hasGenome = (regulonStat != null && regulonStat.getOperonsWithSiteCount()  > 0); 
						%>

						<% if(hasGenome){ %>
						<td class="plus">
							<div class="tooltip"> 
							<a href="regulon.jsp?regulon_id=<%= regulonStat.getRegulonId() %>"> 
								<%= regulonStat.getOperonsWithSiteCount() %>  
							</a>
								<span><%= regulog.getRegulatorName() %> <br></br> <i><%=  genome.getName()%></i></span> 
							</div>
						</td>
						<%} else if(regulonStat != null) {%>
						<td class="minus"></td>
						<%} else  {%>
						<td class="nodata"></td>
						<%} %>


						<%
							}
						%>
						<td <%if(sepRequired){%>class="sep"<%}%> style="text-align: left; padding-left: 15px; "><%=regulog.getPathwayNames()%></td>
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