<%{ %>

<%
	com.lbl.regprecise.ent.Regulog _regulog = (com.lbl.regprecise.ent.Regulog) request.getAttribute("regulog"); 

	if(_regulog.getRegulationTypeTermId() == com.lbl.regprecise.ent.Term.TERM_REGULATION_TYPE_TF){ 
%>

			<div id="logoblock">
					<img src="logos/<%= _regulog.getId() %>_large.png" /> 
					<div id="logofooter">Built upon <%= _regulog.getSites().size()%> sites 
						<span class="more">[<a href="sites.jsp?regulog_id=<%= _regulog.getId() %>">see more</a>]</span>
					</div>
			</div>
<%
	} else{
%>			
			<div id="logoblock" align="center" >
					<img  width="150"  src="<%= _regulog.getRiboswitch().getImageRef() %>" /> 
			</div>
<%
	}
%>


<%} %>