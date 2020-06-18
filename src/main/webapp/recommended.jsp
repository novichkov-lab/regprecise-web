<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Recommended regulons for experimental verification</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
<style type="text/css">
#data h1{
/*	font-family: Verdana, Arial, Helvetica, sans-serif;*/
	font-family: "Lucida Grande";	
	font-size: 1.1em;
	margin-top: 40px;
}
</style>

</head>
<body>

<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 
			<div class="introduction">
				<h1>Recommended regulons for experimental verification</h1> 
			</div>
			<div class="text_description" style="margin-top:10px;">
				The regulons presented in the RegPrecise database were tentatively reconstructed 
				by using the computational genomic approach and comparisons between closely related 
				genomes. The reconstructed regulatory network needs to be integrated with functionally 
				related networks and keynote regulatory interactions representing novel regulons need 
				to be experimentally validated. Here we list the most important from our point of view 
				regulons for experimental validation.
			</div>

			<div id="data">

				<!-- Example 1 -->
				<div style="margin-left:30px;">
					<h1>LiuR - <a href="regulon.jsp?regulon_id=5623">Shewanella oneidensis MR-1 regulon</a></h1>
					Transcription factor LiuR controls pathways of degradation of branch-chain amino acids 
					(Leu, Ile, Val) in Proteobacteria. LiuR is a novel regulator from the MerR family and has 
					no orthologs in E. coli. The LiuR regulon and its DNA-binding motif were first discovered 
					by application of the comparative genomic approach in the Shewanella lineage. For instance, 
					the LiuR regulator in Shewanella oneidensis MR-1 (encoded by the SO1898 gene) has 9 targets 
					sites that presumably control expression of 29 genes organized in 9 operons. These genes encode 
					enzymes from the Leu-Ile-Val degradation pathways (see operons picture below and LiuR regulog in 
					Shewanella), and also enzymes from other amino acid metabolic pathways (thrABC, gltBD) and TCA 
					cycle (aceBA). The predicted effectors for LiuR are intermediates of the Leu-Ile-Val degradation 
					pathways, in particular isovalerate-CoA, isobutyryl-CoA, and 2-methybutanoyl-CoA.

					[Kazakov et al., 2008] 
				</div> 
				<div style="margin-left:30px;">
					<h1>PsrA - <a href="regulon.jsp?regulon_id=5959">Shewanella oneidensis MR-1 regulon</a></h1>
					Transcription factor PsrA controls the fatty acid degradation pathway in Proteobacteria.  
					PsrA is a novel regulator from the TetR family and no orthologs in E. coli. The PsrA regulon 
					and its DNA-binding motif were discovered by application of the comparative genomic approach to 
					the fatty acid degradation genes in the Shewanella lineage. For instance, the PsrA regulator in 
					Shewanella oneidensis MR-1 (encoded by the SO2493 gene) has 15 targets sites that presumably control 
					expression of 25 genes organized in 16 operons. These genes encode enzymes from the fatty acid degradation 
					pathway (see PsrA regulog in Shewanella), and also enzymes from the TCA cycle (aceBA, sdhCAB, gltA). 
					The predicted effector for PsrA are fatty acids.

					[Kazakov et al., 2008]
				</div>
				<div style="margin-left:30px;">
					<h1>HexR - <a href="regulon.jsp?regulon_id=5527">Shewanella oneidensis MR-1 regulon</a></h1>
					Transcription factor HexR controls the central carbohydrate metabolism in Shewanella.  HexR is a novel 
					regulator from the RpiR family; its ortholog in E. coli is a local uncharacterized regulator that presumably 
					controls only one target operon. The HexR regulon and its DNA-binding motif were discovered by application of 
					the comparative genomic approach to the central carbohydrate metabolism in the Shewanella lineage. For instance, 
					the HexR regulator in Shewanella oneidensis MR-1 (encoded by the SO2490 gene) has 14 targets sites that presumably 
					control expression of 27 genes organized in 14 operons. These genes encode enzymes from the glycolysis, the 
					pentose-phosphate and Entner-Doudoroff pathways, deoxynucleoside utilization, and glycine cleavage system 
					(see HexR regulog in Shewanella). The predicted effector for HexR is glucose-6-phosphate.				
				</div>
			</div>
	</div>
	<%@ include file="/footer.jsp" %>	
</div>
</body>
</html>