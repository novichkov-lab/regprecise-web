<%@ page isErrorPage="true" import="java.io.*" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
        
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Error</title>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
	<link rel="shortcut icon" href="images/favicon.ico" />
	<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>
	<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content">
		
		<div class="introduction">
			<h1>The page you are looking for does not exist.</h1> 
		</div>
			
		<%
		out.println("<!--");
		StringWriter sw = new StringWriter();
		PrintWriter pw = new PrintWriter(sw);
		exception.printStackTrace(pw);
		out.print(sw);
		sw.close();
		pw.close();
		out.println("-->");
		%>
		
	</div>
	<%@ include file="/footer.jsp" %>
	</div>
</body>
</html>