<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Help</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
<style type="text/css">

#content{
	margin-left: 70px;
	margin-right: 70px; 
}


#data {
	line-height: 1.5em;
}

.header1{
	margin-top: 2em;
	background-color: rgb(223,232,246);
	font-size: 1.2em;
	color: #777;	
	padding: 3px 3px 3px 10px;
}


.header1 a{
	color: #777;
}

.header1 a:hover {
	text-decoration: none;	
}


.header2{
	font-size: 1.2em;
	color: #777;	
	margin: 2em 0 2em 0;
	border-bottom: 1px solid #CCC;	
}

.imgright {
	float: right;
	padding: 6px 10px 6px 0px;
	margin-left: 20px;
}


.example{
	margin-left: 50px;
}

.imgleft {
	width: 500px;
	float: left;
	padding: 6px 10px 6px 0px;
	margin-right: 20px;
}

.pleft {
	width: 250px;
	float: left;
}

</style>
</head>
<body>


<div id="page">

<%@ include file="/header.jsp" %>

<div id="content">
<div id="data">

<ul style="list-style: none; margin-left:0;padding-left:0;">
<li><a href="help.jsp#what">What is RegPrecise?</a></li>
<li><a href="help.jsp#why">Why is RegPrecise?</a></li>
</ul>

<div class="vspace_separator"></div>

<p>
Identification and reconstruction of various transcriptional regulons in bacteria using a computational 
comparative genomics approach is coming of age. During the past decade a large number of <span class="empth">manually-curated 
high quality</span> inferences of transcriptional regulatory interactions were accumulated for <span class="empth">diverse taxonomic 
groups</span> of bacteria. These data provide a good foundation for understanding molecular mechanisms of transcriptional 
regulation, identification of regulatory circuits, and interconnections among circuits within the cell. 
</p>

<div class="header1"> <a name="what">What is RegPrecise?</a></div>

<p style="margin-top: 1em;">
<img style="border: 1px solid #CCC;" class="imgright"  src="images/main_objects.gif"/>
The RegPrecise is a database for capturing, visualization and analysis of transcription factor regulons 
that were reconstructed by the comparative genomic approach.</p> 

<p>The primary object of the database is a single <span class="empth">regulon</span> in a particular genome, 
which is described by the identified transcription factor (TF), its DNA binding site model (a profile), as 
well as the set of regulated genes, operons and associated transcription factor binding sites (TFBSs).</p>

<p>The key idea of comparative genomics approach is that the analysis of regulons of a particular TF should 
be carried out in several genomes simultaneously. Therefore RegPrecise provides a special object of the higher 
hierarchy - <span class="empth">regulog</span>, which represents a collection of regulons of the same TF inferred in a set of closely 
related genomes.</p> 

<p>
The third, highest level in the hierarchical organization of the data in RegPrecise is a <span class="empth">collection</span>. 
Currently regulogs are organized into collections of three types:
<ol>
<li>By taxonomic group:  complete set of regulogs analyzed within a particular taxonomic group of closely-related genomes.</li>
<li>By transcription factor: set of regulogs operated by the same transcription factor across various taxonomic groups. </li>
<li>By functional classification: set of various regulogs that control genes from a particular metabolic pathway or biological process.</li>
</ol>
</p>



<div class="clear"></div>

<div class="header1"> <a name="why">Why is RegPrecise?</a></div>
<p style="margin-top: 1em;">
Thorough comparison of the reconstructed regulons in <span class="genome">Shewanella</span> species with known regulons 
in model bacterium <span class="genome">Escherichia coli</span> demonstrated striking differences in the overall regulatory 
strategy in these two lineages of gamma-proteobacteria. Multiple interesting trends in diversification 
and adaptive evolution of TRNs between lineages were detected including regulon "shrinking", "expansion", 
"mergers", and "split-ups", as well as multiple cases of using nonorthologous regulators to control 
equivalent pathways or orthologous regulators to control distinct pathways.
</p>

<p>
Bacterial transcriptional regulation is very flexible and mostly not conserved between various taxonomic 
groups. Therefore investigation of regulation by computational genomic approaches need to be done with careful 
curation of data. RegPrecise database is a depository of <span class="empth">manually curated 
taxonomy-specific</span> reconstructions of 
bacterial regulons.
</p>



<div class="example">
<div class="header2">Example of regulons for Fatty acid metabolism</div>
 
<img class="imgleft" src="images/FAD_EC_SO.gif"/>

<p class="pleft">
The fatty acid degradation fad genes are controlled by two nonorthologous regulators, FadR in 
<span class="genome">E. coli</span> and PsrA in <span class="genome">Shewanella</span>. 
Novel regulon PsrA controls not only fad genes in <span class="genome">Shewanella</span> but also other 
genes from the central metabolism. Though a FadR ortholog is present in <span class="genome">Shewanella</span>, 
its regulon is significantly reduced (2 targets). 
The fatty acid biosynthesis regulon FabR has both conserved and variable parts between <span class="genome">E. coli</span> 
and <span class="genome">Shewanella</span>.
<a href="http://www.ncbi.nlm.nih.gov/pubmed/18820024">[Kazakov et al., 2008]</a>
</p>
</div>

<div class="clear"></div>

<div class="example">
<div class="header2">Example of regulons for Central carbohydrate metabolism</div>
<img class="imgleft" src="images/Central_EC_SO.gif"/>
<p class="pleft">
Many aspects of metabolic regulation in <span class="genome">Shewanella</span> species are substantially different from 
regulatory models known in <span class="genome">E. coli</span>. Among the most notable are the differences in regulons 
for the central carbohydrate pathways. In <span class="genome">E. coli</span> the central carbon metabolism is controlled 
by catabolic regulators FruR and Crp, whereas <span class="genome">Shewanella</span> species use two other transcription 
factors, HexR and PdhR, for this control. NagC and NagR are nonorthologous regulons implicated in the control of utilization 
of N-acetylglucosamine in <span class="genome">E. coli</span> and <span class="genome">Shewanella</span>, respectively.
<a href="http://www.ncbi.nlm.nih.gov/pubmed/18604222">[Fredrickson et al., 2008]</a>
</p>
</div>

<div class="clear"></div>

</div>
<%@ include file="/footer.jsp" %>	
</div>

</body>
</html>