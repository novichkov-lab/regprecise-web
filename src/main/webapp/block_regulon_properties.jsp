<%{ %>


<%
	
	com.lbl.regprecise.ent.Regulon _regulon = (com.lbl.regprecise.ent.Regulon) request.getAttribute("regulon");
	com.lbl.regprecise.ent.Regulog _regulog = (com.lbl.regprecise.ent.Regulog) request.getAttribute("regulog");
	com.lbl.regprecise.ent.Riboswitch _riboswitch = _regulog.getRiboswitch();
	com.lbl.regprecise.ent.TFFamily _tfFamily = _regulog.getTfFamily();
	

		if(_regulog.getRegulationTypeTermId() == com.lbl.regprecise.ent.Term.TERM_REGULATION_TYPE_TF){ 
%>
		<div id="propblock">
						<table class="proptbl">
						<caption class="tbl_caption">Properties</caption>
						<tbody>
							<tr>
								<td class="first">Regulator type:</td>
								<td>Transcription factor</td>
							</tr>						
							<tr>
								<td>TF locus tag:</td>
								<td><%= com.lbl.regprecise.web.WebLinksProvider.getMicrobesOnlineRefHTML(_regulon.getRegulators()) %></td>
							</tr>
							<tr>
								<td>Regulator family:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getRegulatorFamily())%></td>
							</tr>
							<tr>
								<td class="first">Regulation mode:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getRegulatorModeOfAction())%></td>
							</tr>
							<tr>
								<td class="first">Biological process:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getPathwayNames() )%></td>
							</tr>
							<tr>
								<td>Effector:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getEffectorNames())%></td>
							</tr>
							<tr>
								<td>Regulog:</td>
								<td><a href="regulog.jsp?regulog_id=<%= _regulog.getId() %>">
								<%= _regulog.getName() %></a></td>
							</tr>
							<tr></tr>
							<tr>
								<td colspan="2" class="tbl_caption">Statistics of regulated genes:</td>
							</tr>
							<tr>
								<td>- Genes</td>
								<td><%= _regulon.getRegulatedGenes().size()%></td>
							</tr>
							<tr>
								<td>- Operons</td>
								<td><%= _regulon.getRegulatedOperons().size()%></td> 
							</tr>
							<tr>
								<td colspan="2" class="tbl_caption">Visualization:</td>
							</tr>
							<tr>
								<td>  
									<a href="http://140.221.84.217:7040/glamm/#i=0&ext=rpR%7Cid=<%= _regulon.getId() %>" target="_blank">
										<img style="margin-left:20px;margin-top:5px;" width="70px"  src="images/glamm.jpg"/>
									</a> 
								</td>
								<td><i>Allows to visualize regulon content in the context of metabolic pathways</i></td>
							</tr>
						</tbody>
						</table>
		</div>
		<%} else if(_regulog.getRegulationTypeTermId() == com.lbl.regprecise.ent.Term.TERM_REGULATION_TYPE_RNA) { %>
		<div id="propblock">
						<table class="proptbl">
						<caption class="tbl_caption">Properties</caption>
						<tbody>
							<tr>
								<td class="first">Regulator type:</td>
								<td>RNA regulatory element</td>
							</tr>						
							<tr>
								<td>Name:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_riboswitch.getName())%></td>
							</tr>
							<tr>
								<td class="first">RFAM:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_riboswitch.getRfamId())%></td>
							</tr>
							<tr>
								<td class="first">Regulation mode:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getRegulatorModeOfAction())%></td>
							</tr>
							<tr>
								<td class="first">Biological process:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getPathwayNames() )%></td>
							</tr>
							<tr>
								<td>Effector:</td>
								<td><%= com.lbl.regprecise.web.Formatter.toNotNull(_regulog.getEffectorNames())%></td>
							</tr>
							<tr>
								<td>Regulog:</td>
								<td><a href="regulog.jsp?regulog_id=<%= _regulog.getId() %>">
								<%= _regulog.getName() %></a></td>
							</tr>
							<tr></tr>
							<tr>
								<td colspan="2" class="tbl_caption">Under regulation:</td>
							</tr>
							<tr>
								<td>- Genes</td>
								<td><%= _regulon.getRegulatedGenes().size()%></td>
							</tr>
							<tr>
								<td>- Operons</td>
								<td><%= _regulon.getRegulatedOperons().size()%></td> 
							</tr>
<!-- 							
							<tr>
								<td colspan="2" class="tbl_caption">Visualization:</td>
							</tr>
							<tr>
								<td>  
									<a href="http://140.221.84.217:7040/glamm/#i=0&ext=rpR%7Cid=<%= _regulon.getId() %>" target="_blank">
										<img style="margin-left:20px;margin-top:5px;" width="70px"  src="images/glamm.jpg"/>
									</a> 
								</td>
								<td><i>Allows to visualize regulon content in the context of metabolic pathways</i></td>
							</tr>
 -->							
						</tbody>
						</table>
		</div>
		<%} %>		

<%} %>		