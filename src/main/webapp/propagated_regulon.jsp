<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>

<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.web.WebLinksProvider"%>
<%@page import="com.lbl.regprecise.web.Formatter"%>


<%@page import="com.lbl.regprecise.ent.PropagatedRegulon"%>
<%@page import="com.lbl.regprecise.ent.PropagatedGene"%>
<%@page import="com.lbl.regprecise.ent.PropagatedSite"%>
<%@page import="com.lbl.regprecise.ent.PropagatedGene2GeneOrtholog"%>
<%@page import="com.lbl.regprecise.ent.Ortholog"%>


<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Genome"%>
<%@page import="com.lbl.regprecise.ent.Operon"%>
<%@page import="com.lbl.regprecise.ent.Gene"%>
<%@page import="com.lbl.regprecise.ent.Site"%>



<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	
	int pgRegulonId = 0;
	String val = request.getParameter("pg_regulon_id");
	if (val != null) {
		pgRegulonId = Integer.valueOf(val);
	}
	
	
	PropagatedRegulon pgpRegulon = dataProvider.getPropagatedRegulon(pgRegulonId);
	Regulog regulog = pgpRegulon.getRegulog();
	request.setAttribute("pgpRegulon", pgpRegulon);
	request.setAttribute("regulog", regulog);
	
	List<PropagatedGene> pgpGenes = pgpRegulon.getPublicGenes();
	
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Propagation of <%= regulog.getRegulatorName()%> regulog to <%= pgpRegulon.getGenome().getName()%></title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
<style type="text/css">

#content{
	margin-left: 100px;
	margin-right: 100px;
}

h1 {
	font-size: 1em;
	border-bottom: 1px solid #AAA;
}

.support_regulog{
	border-left:  solid 50px #FFF;
	/*background: #EEE;*/		
	/*padding-left: 50px;*/
}

.no_reg{
	color: red; 
}

</style>

</head>
<body>
<div id="page">
	<%@ include file="/header.jsp"%>
	<div id="content">

		<div class="introduction">
				<h1>Propagation of <span class="titleItem"><%= regulog.getRegulatorName()%></span> regulog to <span class="titleItem"><%= pgpRegulon.getGenome().getName()%></span></h1>	
		</div>


		<%@ include file="/block_pgpregulon_properties.jsp" %>	
		<%@ include file="/block_logo.jsp" %>

		<div class="clear"></div> 	
		<div class="vspace_separator"></div>	
		

		<table id="operontbl" cellspacing="0">
					<caption class="tbl_caption">Predicted regulatory interactions in <i><%= pgpRegulon.getGenome().getName()%></i></caption>
					<thead>
						<tr>
							<th></th>
							<th style="text-align: left">Locus tag</th>
							<th>Position</th>
							<th>Score</th>
							<th>Sequence</th>
						</tr>
					</thead>
					<tbody style="padding: 0; margin: 0;">
						<%
							for(PropagatedGene pgpGene: pgpGenes){
								List<PropagatedSite> pgpSites = pgpGene.getPublicSites();
						%>
						<tr>
							<td colspan="5" style="text-align: left">					
        						<div class="operon">
        							<% for(PropagatedSite site: pgpSites){%>
									<div class="tooltip">
										<div class="site_img"></div>
										<span> <%= ( 
											"Position: " + site.getPosition()
											+ "<br/>Score: " +  Formatter.formatSiteScore(site.getScore())  
											+ "<br/>Sequence: " + site.getSequence()
											) %>
										</span> 
									</div>        				        				
        							<%}%>
									<div class="tooltip">
		        						<div class="gene_img"></div>
										<span> <%= ( 
											"Locus tag: " + pgpGene.getMoLocusTag()
											) %>
										</span> 
									</div>        						        				
        						</div>
															
							</td>
						</tr>							
 					   <%
 					   		boolean firstRI = true;
				   			boolean lastRI = false;
				   			int siteIndex = 0;
							for (PropagatedSite pgpSite: pgpSites) {
								siteIndex++;
								lastRI = (siteIndex >= pgpSites.size());
						%>
						
						<tr>							
							<td></td>
							<td style="text-align: left" <% if(lastRI){%>class=""<%}%>>
								<a href="<%= WebLinksProvider.getMicrobesOnlineRef(pgpGene.getMoLocusId())%>">
								<%= (firstRI?pgpGene.getMoLocusTag():"")%> </a>
							</td>
							<td ><%= pgpSite.getPosition()%></td>
							<td ><%= Formatter.formatSiteScore(pgpSite.getScore()) %></td>
							<td class="sequence "><%=pgpSite.getSequence()%></td>
						</tr>
 						<%
 							firstRI = false;
							}
						%>

						<tr class="support_regulog">
							<td colspan="5" style="text-align: left;  padding-bottom: 10px; padding-top: 30px">
								<span style="font-style:italic; color: #A00;">Supported by regulated orthologs from reference regulons</span>
								
							</td>
						</tr>
						<% 
								Ortholog ortholog =  null;
								if(pgpGene.getOrthologousGenes().size() > 0)
								{
									ortholog = pgpGene.getOrthologousGenes().get(0).getSourceGene().getOrtholog();
								}								 
						%>

						<tr class="support_regulog">
							<td colspan="5" style="text-align: left; ">
								<span style="font-weight:bold">Ortholog gene name:</span> <a href="ort_operons.jsp?project_id=<%= regulog.getId() %>&ort_id=<%= ortholog.getId() %>"><%= ortholog.getName() %></a> 
							</td>
						</tr>						
						<tr class="support_regulog">
							<td colspan="5" style="text-align: left; padding-bottom: 10px;">
								<span style="font-weight:bold">Ortholog function:</span>  <%= ortholog.getFunction() %>
							</td>
						</tr>						
						
						<%
							List<PropagatedGene2GeneOrtholog> orthhologousGenes =  pgpGene.getOrthologousGenes();
							for(PropagatedGene2GeneOrtholog ort: orthhologousGenes)
							{
								Operon operon = ort.getSourceGene().getOperon();
								if(!operon.hasSites()) continue;								
						%>

 					   <%
				   		int riIndex = 0;
				   		firstRI = true;
				   		lastRI = false;
						for (Site site : operon.getSites()) { 
							lastRI = (++riIndex >= operon.getSites().size());
						%>
						<tr>
							<td style="text-align: left" >
								<%if(firstRI){%>							
									<%= operon.getRegulon().getGenomeName() %>
								<%} %>
							</td>	
							<td style="text-align: left">
								<%if(firstRI){%>
									<%= WebLinksProvider.getMicrobesOnlineRefHTML(ort.getSourceGene())%>
								<%} %>							
							</td>
							<td class=""><%=site.getRelativePosition()%></td>
							<td class=""><%=Formatter.formatSiteScore( site.getScore() )%></td>
							<td class="sequence "><%=site.getSequence()%></td>
						</tr>
 						<%
 							firstRI = false;
							}
						%>

						<%}%>
						<tr>
							<td colspan="5" style="padding-bottom: 20px; border-bottom: solid 1px #AAA">
							</td>
						</tr>

						<%
						}
						%>
					</tbody>
		</table>
	</div>
	<%@ include file="/footer.jsp"%>
</div>
</body>
</html>