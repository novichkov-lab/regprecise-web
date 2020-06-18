<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@page import="java.util.List"%> 

<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.dto.CollectionStatDTO"%>
<%@page import="com.lbl.regprecise.dto.GenomeStatDTO"%>
<%@page import="com.lbl.regprecise.ent.Collection"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Regulon"%>
<%@page import="com.lbl.regprecise.ent.Genome"%>
<%@page import="com.lbl.regprecise.ent.PropagatedRegulon"%>


<%@page import="com.lbl.regprecise.ent.Term"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.web.Formatter"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int pgpCollectionid = Integer.parseInt(request.getParameter("pgp_collection_id")) ;
	int genomeId = Integer.parseInt(request.getParameter("genome_id")) ;
	
	Genome genome = dataProvider.getGenome(genomeId);  
	List<PropagatedRegulon> regulons  = dataProvider.getPropagatedRegulons(pgpCollectionid, genomeId);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Regulons of <%= genome.getName() %></title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
<link rel="stylesheet" type="text/css" href="styles/tabs.css" />
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 

		<div >
			<div class="introduction">
				<h1> Propagated regulons of <span class="titleItem"><i><%= genome.getName() %></i></span></h1> 
			</div>
			<div class="vspace_separator">								


			<div>
			<table class="stattbl" style="border-collapse: collapse">
				<caption></caption>
				<thead>
					<tr>					
						<th class="sup_column2" colspan="6"></th>
					</tr>					
					<tr>						
						<th >Type</th>
						<th style="text-align: left">Regulator</th>
						<th>Effector</th>
						<th>Pathway</th>
						<th>Genes</th>
						<th>Sites</th>
					</tr>
				</thead>
				<tbody>
					<%
						int i = 0;
						for (PropagatedRegulon regulon : regulons) {		
							int sitesCount = regulon.getPropagatedSites().size();
							if(sitesCount == 0 ) continue;
							i++;
							Regulog regulog = regulon.getRegulog();
							String regType = regulog.getRegulationTypeTermId() == Term.TERM_REGULATION_TYPE_TF ? "TF" : "RNA";							
					%>
					<tr <% if(i%2 ==0){%>class="tbl_even_row"<%}%>>
						<td> <span class="<%= regType %>" > <%= regType %> </span> </td>
						<td style="text-align: left"><a href="propagated_regulon.jsp?pg_regulon_id=<%= regulon.getId() %>"><%= regulog.getRegulatorName() %></a></td>
						<td style="text-align: left"> <%= Formatter.toNotNull(regulog.getEffectorNames()) %></td>
						<td style="text-align: left"> <%= Formatter.toNotNull(regulog.getPathwayNames())  %></td>				
					
						<td><%= regulon.getPropagatedGenes().size() %></td>						
						<td><%= sitesCount %></td>						
					</tr>
					<%
						}
					%>
			
				</tbody>
				</table>
			</div>
		</div>
		
		<div class="vspace_separator"></div>	
		<div class="vspace_separator"></div>	
								
		
	</div>
	<%@ include file="/footer.jsp" %>	
</div>
</body>
</html>