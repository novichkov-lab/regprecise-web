<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 
<%@page import="java.util.Collections"%> 

<%@page import="java.net.URLEncoder"%>

<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.dto.CollectionStatDTO"%>
<%@page import="com.lbl.regprecise.ent.Collection"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Regulon"%>
<%@page import="com.lbl.regprecise.ent.Genome"%>
<%@page import="com.lbl.regprecise.ent.Cron"%>
<%@page import="com.lbl.regprecise.ent.Ortholog"%>
<%@page import="com.lbl.regprecise.ent.Gene"%>
<%@page import="com.lbl.regprecise.ent.Term"%>
<%@page import="com.lbl.regprecise.ent.Riboswitch"%>
<%@page import="com.lbl.regprecise.ent.TFFamily"%>
<%@page import="com.lbl.regprecise.ent.Pathway"%>
<%@page import="com.lbl.regprecise.ent.Effector"%>

<%@page import="com.lbl.regprecise.web.Formatter"%>
<%@page import="com.lbl.regprecise.web.OrthologMap"%>
<%@page import="com.lbl.regprecise.web.ColorProvider"%>
<%@page import="com.lbl.regprecise.web.WebLinksProvider"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int regulogId = 1;
	String val = request.getParameter("regulog_id");
	if (val != null) {
		regulogId = Integer.valueOf(val);
	}

	Regulog regulog = dataProvider.getRegulog(regulogId); 
	List<Regulon> regulons = regulog.getRegulons();
	ColorProvider colorProvider = new ColorProvider();
	Riboswitch riboswitch = regulog.getRiboswitch();
	TFFamily tfFamily = regulog.getTfFamily();	
	
	// to get access in block_logo.jsp
	request.setAttribute("regulog", regulog);   
%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<title><%=regulog.getRegulatorName()%>: <%=regulog.getTaxonName()%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
	<link rel="shortcut icon" href="images/favicon.ico" />
	<link rel="stylesheet" type="text/css" href="styles/base.css" />

	<style type="text/css">
		#content{
			margin-left: 100px;
			margin-right: 100px;
		}	
	</style>
</head>
<body>
	<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content">
		
		<div class="introduction">
			<h1>
				Regulog 
				<span class="titleItem">
					<%=regulog.getRegulatorName()%> - <%= regulog.getTaxonName() %>
				</span>
			</h1>
		</div>

		<%@ include file="/block_regulog_properties.jsp" %>
		<%@ include file="/block_logo.jsp" %>
		
		<div class="clear"></div> 	
		<div class="vspace_separator"></div>	 

		<%@ include file="/block_member_of_collections.jsp" %>
		<div class="vspace_separator"></div>	 

		<table class="stattbl">
			<caption class="tbl_caption">Statistics of regulated genes</caption> 
				<thead>
					<tr>					
						<th style="text-align: left;">Genome</th>
						<th>Genes</th>
						<th>Operons</th>
					</tr>
				</thead>
				<tbody>
				<%
				int i = 0;
				for (Regulon regulon : regulons) {
				%>				
					<tr <% if(i++%2 ==0){%>class="tbl_even_row"<%}%>>
						<%
						if (regulon.getSites().size() > 0) {
						%> 
						<td style="text-align: left;"><a href="regulon.jsp?regulon_id=<%= regulon.getId() %>"><%=regulon.getGenomeName() %></a></td>
						<td><%= regulon.getRegulatedGenes().size() %></td>
						<td><%= regulon.getRegulatedOperons().size()  %></td>
						<%
						} else {
						%>
						<td style="text-align: left;"><%=regulon.getGenomeName()%></td> 
						<td></td>
						<td></td>
						<%}%>
					</tr>
				<%}%>
				</tbody>
		</table>
			
		<div class="vspace_separator"></div>
<!-- 		<div class="tbl_caption" style="font-size:0.8em;margin-bottom:5px;">Clusters of co-Regulated Orthologous operoNs (CRONs) </div> -->
		<table id="crontbl">
			<caption class="tbl_caption">Clusters of co-Regulated Orthologous operoNs (CRONs)</caption> 
		
				<thead>
					<tr>
						<th style="text-align: left; vertical-align: bottom; padding-right: 15px;">Genes</th>
						<%
						for (Regulon regulon : regulons) {
						%>
<!-- 						<th> <span class="rotate270" > <%= "G" %></span></th> -->
												
 						<th scope="col" width="20" class="datacol"><img src="ImageGenomeNameServlet?genomeId=<%= regulon.getGenome().getId()%>" /> </th> 
						<%}%>
						<th style="text-align: left; vertical-align: bottom; padding-right: 15px;">Function</th>
					</tr>
				</thead>
				<tbody>
					<%
						int cronIndex = 1;
						for(Cron cron :regulog.getCrons())
						{
							colorProvider.init();
							OrthologMap ortMap = new OrthologMap(colorProvider, regulons, cron);
					%>
					<tr >
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan=<%= ortMap.getColumnCount() + 2 %> style="font-size:0.8em;border-bottom: 1px solid #000;">CRON <%= (cronIndex++)%>.</td>
					</tr>
					
					<%		
							for(int rowIndex = 0; rowIndex < ortMap.getRowCount(); rowIndex++)
							{ 
								if(! ortMap.hasRegulatedGenes(rowIndex)) continue;	
								Ortholog ortholog = ortMap.getOrtholog(rowIndex);
								String ortName = ortholog.getName();
					%>
					
					<tr>
						<td style="padding-right: 30px;border-bottom: 1px dotted #CCC;border-top: 1px dotted #CCC;">
							<a href="ort_operons.jsp?project_id=<%= regulog.getId()%>&ort_id=<%= ortholog.getId()%>"><%= ortName%></a> 
						</td>
						<%
						for(int columnIndex = 0; columnIndex < ortMap.getColumnCount(); columnIndex++)
						{		
							Regulon regulon = regulons.get(columnIndex);
							String operonColor = "#EEE";
							String geneLabel = "&nbsp;";
							List<Gene> genes = ortMap.getGenes(rowIndex, columnIndex);
							if(genes != null)
							{
								//geneLabel = "" + ( gene.getOperonIndex() + 1);
								if(ortMap.hasSites(rowIndex, columnIndex)) {
									geneLabel = "*";
								}
								//geneLabel = "" + gene.getOperon().getId() + ":" + ( gene.getOperonIndex() + 1);
								if(genes.size() > 1) geneLabel += genes.size();
								
								operonColor = ortMap.getOperonColor(rowIndex, columnIndex);
							}
						%>
						
						<td style="color:yellow; background:<%= operonColor%>;">
							<div class="tooltip" style="text-align:left;">
								<div style="text-align:center;"><%= geneLabel%></div>
								 
								<span><i><%=  regulon.getGenomeName()%></i>  <%= ortMap.getItemHTML(rowIndex,columnIndex) %> </span> 
							</div>
							 
						</td>	
						<%}%>	
						<td> <%= Formatter.toNotNull(ortholog.getFunction()) %></td>					
					</tr>
					
					<%			
							}
					%>
						
					<%		
						}
					%>
				</tbody>
		</table>
		
		<div class="vspace_separator"></div>		
		
		<div class="footnote" style="margin-top: 10px" >
			Bluish color  - the gene is in regulated operon. Different regulated operons are shown in different shades of blue.
		</div> 		
		<div class="footnote">
			Red color  - the gene is in non-regulated operon.
		</div> 		
		<div class="footnote">
			Gray color  - the orthologous gene is absent.
		</div> 		
		<div class="footnote">
			The star symbol - the TFBS is located in upstream region of this gene.
		</div> 		
		<div class="footnote">
			The number - the numeber of homologs (shown only if it is greater than one).
		</div>
		 		
		 		
		<div class="vspace_separator"></div>	
		<div class="vspace_separator"></div>	
					
		<table class="tblexport">
			<caption class="tbl_caption">Export</caption>
			<tr>
				<td>
					<img src="images/txtlogo.gif" style="width:32px; height:32px; align:center;" />
				</td>
				<td>
					Regulated Genes
				</td>
				<td>
					[ Tab delimited format ]
				</td>
				<td>
					 <a href="ExportServlet?type=gene&regulogId=<%= regulog.getId()%>"><b>DOWNLOAD</b></a>  
				</td>
			</tr>
			<tr>
				<td>
					<img src="images/fastalogo.png" style="width:32px; height:32px; align:center;" />
				</td>
				<td>
					Regulatory Sites
				</td>
				<td>
					[ FASTA format ]
				</td>
				<td>
					 <a href="ExportServlet?type=site&regulogId=<%= regulog.getId()%>"><b>DOWNLOAD</b></a>  
				</td>
			</tr>
		</table>	
		 		
		 		
		 		
	</div>
	<%@ include file="/footer.jsp" %>
	</div>
</body>
</html>