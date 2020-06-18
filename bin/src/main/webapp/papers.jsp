<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%> 
<%@page import="java.util.Collections"%> 

<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.Article"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	List<ComputationalValidation> validations = dataProvider.getComputationalValidations();
%>

<%@page import="com.lbl.regprecise.ent.ComputationalValidation"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>List of publications</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>

<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 

		<div>
			<div class="introduction">
				<h1>List  of publications</h1> 
				<h2 class="text_description">Underlying list of references represents selected publications on the identification 
				and reconstruction of transcriptional regulons using the comparative genomic approach. 				
				</h2>
			</div> 

			<div id="data" style="margin-left: 70px;">
				<% int index = 0;
					for(ComputationalValidation validation: validations){
						Article article = validation.getArticle();
						index++;
				%>
				<div style="margin-top: 2.5em">
					<%= index %>. <%= article.getAuthors() %>. (<%=article.getYear()%>) 
					<%= article.getTitle() %> <%= article.getJornal() %>, <%= article.getPages() %>
					
					<ul>
					<% for(Regulog regulog: validation.getRegulogs()){ %>
						<li><a href="regulog.jsp?regulog_id=<%= regulog.getId()%>"><%= regulog.getName() %></a></li>
					<%} %>
					</ul>
				</div>
				<%} %> 
			</div>
		</div>
	</div>
	<%@ include file="/footer.jsp" %>	
</div>
</body>
</html>