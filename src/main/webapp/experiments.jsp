<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.List"%> 

<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.ExperimentalValidation"%>
<%@page import="com.lbl.regprecise.ent.Regulog"%>
<%@page import="com.lbl.regprecise.ent.Article"%>

<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.web.WebLinksProvider"%>
<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	List<Regulog> regulogs = dataProvider.getExperimentalyValidatedRegulogs();
%>


<%@page import="java.util.ArrayList"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Experimentally validated predictions</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
<style type="text/css">
.header1{
	margin-top: 2em;
	background-color: rgb(223,232,246);
	font-size: 1.2em;
	color: #777;	
	padding: 2px;
}

h3{
	font-size: 1em; 	 	
}

.experiment {
	margin-left: 0;
	padding-left:0;
}

.experiment li{
	text-decoration: none;
	list-style: none;	
	margin-left: 0;
	padding-left:0;
}

.experiment li .reference{
	margin-left: 3em; 
	margin-top: 0.5em;
}

.experiment li .header{
	font-style: italic; 
	font-weight:normal; 
}

.tbl_caption {
	margin-top: 30px;
}

</style>
</head>
<body>



<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 

			<div class="introduction">
				<h1>Experimental validations</h1> 
				<h2 class="text_description">This section summarizes all regulogs in the RegPrecise database, for which any experimental support is currently available. Supporting experiment type and relevant publications (if any) are provided.  Two case studies combining the identification, comparative genomic reconstruction and experimental validation of transcriptional regulons for the NAD metabolism in bacteria are described in more details below (see collections NiaR and NrtR). 
				</h2>

			</div>
			<div id="data">
				<div class="vspace_separator"></div>


				<div>
					<%for(Regulog regulog: regulogs) {%>
					<div class="tbl_caption">Regulog: <%= WebLinksProvider.getRegulogRefHTML(regulog) %></div>
	
					<% for(ExperimentalValidation validation: regulog.getExperimentalValidations()) {
							Article article = validation.getArticle();
					%>
					<div class="vspace_separator"></div>	
					<ul class="experiment">
					<li>
						<span class="header">Organism:</span> <%= validation.getOrganism()  %> <br></br>
						<span class="header">Experiment type(s):</span> <%= validation.getExperimentTypes() %>
						<div class="reference">
						
									<!-- <%= article.getAuthors() %>. (<%=article.getYear()%>) --> 
									<%= article.getTitle() %> <%= article.getJornal() %>, <%= article.getPages() %>
									<%= WebLinksProvider.getPubmedRefHTML(article) %> 						  
						</div>
					</li>
					</ul>					
					<%}}%>

				</div>


				<div>
					<div class="tbl_caption">Regulog(s): 
						<a href="regulog.jsp?regulog_id=782">NiaR - Bacillales</a>;
						<a href="regulog.jsp?regulog_id=754">NiaR - Thermotogales</a></div>
					<div class="vspace_separator"></div>	
					<ul class="experiment">
					<li>
						<span class="header">Organism(s):</span> Thermotoga maritima MSB8; Bacillus subtilis<br></br>
						<span class="header">Experiment type(s):</span> EMSA
						<div class="reference">
						Rodionov DA, Li X, Rodionova IA, Yang C, Sorci L, Dervyn E, Martynowski D, Zhang H, Gelfand MS, Osterman AL. (2008) Transcriptional regulation of NAD metabolism in bacteria: genomic reconstruction of NiaR (YrxA) regulon. Nucleic Acids Res., 36: 2032-46. 
						  <a href="http://www.ncbi.nlm.nih.gov/pubmed/18276644?ordinalpos=1&itool=EntrezSystem2.PEntrez.Pubmed.Pubmed_ResultsPanel.Pubmed_DefaultReportPanel.Pubmed_RVDocSum">PMID: 18276644</a>
						</div>
					</li>
					</ul>					
					<div class="vspace_separator"></div>	



					<h3>The previously known facts</h3>
					In Bacillus subtilis, the transcription factor NiaR encoded by the yrxA gene was shown to 
					operate as a niacin-responsive transcriptional repressor of the NAD biosynthesis operon. 
					<!-- [Rossolino et al, 2005]. --> 			
					<h3>Comparative genomic analysis</h3>
					Using the comparison of multiple genomes of bacteria from the Bacillus/Clostridium group that 
					have an ortholog of NiaR, a candidate DNA-binding motif of NiaR was discovered. Further comparative 
					genome analysis was used to predict additional NiaR binding sites and to reconstruct the NiaR regulon 
					in every species. For the Thermotogales lineage, another taxonomic group possessing an NiaR ortholog, 
					a distinct candidate NiaR-binding motif was identified. The reconstructed NiaR regulon was predicted 
					to control various genes involved in the NAD biosynthesis and transport. The NiaR regulon reconstruction 
					enables identification of the novel niacin transporter NiaP.t			
					<h3>Experimental validation</h3>
					The predicted NiaR binding sites located upstream of two operons in Bacillus subtilis and Thermotoga 
					maritima were experimentally verified by the electrophoretic mobility shift assays, and niacin was 
					confirmed to serve as an effector of NiaR. The predicted NiaP transporter in B. subtilis was validated 
					to be involved in niacin uptake.			
		 
					<img width="900" src="images/NiaR_validation1.gif"/>
				</div>

				<div class="vspace_separator"></div>
				<div>
					<div class="tbl_caption">Regulog(s): 
						<a href="regulog.jsp?regulog_id=363">NrtR - Cyanobacteria</a>;
						<a href="regulog.jsp?regulog_id=405">NrtR - Gammaproteobacteria-1</a></div>
					<div class="vspace_separator"></div>	
					<ul class="experiment">
					<li>
						<span class="header">Organism(s):</span> Synechocystis sp. PCC 6803; Shewanella oneidensis MR-1<br></br>
						<span class="header">Experiment type(s):</span> EMSA
						<div class="reference">
						Rodionov DA, De Ingeniis J, Mancini C, Cimadamore F, Zhang H, Osterman AL, Raffaelli N. (2008) Transcriptional regulation of NAD metabolism in bacteria: NrtR family of Nudix-related regulators. Nucleic Acids Res., 36: 2047-59. 
						  <a href="http://www.ncbi.nlm.nih.gov/pubmed/18276643?ordinalpos=1&itool=EntrezSystem2.PEntrez.Pubmed.Pubmed_ResultsPanel.Pubmed_DefaultReportPanel.Pubmed_RVDocSum">PMID: 18276643</a>
						</div>
					</li>
					</ul>					
					<div class="vspace_separator"></div>	

					<ul class="experiment">
					<li>
						<span class="header">Organism(s):</span> Shewanella oneidensis MR-1<br></br>
						<span class="header">Experiment type(s):</span>In vitro transcription, DNase I footprinting
						<div class="reference">
						Huang N, De Ingeniis J, Galeazzi L, Mancini C, Korostelev YD, Rakhmaninova AB, Gelfand MS, Rodionov DA, Raffaelli N, Zhang H. (2009) Structure and function of an ADP-ribose-dependent transcriptional regulator of NAD metabolism. Structure, 17: 939-51. 
						  <a href="http://www.ncbi.nlm.nih.gov/pubmed/19604474?ordinalpos=1&itool=EntrezSystem2.PEntrez.Pubmed.Pubmed_ResultsPanel.Pubmed_DefaultReportPanel.Pubmed_RVDocSum">PMID: 19604474</a>
						</div>
					</li>
					</ul>					
					<div class="vspace_separator"></div>	

					<h3>The previously known facts</h3>
					Nothing was known about regulation which controls the NAD metabolism in bacteria.
								
					<h3>Comparative genomic analysis</h3>
					The comparative genome context analysis revealed a novel family of Nudix-related transcription factors, 
					termed NrtR, that are responsible for the regulation of various aspects of NAD metabolism in diverse 
					bacterial species. A genomic reconstruction of the NrtR regulons revealed a substantial variability in 
					NrtR binding DNA motifs and regulon composition between various taxonomic groups. Although 18 derived 
					NrtR motifs differ substantially in consensus sequence, most of them share a 21-bp palindrome symmetry 
					and a conserved core with consensus GT-N7-AC. Among NrtR-regulated genes in different taxonomic groups are 
					those involved in the de novo NAD biosynthesis and salvage pathways.			
					<h3>Experimental validation</h3>
					A specific binding to the predicted DNA motifs was experimentally confirmed for the two diverse 
					representative NrtR proteins from Synechocystis sp. and Shewanella oneidensis by the electrophoretic 
					mobility shift assay. In a series of tested intermediates associated with NAD metabolism, ADP-ribose, 
					the product of glycohydrolytic cleavage of NAD, was found to suppress the in vitro binding of NrtR proteins 
					to their DNA target sites. The cellular pool of ADP-ribose may reflect the extent of NAD consumption by 
					various NAD glycohydrolases, and the increased level of this metabolite may be interpreted by a cell as a 
					signal to replenish the cofactor pool by derepression of NAD biosynthetic genes and operons. 			
		 
					<img width="900" src="images/NrtR_validation1.gif"/>
				</div>
			</div>
	</div>
	<%@ include file="/footer.jsp" %>	
</div>
</body>
</html>