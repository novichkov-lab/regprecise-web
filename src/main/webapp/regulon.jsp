<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.dto.CollectionStatDTO"%>
<%@page import="com.lbl.regprecise.ent.Collection"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Regulon"%>
<%@page import="com.lbl.regprecise.ent.Operon"%>
<%@page import="com.lbl.regprecise.ent.Gene"%>
<%@page import="com.lbl.regprecise.ent.Site"%>
<%@page import="com.lbl.regprecise.web.WebLinksProvider"%>
<%@page import="com.lbl.regprecise.web.Formatter"%>



<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int regulonId = -1;
	String val = request.getParameter("regulon_id");
	if (val != null) {
		regulonId = Integer.valueOf(val);
	}

	Regulon regulon = dataProvider.getRegulon(regulonId);
	Regulog regulog = regulon.getRegulog();
	
	// to get access in block_logo.jsp
	request.setAttribute("regulon", regulon);
	request.setAttribute("regulog", regulog);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Regulon of <%= regulog.getRegulatorName()%> in <%= regulon.getGenomeName()%></title>
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
	

</style>

</head>
<body>

  <div class="gaggle-data" style="display:none">
   <p>name=<span class="gaggle-name"><%= regulon.getRegulog().getRegulatorName()%> regulon</span></p>
   <p>species=<span class="gaggle-species"> <%= regulon.getGenomeName()%></span></p>

   <p>(optional)size=<span class="gaggle-size"><%= regulon.getOperons().size()%></span></p>
   <div class="gaggle-namelist">
    <ol>
    <% for(Operon operon: regulon.getOperons()){%>
    <li><%= operon.getFirstGeneLocusTag() %></li>
     <%} %>
    </ol>
   </div>
  </div>

<div id="page">
	<%@ include file="/header.jsp"%>
	<div id="content">

		<div class="introduction">
				<h1>Regulon of <span class="titleItem"><%= regulog.getRegulatorName()%></span> in <span class="titleItem"><%= regulon.getGenomeName()%></span></h1>									
		</div>

		<%@ include file="/block_regulon_properties.jsp" %>	
		<%@ include file="/block_logo.jsp" %>
		<div class="clear"></div> 	
		<div class="vspace_separator"></div>	
		<%@ include file="/block_member_of_collections.jsp" %>						
		<div class="vspace_separator"></div>	


		<table id="operontbl">
			<caption class="tbl_caption">Regulated operons</caption>
			<thead>
				<tr>
					<th style="text-align: left" width="15%"></th>
					<th>Locus Tag</th>
					<th>Name</th>
					<th>Function</th>
				</tr>
			</thead>
		<%
			for(Operon operon: regulon.getOperons())
			{
				if(!operon.hasSites()) continue;
		%>
			<tr>
				<td colspan="4" style="text-align: left">
					<hr/>
					
        			<div class="operon">
        				<% for( Site site: operon.getSites()){%>
							<div class="tooltip">
								 <div class="site_img"></div>
								<span> <%= ( 
											"Position: " + site.getRelativePosition() 
											+ "<br/>Score: " +  Formatter.formatSiteScore(site.getScore())  
											+ "<br/>Sequence: " + Formatter.formatSiteSequence(site) 
											) 
										%>
								</span> 
							</div>        				
        				
        				<%}%>
        				<% for(Gene gene: operon.getGenes()){ %>
							<div class="tooltip">
		        				<div class="gene_img"></div>
								<span> <%= ( 
											"Locus tag: " + gene.getLocusTag() 
											+ "<br/>Name: " + gene.getName()
											+ "<br/>Funciton: " + gene.getFunction()
											) 
										%>
								</span> 
							</div>        				
		        				
        				<%}%>
        			</div>
															
				</td>
			</tr>		
		<% 
			for(Gene gene: operon.getGenes()){ 
		%>
			<tr>
				<td width="15%"></td>
				<td width=15% valign="top">
					<div class="showinfo"><%= WebLinksProvider.getMicrobesOnlineRefHTML(gene)%></div>
				</td>
				<td width=15% valign="top">
					
					<% if(gene.getName() != null) { %>
						<div class="showinfo"><%= gene.getName()%></div>	
					<% } %>
					
				</td>
				<td valign="top">
					<div class="showinfo" style="text-align: left"><%= gene.getFunction()%></div>
				</td>
			</tr>
		<% } %>
		<% } %>		
		</table>

		<div class="vspace_separator"></div>	
		<div class="vspace_separator"></div>	
					
		<table class="tblexport">
			<caption class="tbl_caption">Export</caption>
			<tr>
				<td valign=middle style="width:32px; height:40px;">
					<img src="images/txtlogo.gif" style="width:32px; height:32px; align:center;" />
				</td>
				<td>
					Regulated Genes
				</td>
				<td>
					[ Tab delimited format ]
				</td>
				<td>
					 <a href="ExportServlet?type=gene&regulonId=<%= regulon.getId()%>"><b>DOWNLOAD</b></a>  
				</td>
			</tr>
			<tr>
				<td valign=middle style="width:32px; height:40px;">
					<img src="images/fastalogo.png" style="width:32px; height:32px; align:center;" />
				</td>
				<td>
					Regulatory Sites
				</td>
				<td>
					[ FASTA format ]
				</td>
				<td>
					 <a href="ExportServlet?type=site&regulonId=<%= regulon.getId()%>"><b>DOWNLOAD</b></a>  
				</td>
			</tr>
		</table>	
		
	</div>
	<%@ include file="/footer.jsp"%>
</div>
</body>
</html>