<%{ %>


<%

		com.lbl.regprecise.ent.PropagatedRegulon _pgpRegulon = (com.lbl.regprecise.ent.PropagatedRegulon) request.getAttribute("pgpRegulon");	
		com.lbl.regprecise.ent.Regulog _regulog = _pgpRegulon.getRegulog();	
			
		com.lbl.regprecise.ent.Riboswitch _riboswitch = _regulog.getRiboswitch();
		com.lbl.regprecise.ent.TFFamily _tfFamily = _regulog.getTfFamily();
	

	
		if(_regulog.getRegulationTypeTermId() == com.lbl.regprecise.ent.Term.TERM_REGULATION_TYPE_TF){ %>
		
			
<%@page import="com.lbl.regprecise.ent.PropagatedRegulon"%><div id="propblock">
						<table class="proptbl">
						<caption class="tbl_caption">Reference regulog properties</caption>
						<tbody>
							<tr>
								<td class="first">Source regulog:</td>
								<td><a href="regulog.jsp?regulog_id=<%= _regulog.getId() %>"><%= _regulog.getName() %></a></td>
							</tr>
							<tr>
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
							<tr>
								<td colspan="2" class="tbl_caption">Propagated regulon:</td>
							</tr>
							<tr>
									<td>Target genome</td>
									<td>
										<a href="propagated_genome.jsp?pgp_collection_id=<%= _pgpRegulon.getPropagatedCollection().getId() %>&genome_id=<%= _pgpRegulon.getGenome().getId() %>"><%= _pgpRegulon.getGenome().getName() %></a>
									</td>
							</tr>
							<tr>
								<td>Orthologous TF(s)</td> 
								<td>
									<% String regRefs = 
										com.lbl.regprecise.web.WebLinksProvider.getPropagatedRegulatorMicrobesOnlineRefHTML(
												_pgpRegulon.getPropagatedRegulators()); 
										if(regRefs != null && regRefs.length() > 0) { out.write(regRefs); } else {
									%>
									<span>No orthologous TFs found</span>
									<%}%>
								</td>
							</tr>
							<tr>
								<td>Regulated genes</td>
								<td><%= _pgpRegulon.getPropagatedGenes().size()%></td>
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