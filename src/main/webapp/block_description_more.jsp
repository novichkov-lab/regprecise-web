<%{ %>

<%
	String _description1 = (String) request.getAttribute("description1");
	String _description2 = (String) request.getAttribute("description2");
%>
	<h2 class="text_description" style="width: 650px;float: left;"> 
	<%= _description1%>
	<%
		if( _description2.length() > 0)
		{
	%> 
		
	<span class="more"> <a href="javascript:void(0);" onclick="toggle_visibility('description_more');">more</a></span>

	<div id="description_more" class="hidden">  
			<%= _description2 %>
	</div> 		
		
	<%
		}
	%>
</h2>					 								


<%} %> 