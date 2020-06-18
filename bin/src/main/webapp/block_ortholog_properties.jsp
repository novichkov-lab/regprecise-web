<%{ %>


<%

	com.lbl.regprecise.ent.Regulog _regulog = (com.lbl.regprecise.ent.Regulog) request.getAttribute("regulog");
	com.lbl.regprecise.ent.Riboswitch _riboswitch = _regulog.getRiboswitch();
	com.lbl.regprecise.ent.TFFamily _tfFamily = _regulog.getTfFamily();
	

		if(_regulog.getRegulationTypeTermId() == com.lbl.regprecise.ent.Term.TERM_REGULATION_TYPE_TF){ %>
		
			<div id="propblock">
						<table class="proptbl">
						<caption class="tbl_caption">Properties</caption>
						<tbody>
							<tr>
								<td class="first">Regulog:</td>
								<td><a href="regulog.jsp?regulog_id=<%= _regulog.getId() %>"><%= _regulog.getName() %></a></td>
							</tr>							<tr>
								<td class="first">Regulator type:</td>
								<td>Transcription factor</td>
							</tr>
							<tr>
								<td class="first">Regulator family:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getRegulatorFamily())%></td>
							</tr>
							<tr>
								<td class="first">Regulation mode:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getRegulatorModeOfAction())%></td>
							</tr>
							<tr>
								<td class="first">Biological process:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getPathwayNames()) %></td>
							</tr>
							<tr>
								<td class="first">Effector:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getEffectorNames())%></td>
							</tr>
							<tr>
								<td class="first">Phylum:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getPhylum())%></td>
							</tr>					
						</tbody>
						</table>
			</div>
		<%} else if(_regulog.getRegulationTypeTermId() == com.lbl.regprecise.ent.Term.TERM_REGULATION_TYPE_RNA) { 
		%>
			<div id="propblock">
						<table class="proptbl">
						<caption class="tbl_caption">Properties</caption>
						<tbody>
							<tr>
								<td class="first">Regulator type:</td>
								<td>RNA regulatory element</td>
							</tr>
							<tr>
								<td class="first">Name:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_riboswitch.getName())%></td>
							</tr>
						
							<tr>
								<td class="first">RFAM:</td>
								<td><%=  com.lbl.regprecise.web.WebLinksProvider.getRFAMRefHTML( _riboswitch.getRfamId())  %>
								
								</td>
							</tr>
							<tr>
								<td class="first">Regulation mode:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getRegulatorModeOfAction())%></td>
							</tr>
							<tr>
								<td class="first">Biological process:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getPathwayNames()) %></td>
							</tr>
							<tr>
								<td class="first">Effector:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getEffectorNames())%></td>
							</tr>
							<tr>
								<td class="first">Phylum:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getPhylum())%></td>
							</tr>																												
						</tbody>
						</table>
			</div>					
		<%} %>		

<%} %>