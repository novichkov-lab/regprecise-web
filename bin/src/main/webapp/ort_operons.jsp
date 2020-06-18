<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 
<%@page import="java.util.Collections"%> 

<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.dto.CollectionStatDTO"%>
<%@page import="com.lbl.regprecise.ent.Collection"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Regulon"%>
<%@page import="com.lbl.regprecise.ent.Operon"%>
<%@page import="com.lbl.regprecise.ent.Gene"%>
<%@page import="com.lbl.regprecise.ent.Ortholog"%>
<%@page import="com.lbl.regprecise.ent.Site"%>
<%@page import="com.lbl.regprecise.web.WebLinksProvider"%>
<%@page import="com.lbl.regprecise.web.Formatter"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();

	String val = null;

	int regulogId = -1;
	val = request.getParameter("project_id");
	if (val != null) {
		regulogId = Integer.valueOf(val);
	}

	int ortId = -1;
	val = request.getParameter("ort_id");	
	if (val != null) {
		ortId = Integer.valueOf(val);
	}
	
	Ortholog ortholog = dataProvider.getOrtholog(ortId);
	String ortName = ortholog.getName();
	
	Regulog regulog = dataProvider.getRegulog(regulogId);
	List<Regulon> regulons = regulog.getRegulons();
	Collections.sort(regulons);
	
	// to get access in block_logo.jsp
	request.setAttribute("regulog", regulog);  	
%>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title><%=regulog.getRegulatorName()%>: <%=regulog.getTaxonName()%></title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />

<style type="text/css">


#content{
	margin-left: 100px;
	margin-right: 100px;
}


#gmstattbl{
	width : 100%;
	font-size: 0.8em; 
	border: 1px dotted #CCC; 
}

th{
	text-align: left;
	text-weight: bold;
	border-bottom: 1px dotted #000;
}

#genetbl{
	font-size: 0.8em; 
	border: 1px dotted #CCC; 
}

#genetbl .firstgene{
	background-color: #9F5;
}

#genetbl .plus{
	background-color: #88BB88;
}

#genetbl .minus{
	background-color: #F5F5F5;
}

</style>
</head>
<body>

<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 

		
		<div class="introduction">
			<h1> Orthologous regulated operons containing <span class="titleItem"> <%= ortName%></span> gene</h1>
		</div>
 
		<%@ include file="/block_ortholog_properties.jsp" %>
		<%@ include file="/block_logo.jsp" %>		
		<div class="clear"></div> 	
		<div class="vspace_separator"></div>	 

		<table id="operontbl">
					<caption class="tbl_caption">Orthologous operons</caption>
					<thead>
						<tr>
							<th style="text-align: left">Operon</th>
							<th>Position</th>
							<th>Score</th>
							<th>Sequence</th>
							<th>Locus Tag of the First Gene</th>
						</tr>
					</thead>
					<tbody style="padding: 0; margin: 0;">

						<%
							for(Regulon regulon: regulons)
							{
								Gene gene = regulon.getOrtholohousGene(ortId);  
								if(gene == null) continue;
								Operon operon = gene.getOperon();
								if(!operon.hasSites()) continue;
						%>
										
						<tr>
							<td colspan="5" style="text-align: left; font-style: italic;">
								<%= regulon.getGenomeName() %>
							</td>
						</tr>

						<tr>
						<td colspan="5" style="text-align: left">
        				<div class="operon">
        				<% for( Site site: operon.getSites()){%>
							<div class="tooltip">
								<div class="site_img"></div>		
								<span> <%= ( 
											"Position: " + site.getRelativePosition() 
											+ "<br/>Score: " + site.getScore()
											+ "<br/>Sequence: " + Formatter.formatSiteSequence(site) 
											) 
										%>
								</span> 
							</div>        				
        				
        				<%}%>
        				<% for(Gene oGene: operon.getGenes()){ %>
							<div class="tooltip">
		        				<div class="gene_img"></div>
								<span> <%= ( 
											"Locus tag: " + oGene.getLocusTag() 
											+ "<br/>Name: " + oGene.getName()
											+ "<br/>Funciton: " + oGene.getFunction()
											) 
										%>
								</span> 
							</div>        				
		        				
        				<%}%>
        				</div>
        				</td>
						</tr>
 					   <%
 					   		boolean firstRI = true;
			   				boolean lastRI = false;
			   				int riIndex = 0; 					   
							for (Site site : operon.getSites()) {
								lastRI = (++riIndex >= operon.getSites().size());
								String href = null;
								if(firstRI)
								{
									href = WebLinksProvider.getMicrobesOnlineRefHTML(operon);									
								}									
						%>
						<tr>							
							<td <% if(lastRI){%>class="separator"<%}%> style="text-align: left"><%= (firstRI?operon.getName():"")%></td>
							<td class="separator"><%=site.getRelativePosition()%></td>
							<td class="separator"><%=Formatter.formatSiteScore( site.getScore() )%></td>
							<td class="sequence separator"><%= Formatter.formatSiteSequence(site) %></td>
							<td <% if(lastRI){%>class="separator"<%}%>>
								<%if(firstRI){ %>
									<%=  WebLinksProvider.getMicrobesOnlineRefHTML(operon) %></a>
								<%} %>								
							</td>
						</tr>
 						<%
 							firstRI = false;
							}
						%>
						<%
							}
						%>

					</tbody>
		</table>		
	</div>
	<%@ include file="/footer.jsp" %>	
</div>


</body>
</html>