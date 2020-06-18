<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Regulog Collections</title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
</head>
<body>

<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 
		<div id="mainarea">
		
			<div class="introduction"> 
				<h1>Regulog collections</h1>
			</div>
			
			<div class="vspace_separator"></div>			
            <div class="collections_box">
                <div class="regprecise_services">
                    <div class="regprecise_projects">
                    	<h3><a class="arrow_link" href="collections_tax.jsp">Taxonomy</a></h3>
                    	<div class="section"><!-- <a href="collections_tax.jsp"><img src="images/browse_thumb.gif" alt="Taxonomy"/></a> -->
 							Each taxonomy collection organizes all reconstructed regulogs for a given set of taxonomically 
 							related microbial genomes. The taxonomy collections represent results of large-scale reconstruction 
 							of regulon operated by either transcription factors or RNA regulatory elements. The taxonomical 
 							collections of regulons are valuable for modeling the evolution of transcriptional regulatory 
 							networks and could be used as a framework for interpretation of high-throughput gene expression data. 						
                        </div>
                	</div>                    
                </div>         
            </div>           	
                      	
            <div class="collections_box">
                <div class="regprecise_services">
                    <div class="regprecise_projects">
                    	<h3><a class="arrow_link" href="collections_tf.jsp">Transcription factor</a></h3>
                    	<div class="section"><!-- <a href="collections_tf.jsp"><img src="images/browse_thumb.gif" alt="Transcription factor"/></a> -->
 					Each transcription factor collection organizes all reconstructed regulogs 
 					for a given set of orthologous regulators across different taxonomic groups of microorganisms. 
 					
 					These collections represent regulons for a <b>selected subset</b> of transcription factors.  
 					 					
 					The collections include both widespread transcription 
 					factors such as NrdR, LexA, and Zur, that are present in more than 25 diverse taxonomic 
 					groups of Bacteria, and narrowly distributed transcription factors such as Irr and PurR. 
 					
 					The TF regulon collections are valuable for comparative and evolutionary analysis 
 					of TF binding site motifs and regulon content for orthologous transcription factors.						
                        </div>
                	</div>                    
                </div>         
            </div>
           		
            <div class="collections_box">
                <div class="regprecise_services">
                    <div class="regprecise_projects">
                    	<h3><a class="arrow_link" href="collections_tffam.jsp">TF family</a></h3>
                    	<div class="section"><!-- <a href="collections_tffam.jsp"><img src="images/browse_thumb.gif" alt="TF family"/></a>-->
							Each transcription factor family collection organizes all reconstructed regulogs for a 
							given protein family of homologous regulators across different taxonomic groups of microorganisms. 
							These collections of reconstructed TF regulons covers both large and diverse families such as
							LacI, GntR, and TetR, that contain more than 50 different groups of orthologous transcription factors, 
							and small families such as ArgR, BirA and LexA, containing orthologous transcription factors of the same 
							function. The TF family regulon collections are valuable for evolutionary analysis of TF binding site 
							motifs and effector specificities of homologous transcription factors from the same protein family.						
                        </div>
                	</div>                    
                </div>         
            </div>
        
            <div class="collections_box">
                <div class="regprecise_services">
                    <div class="regprecise_projects">
                    	<h3><a class="arrow_link" href="collections_rfam.jsp">RNA family</a></h3>
                    	<div class="section"><!-- <a href="collections_rfam.jsp"><img src="images/browse_thumb.gif" alt="RNA family"/></a>-->
 							Each RNA family collection organizes all reconstructed regulogs for a given family of regulatory RNA across different taxonomic groups of microorganisms. Genomic distribution and repertoires of controlled genes (regulons) were analyzed for 36 families of regulatory RNAs including 15 metabolite-sensing riboswitches, 6 ribosomal operons leadears, 4 amino acid-responsive attenuators, and multiple cis-acting regulatory RNAs of yet unknown regulatory mechanism. The large collection of T-box regulons for amino acid metabolism was classified by amino acid specifcities based on detailed analysis of T-box sequences.
							The RNA family regulon collections are valuable for evolutionary analysis of regulatory RNAs and their regulons from the same RNA family. 									
                        </div>
                	</div>                    
                </div>         
            </div>			        
        
            <div class="collections_box">
                <div class="regprecise_services">
                    <div class="regprecise_projects">
                    	<h3><a class="arrow_link" href="collections_effector.jsp">Effector</a></h3>
                    	<div class="section"><!-- <a href="collections_effector.jsp"><img src="images/browse_thumb.gif" alt="Effector"/></a>-->
							Each effector-specific collection organizes all reconstructed regulogs for regulators that respond to a given effector, which is either a small molecule metabolite, an aminoacyl tRNA, or a protein from a multi-component regulatory system. The collected effectors are classified into major classes of biomolecules, such as amino acids, carbohydrates, nucleoides etc. The effector-specific collections may combine regulons operated by transcription factors and regulatory RNAs, such as the collection of regulons for Glycine effector.                        
						</div>
                	</div>                    
                </div>         
            </div>			


            <div class="collections_box">
                <div class="regprecise_services">
                    <div class="regprecise_projects">
                    	<h3><a class="arrow_link" href="collections_pathway.jsp">Pathway</a></h3>
                    	<div class="section"><!-- <a href="collections_pathway.jsp"><img src="images/browse_thumb.gif" alt="Pathway"/></a>-->
							Each metabolic pathway-specific collection organizes all reconstructed regulogs that control genes from a given metabolic pathway or biological process.  The collected biochemical pathways are classified by major classes of biomolecules, such as amino acids, carbohydrates, nucleoides etc. The biopathway-specific collections may combine regulons operated by transcription factors and regulatory RNAs, such as the collection of regulons for Glycine metabolism.
						</div>
                	</div>                    
                </div>         
            </div>			
			
		</div>
	</div>
	<%@ include file="/footer.jsp" %>	
</div>
</body>
</html>