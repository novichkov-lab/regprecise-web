<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 
<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.Term"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.dto.EffectorStatDTO"%>
<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	List<EffectorStatDTO> collectionStats = dataProvider.getEffectorsStatDTO();		
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Collections of regulogs classified by effector of regulator</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 

		<div >
			<div class="introduction">
				<h1>Collections of regulogs classified by effector of regulator</h1> 
 				<h2>Each effector-specific collection organizes all reconstructed regulogs for regulators that respond to a given effector, which is either a small molecule metabolite, an aminoacyl tRNA, or a protein from a multi-component regulatory system. The collected effectors are classified into major classes of biomolecules, such as amino acids, carbohydrates, nucleoides etc. The effector-specific collections may combine regulons operated by transcription factors and regulatory RNAs, such as the collection of regulons for Glycine effector.</h2>
			</div>
 			
			<div class="vspace_separator"></div>

			<div>			
			<table class="stattbl">
				<caption></caption>
				<thead>
					<tr>
						<th class="sup_column2"></th>
						<th class="sup_column1" colspan="3">Reconstructed</th>
						<th class="sup_column2" colspan="1">Studied</th>
					</tr>						
					
					<tr>						
						<th style="text-align: left">Effector</th>
						<th>TF regulogs (regulons)</th>
						<th>RNA regulogs (regulons)</th>
						<th>Total regulogs (regulons)</th>
						<th>Genomes</th>
					</tr>
				</thead>		
				
				<tbody>
					<%
						int i = 0;
						String effectorClassName = "";
						for (EffectorStatDTO collectionStat : collectionStats) 
						{
							i++;
							if(!effectorClassName.equals(collectionStat.getEffectorClassName()))
							{
					%>
						<tr>
						<td colspan="7" class="effector_pathway_class">
							<%= collectionStat.getEffectorClassName() %>
						</td>			
						</tr>			
					<%
								effectorClassName = collectionStat.getEffectorClassName();
							}
								
					%>
					<tr <% if(i%2 ==0){%>class="tbl_even_row"<%}%>>
						<td style="text-align: left">
							<a href="collection_effector.jsp?effector_id=<%= collectionStat.getEffectorId() %>"><%= collectionStat.getEffectorName() %></a>
						</td>						
						<td><%= collectionStat.getTfRegulogCount() %> (<%= collectionStat.getTfRegulonCount() %>)</td>
						<td><%= collectionStat.getRnaRegulogCount() %> (<%= collectionStat.getRnaRegulonCount() %>)</td>
						<td><%= collectionStat.getTotalRegulogCount()  %> (<%= collectionStat.getTotalRegulogCount()  %>)</td>
						<td><%= collectionStat.getTotalGenomeCount()%></td>						
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