<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Regulon"%>

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

		<div class="introduction">
				<b>Regulon of <a href="regulon.jsp?regulon_id=<%=regulonId%>">
				<span class="titleItem"><%= regulog.getRegulatorName()%></span>
				</a> in <span class="titleItem"><%= regulon.getGenomeName()%></span></b>
		</div>
        <table width="100%" border=0><tr><td>
		        <%@ include file="/block_regulon_properties.jsp" %>
		</td></tr></table>
		<center>
		<table width="367" border=0><tr><td>
		        <%@ include file="/block_logo.jsp" %>
		</td><tr></table>
		</center>
