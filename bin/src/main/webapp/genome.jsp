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
<%@page import="com.lbl.regprecise.ent.Term"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.web.Formatter"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int genomeId = Integer.parseInt(request.getParameter("genome_id")) ;
	int collectionId = Collection.COLLECTION_ID_PUBLIC_ALL; 	 
	
	Genome genome = dataProvider.getGenome(genomeId);  
	List<Regulon> regulons  = dataProvider.getRegulons(genome);
	Regulon.sortByRegulationTypeRegulatorName(regulons); 
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

			<div class="introduction">
				<h1> Regulons of <span class="titleItem"><i><%= genome.getName() %></i></span></h1> 
			</div>
			<div class="vspace_separator">								

			<table style="width: 100%; font-size: 0.8em;">
			<tbody>
				<tr>
					<td width="80px">  
						<a href="http://140.221.84.217:7040/glamm/#i=0&ext=rpS%7Cid=<%= genome.getMoId() %>" target="_blank">
							<img style="width:70px;"  src="images/glamm.jpg"/>
						</a> 
					</td>
					<td><i>Allows to visualize regulome content in the context of metabolic pathways</i></td>
				</tr>
			</tbody>
			</table>

            <table width="99%" border=0 cellpadding="0px" style="border-collapse: collapse;">
            <tr>            
 			<td><div class="vspace_separator"></div></td>
        	<td valign="bottom"><div id="tab_header">
                <ul>
                    	<li class="notselected"><a style="font-size: 0.9em; line-height:25px;" href="regcascade.jsp?genome_id=<%=genomeId%>">Regulatory cascades</a></li>
                    	<li class="selected"><a style="font-size: 0.9em; line-height:27px;">Table view</a></li>
                </ul>
        	</div></td>
            </tr></table>

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
						<th>Operons</th>
						<th>Sites</th>
					</tr>
				</thead>
				<tbody>
					<%
						int i = 0;
						for (Regulon regulon : regulons) {		
							int sitesCount = regulon.getSites().size();
							if(sitesCount == 0 ) continue;
							i++;
							Regulog regulog = regulon.getRegulog();
							String regType = regulog.getRegulationTypeTermId() == Term.TERM_REGULATION_TYPE_TF ? "TF" : "RNA";							
					%>
					<tr <% if(i%2 ==0){%>class="tbl_even_row"<%}%>>
						<td> <span class="<%= regType %>" > <%= regType %> </span> </td>
						<td style="text-align: left"><a href="regulon.jsp?regulon_id=<%= regulon.getId() %>"><%= regulog.getRegulatorName() %></a></td>
						<td style="text-align: left"> <%= Formatter.toNotNull(regulog.getEffectorNames()) %></td>
						<td style="text-align: left"> <%= Formatter.toNotNull(regulog.getPathwayNames())  %></td>				
					
						<td><%= regulon.getOperons().size() %></td>						
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
					 <a href="ExportServlet?type=gene&genomeId=<%= genome.getId()%>"><b>DOWNLOAD</b></a>  
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
					 <a href="ExportServlet?type=site&genomeId=<%= genome.getId()%>"><b>DOWNLOAD</b></a>  
				</td>
			</tr>
		</table>				
		
	</div>
	<%@ include file="/footer.jsp" %>	
</div>
</body>
</html>