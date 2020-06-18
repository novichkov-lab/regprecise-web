<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%>

<%@page import="com.lbl.regprecise.web.WebLinksProvider" %>
<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.ent.Collection"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Regulon"%>
<%@page import="com.lbl.regprecise.ent.Genome"%>

<%
	
	final String FINTESS = "fitness";
	final String EXPRESSION = "expression";

	
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();

	int collectionId = 6;
	int genomeId = 63;
	String expType = "expression";

	String val = request.getParameter("collectionId");
	if (val != null) {
		collectionId = Integer.valueOf(val);
	}
	
	val = request.getParameter("genomeId");
	if (val != null) {
		genomeId = Integer.valueOf(val);
	}
	
	val = request.getParameter("expType");
	if (val != null) {
		expType = val;
	}
	
	
	Genome genome = dataProvider.getGenome(genomeId);
	List<Regulon> regulons = dataProvider.getCollection(collectionId).getRegulons(genome);
	Regulon.sortByRegulatedOperonsCount(regulons);

%>





<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>High Throughput</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>

<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content">
	
			<h3>Genome: <%= genome.getName()%></h3> 
			<h3>Experiment type: <%= expType%> </h3>
			<table>  
				<tbody>
				<%	
					for(Regulon regulon: regulons)
					{
				%>
					<tr>						
				
						<td><%= regulon.getRegulog().getRegulatorName() %></td>			
						<td> <a href="<%= WebLinksProvider.getMOCorrelationRef(expType, regulon.getRegulatedOperonsFirstGeneMOIds()) %>"><%= regulon.getRegulatedOperons().size() %></a>
						</td>			
						<td> <a href="<%= WebLinksProvider.getMOCorrelationRef(expType, regulon.getRegulatedGeneMOIds()) %>"><%= regulon.getRegulatedGenes().size() %></a>
						</td>															
					</tr>						
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