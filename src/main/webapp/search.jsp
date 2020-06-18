<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.List"%> 
<%@page import="java.util.Collections"%> 


<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.Term"%>
<%@page import="com.lbl.regprecise.ent.SearchIndex"%>



<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	String val = request.getParameter("name");
	List<SearchIndex> indeces = dataProvider.getSearchIndeces("%" + val + "%");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Search <%= val%></title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 

		<div >
			<div class="introduction">
				<h1> Search for <span class="titleItem"><i><%= val%></i></span></h1> 
			</div>
 			
			<div class="vspace_separator"></div>

			<div>
			<table class="stattbl"> 
				<caption></caption>
				<thead>
					<tr>			
						<th>Type</th>			
						<th>Element Type</th>
						<th style="text-align: left">Name</th>
						<th style="text-align: left">Regulon</th>
					</tr>
				</thead>
				<tbody>
					<%
						int i = 0;
						for (SearchIndex si : indeces) {
							String objTypeName = "undef";
							switch(si.getObjType() )
							{
								case Term.TERM_GENE: objTypeName = "Gene"; break;
								case Term.TERM_REGULATOR: objTypeName = "Regulator"; break;
								case Term.TERM_REGULON: objTypeName = "Regulon"; break;
							}
							if(objTypeName.equals("undef")) continue;
							i++;
							String regType = si.getRegulationTypeTermId() == Term.TERM_REGULATION_TYPE_TF ? "TF" : "RNA";
							
					%>
					<tr <% if(i%2 ==0){%>style="background: #EFE"<%}%>>
						<td> <span class="<%= regType %>" > <%= regType %> </span> </td>
						<td><%= objTypeName %></td>
						<td style="text-align: left"><%= si.getObjName() %></td>						
						<td style="text-align: left"><a href="regulon.jsp?regulon_id=<%= si.getRegulonId() %>"><%= si.getRegulatorName() %> - <%= si.getGenomeName() %></a></td>						
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