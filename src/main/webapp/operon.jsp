<%-- <%@ page errorPage="error.jsp" %>
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
<%@page import="com.lbl.regprecise.ent.Site"%>
<%@page import="com.lbl.regprecise.ent.Ortholog"%>
<%@page import="com.lbl.regprecise.ent.Gene"%>
<%@page import="com.lbl.regprecise.web.WebLinksProvider"%>
<%@page import="com.lbl.regprecise.web.Formatter"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.web.Util"%>
<%@page import="com.lbl.regprecise.web.SubRegulon"%>
<%@page import="com.lbl.regus.util.PhylogeneticTree"%>

<%@page import="java.awt.Toolkit"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Hashtable" %>
<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int operonId = -1;
	String val = request.getParameter("operon_id");
	if (val != null) {
		operonId = Integer.valueOf(val);
	}

	System.out.println("operonId = " + operonId);
	
	Operon _operon = dataProvider.getOperon(operonId);
	
	System.out.println("operon = " + _operon.getName());
	Regulon regulon = _operon.getRegulon();
	Regulog regulog = regulon.getRegulog();
	
	// to get access in block_logo.jsp
	request.setAttribute("regulon", regulon);
	request.setAttribute("regulog", regulog);
	
//	int hswidth = Toolkit.getDefaultToolkit().getScreenSize().width;
	int hswidth = 500;
	//ConstrainedDataProvider dp = DataProviderHelper.getDataProvider();
	//Regulon regulon = dp.getRegulon(7851);

	Util util = new Util();
	PhylogeneticTree regulogTree = util.getRegulogTree(regulon.getRegulog().getId());
	
	
%>
 --%>
<%-- 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Experimentaly validated predictions</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>

<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 
		<div id="sidebar">
			sidebar area
		</div>
		<div id="mainarea">
			<div class="introduction">
				<h1>Header</h1> 
			</div>
			<div id="data">

							<td bgcolor=#f8f8fa style="border:0px solid #ccc; padding:20px 20px 20px 5px;">
								<center><h1>Supportive Evidence from Gomparative Genomics for Operon </h1></center>
								<p><br /></p>
								<%
									List<SubRegulon> subRegs = util.getOrthologousOperons(_operon);
									util.sortSubRegulons(regulogTree, subRegs);
								%>
								<div class="tblinfo" style="width=100%">
								<table width=100% bgcolor=white style="border: 1px dotted #ccc;">
									<tr>
										<td style="padding:10px;">
											<h1>Genomics Context</h1>
										</td>
									</tr>
									<tr>
										<td>
											<div class="horizscroll" style="width:<%= Math.floor(hswidth*.65) %>px;">
											<table border=0 style="margin: 0; padding: 0; spacing: 0; border-collapse: collapse;">
												<tr>
													<td width=100>
														<%
															int ID = regulon.getRegulog().getId();
															int height = 38*subRegs.size();
														%>
														<img src="ImageServlet?width=100&height=<%=height%>&id=<%=ID%>" />
													</td>
													<td>			
														<table style="width:<%=util.getTableWidth(subRegs)%>px;">
														<%
															Hashtable<Ortholog, String> colortable = util.getOrthologsColor(subRegs);
															for(SubRegulon subRegulon: subRegs)
															{
																if(subRegulon.getOperons().size() > 0) {
														%>
															<tr>
															<%
																if((subRegulon.getGenomeName()).equals(regulon.getGenomeName())) {
															%>
																<td colspan="2" style="background-color: #dfe8f6; border: 1px solid #0000ff; color: #000000; width: 100%;">
																	<table width=100% style="margin: 0px; spacing: 0px; padding: 0px;">
																		<tr>
																			<td	style="width:<%= Util.getFIXED_TABLE_WIDTH()%>px; padding-top: 5px; padding-bottom: 5px; margin: 0; spacing: 0; border-collapse: collapse; font-family: verdana, arial, sans-serif; font-size: .8em; width: 40%;">
																				<%=subRegulon.getGenomeName()%>
																			</td>
																			<td style="padding-top: 5px; padding-bottom: 5px; margin: 0; spacing: 0; border-collapse: collapse; font-family: verdana, arial, sans-serif; font-size: .8em;">
																				<% for(Operon operon: subRegulon.getOperons()) {%>
																				<div class="operondiv" style="bgcolor:#ffffff;">
																					<% for(Site s: operon.getSites()) {%>
																					<img src="images/site_orange.png" class="siteimg" />
																					<% } %>
																					<% for(Gene gene: operon.getGenes()) {
																						Ortholog testOrtholog = gene.getOrtholog();
																						if(colortable.containsKey(testOrtholog)) {%>
																							<div class="coloredgene" style="width:<%= util.getGenePixelLength(gene) %>px; background-color:<%= colortable.get(testOrtholog) %>;">
																								<% if(gene.getName() == null) { %>
																									<% } else { %>
																									<span><%= gene.getName()%><br /> <% } %>
																									<b><%= gene.getLocusTag() %></b><br />
																									<%= gene.getFunction() %></span>
																							</div>
																							<%}	else { %>
																								<div class="blankgene" style="width:<%= util.getGenePixelLength(gene) %>px;">
																								<% if(gene.getName() == null) { %>
																									<% } else { %>
																									<span><%= gene.getName()%><br /> <% } %>
																									<b><%= gene.getLocusTag() %></b><br />
																									<%= gene.getFunction() %></span>
																								</div>
																						<% } %>																					
																					<% } %>
																				</div>
																				<% } %>
																			</td>
																		</tr>
																	</table>
																</td>
																<% } else { %>
																<td style="width:<%=Util.getFIXED_TABLE_WIDTH()%>; border-top: 1px solid #9a9a9a; padding-top: 5px; padding-bottom: 5px; margin: 0; spacing: 0; border-collapse: collapse; font-family: verdana, arial, sans-serif; font-size: .8em; width: 40%;">
																	<%=subRegulon.getGenomeName()%>
																</td>
																<td style="border-top: 1px solid #9a9a9a; padding-top: 5px; padding-bottom: 5px; margin: 0; spacing: 0; border-collapse: collapse; font-family: verdana, arial, sans-serif; font-size: .8em;">
																	<% for(Operon operon: subRegulon.getOperons()) {%>
																	<div class="operondiv">
																		<% for(Site s: operon.getSites()) {%>
																		<img src="images/site_orange.png" class="siteimg" />
																		<% } %>
																		<% for(Gene gene: operon.getGenes()) {
																			Ortholog testOrtholog = gene.getOrtholog();
																			if(colortable.containsKey(testOrtholog)) {%>
																				<div class="coloredgene" style=" width:<%= util.getGenePixelLength(gene) %>px; background-color:<%= colortable.get(testOrtholog) %>;">
																					<% if(gene.getName() == null) { %>
																					<span> <% } else { %>
																					<span><%= gene.getName()%><br /> <% } %>
																					<b><%= gene.getLocusTag() %></b><br />
																					<%= gene.getFunction() %></span>
																				</div>
																				<% } else { %>
																				<div class="blankgene" style="width:<%= util.getGenePixelLength(gene) %>px;">
																				<% if(gene.getName() == null) { %>
																				<span> <% } else { %>
																				<span><%= gene.getName()%><br /> <% } %>
																				<b><%= gene.getLocusTag() %></b><br />
																				<%= gene.getFunction() %></span>
																				</div>
																				<% } %>
						
																			<% } %>
																	</div>
																	<% } %>
																</td>
																<% } %>
															</tr>
															<% } else{ %> 
															<tr>
																<td style="color:#9a9a9a; border-top: 1px solid #9a9a9a; padding-top: 5px; padding-bottom: 5px; margin: 0; spacing: 0; border-collapse: collapse; font-family: verdana, arial, sans-serif; font-size: .8em; width: 40%;">
																	<%=subRegulon.getGenomeName()%>
																</td>
																<td style="border-top: 1px solid #9a9a9a; padding-top: 5px; padding-bottom: 5px; margin: 0; spacing: 0; border-collapse: collapse; font-family: verdana, arial, sans-serif; font-size: .8em;">
																	<div class="operondiv" style="width:0px; height:25px; padding:0px;"></div>
																</td>
															</tr>
															<% } 
															} %>
														</table>
													</td>
												</tr>
											</table>
											</div>
										</td>
			</div>
		</div>
	</div>	
	<%@ include file="/footer.jsp" %>	
</div>
</body>
</html>
 --%>









