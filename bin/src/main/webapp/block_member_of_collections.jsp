<%{ %>

<%
	
	com.lbl.regprecise.ent.Regulog _regulog = (com.lbl.regprecise.ent.Regulog) request.getAttribute("regulog");
	com.lbl.regprecise.ent.Riboswitch _riboswitch = _regulog.getRiboswitch();
	com.lbl.regprecise.ent.TFFamily _tfFamily = _regulog.getTfFamily();
%>
		
		<div style="font-size:0.8em"> 
		<div class="tbl_caption"> Member of regulog collections </div>
		<ul class="list_disc">
		<%
			for(com.lbl.regprecise.ent.Collection collection: _regulog.getCollections())  
			{
				if(collection.getStatusTermId() < com.lbl.regprecise.web.Config.MIN_COLLECTION_STATUS_TERM_ID) continue;
				if( collection.getTypeTermId() != com.lbl.regprecise.ent.Term.COLLECTION_TYPE_BY_TAXONOMY && collection.getTypeTermId() != com.lbl.regprecise.ent.Term.COLLECTION_TYPE_BY_REGULATOR) continue;
				if(collection.getName().equals("Bioenergy related")) continue;
				String collectionURL = com.lbl.regprecise.web.WebLinksProvider.getCollectionRef(collection);				

		%>  
			<li><%= collection.getType() %> -  
				<a href="<%= collectionURL%>"><%= collection.getName() %></a></li>
		<% } %>

		<%
			if(_riboswitch != null)
			{
		%>
			<li>By RNA motif -  
				<a href="collection_rfam.jsp?riboswitch_id=<%= _riboswitch.getId() %>"><%= _riboswitch.getName() %></a></li>
		<% } %>

		<%
			if(_tfFamily != null)
			{
		%>
			<li>By TF family -  
				<a href="collection_tffam.jsp?tffamily_id=<%= _tfFamily.getId() %>"><%= _tfFamily.getName() %></a></li>
		<% } %>

		
		<%
			for(com.lbl.regprecise.ent.Effector effector: _regulog.getEffectors())
			{
		%>
			<li>By effector -  
				<a href="collection_effector.jsp?effector_id=<%= effector.getId() %>"><%= effector.getName() %></a></li>
		<% } %>
		
		<%
			for(com.lbl.regprecise.ent.Pathway pathway: _regulog.getPathways())
			{
		%>
			<li>By pathway -  
				<a href="collection_pathway.jsp?pathway_id=<%= pathway.getId() %>"><%= pathway.getName() %></a></li>
		<% } %>				
		</ul>
		</div>	
		
<%} %>		