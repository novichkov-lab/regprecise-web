<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.Regulon"%>
<%@page import="com.lbl.regprecise.ent.Operon"%>
<%@page import="com.lbl.regprecise.ent.Gene"%>
<%@page import="com.lbl.regprecise.ent.Site"%>
<%@page import="com.lbl.regprecise.web.WebLinksProvider"%>
<%@page import="com.lbl.regprecise.web.Formatter"%>

<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int operonId = -1;
	String val = request.getParameter("operon_id");
	if (val != null) {
		operonId = Integer.valueOf(val);
	}

    Operon operon = dataProvider.getOperon(operonId);
	Regulon regulon = operon.getRegulon();

%>

		<div class="introduction">
				<b>Operon in <span class="titleItem"><%= regulon.getGenomeName()%></span></b>
		</div>
		<br>
		<center>
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
        </center>
        <br>
		<table id="operontbl">
			<caption class="tbl_caption">Genes</caption>
			<thead>
				<tr>
					<th>Locus Tag</th>
					<th>Name</th>
					<th>Function</th>
				</tr>
			</thead>

		<%
			for(Gene gene: operon.getGenes()){ 
		%>
			<tr>
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
		</table>
