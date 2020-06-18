<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">        

<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.DatabaseRelease"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	DatabaseRelease release = dataProvider.getCurrentDatabaseRelease();
%>        
        
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
	<link rel="shortcut icon" href="images/favicon.ico" />
	<link rel="stylesheet" type="text/css" href="styles/base.css" />

<!-- Setup Stylesheets -->
		<!-- For IE 7 or earlier -->
        <!--[if lte IE 7]>
        <style type="text/css" media="all">
        /*<![CDATA[*/
        .iefix {padding:15px 0 0 0}
        legend { position: relative; left:0px; top: -0.75em;}
        fieldset ol {padding-top: 0.25em;}
        fieldset {position: relative;float:none;}
        /*]]>*/
        </style>
        <![endif]-->

<script type="text/javascript">

	function showAsSelected(objId) {
	  with (document) if (getElementById && ((obj=getElementById(objId))!=null))
	   obj.parentNode.className = "selected";
	   var list = obj.parentNode.getElementsByTagName("li");
	   for (var i=0; i<list.length; i++)
	   	 if(list[i] != obj) {list[i].className = "other";}
	}
</script>

</head>
<body>
	<div id="page">
	<%@ include file="/header.jsp" %>	

	<!-- Start Content -->
	<div class="wrapper">
        <div class="content">
            <p>The <strong>RegPrecise</strong> is a database for capturing, visualization and analysis of transcription factor regulons that were reconstructed by the comparative genomic approach in a wide variety of prokaryotic genomes.<a class="more_start" href="help.jsp#what">more</a>
            </p>
            
            
            <div class="spacebetween">&nbsp;</div>
            
            <div style="float:left;width:700px;">
            <div class="grey_primebox">
            	<h2 class="primebox_header">Manually Curated</h2>
                <a href="collections.jsp"><img src="images/manualyCurated_bigthumb.gif" alt="Manually Curated"/></a>
                
                <div class="regprecise_services">
                    <div class="regprecise_projects">
                    	<h3><a class="arrow_link" href="collections.jsp">Regulon Collections</a></h3>
                    	<div class="section"><a href="collections.jsp"><img src="images/regulonCollection_thumb.gif" alt="Regulon Collections"/></a>
This section of the database represents the results of manually curated reconstrutions of transcriptional regulons using the comparative genomics approach. 
<br/><br/>
Browse collections that organize the reconstructed regulons by phylogenetic, structural or functional properties of regulators.                    	

                    	</div>
						
						<div class="section">
							<a class="arrow_link" href="collections_tax.jsp">Taxonomy</a><br/>				
							<a class="arrow_link" href="collections_tf.jsp">Transcription factor</a><br/>				
							<a class="arrow_link" href="collections_tffam.jsp">TF family</a><br/>	
							<a class="arrow_link" href="collections_rfam.jsp">RNA family</a><br/>		
							<a class="arrow_link" href="collections_effector.jsp">Effector</a><br/>			
							<a class="arrow_link" href="collections_pathway.jsp">Pathway</a><br/>	
						</div>				
                	</div>
                </div>
            </div>
            <div class="spacebetween">&nbsp;</div>
            <div class="grey_primebox">
            	<h2 class="primebox_header">Propagated</h2>
                <a href="propagations.jsp"><img src="images/propogated_bigthumb.gif" alt="Propagated"/></a>
                
                <div class="regprecise_services">
                    <div class="regprecise_projects">
                    	<h3><a class="arrow_link" href="propagations.jsp">Propagated Regulons</a></h3>
                    	<div class="section"><a href="propagations.jsp"><img src="images/propogatedCollection_thumb.gif" alt="Propagated"/></a>This section of the database represents the results of accurate automatic propagation of the manually curated regulons to novel closely related genomes.<br/><br/>                    	
                     	
						For each regulog, the propagation procedure checks for the presence of orthologs for both a transcription factor gene and target genes (regulog members), and then performs search for candidate TF-binding sites in upstream regions of orthologous target genes<br/><br/>
						This procedure is considered to be accurate and conservative since it relies on the manually curated regulons and does not make an attempt for automatic prediction of new members of regulon.
 
 						
                        </div>
                	</div>                    
                </div>         
            </div>
            <div class="clear_start"></div> 
			     
            </div>
            
            <div class="spacebetween">&nbsp;</div>
                    
            <div class="grey_secondarybox">                        
            	<div class="updates_box">
                	<h3 class="updates_box_subheader">News</h3>
                    <p><b class="date">Recent update, <%= release.getRecentUpdateMonth() %></b><br/>
                    	<%= release.getRecentUpdateText() %>
                    </p>
                    
                    <p><b class="date" style="color:#800;">Upcoming, <%= release.getUpcommingUpdateMonth() %></b><br/>
                    	<%= release.getUpcommingUpdateText() %>
                    </p>  
                </div>
            </div>
            <div class="spacebetween">&nbsp;</div>  
            <div class="clear_start"></div> 
			<div style="text-align:left;margin: 5px 10px 0px 10px;">
				<div style="background-color:#CCC; height:1px;"> </div>   
				<div style="margin-top:10px;">        
            		<b>Please cite:</b>
					<a class="link_start" href="http://www.ncbi.nlm.nih.gov/pubmed/24175918"> RegPrecise 3.0 - A resource for genome-scale exploration of transcriptional regulation in bacteria.</a>
					Novichkov PS, Kazakov AE, Ravcheev DA, Leyn SA, Kovaleva GY, Sutormin RA, Kazanov MD, Riehl W, Arkin AP, Dubchak I, Rodionov DA.
					BMC Genomics. 2013 Nov 1;14:745
				</div>
				<div style="margin-top:10px;">        
            		<b>Funding statement:</b>
					RegPrecise development is sponsored by the Office of Science (BER), U.S. Department of Energy under contracts DE-AC02-05CH11231 with Lawrence Berkeley National Laboratory, 
					and DE-SC000499 with Sanford-Burnham Medical Research Institute and Lawrence Berkeley National Laboratory;
					and National Science Foundation under contract DBI-0850546 with Sanford-Burnham Medical Research Institute.
				</div>

			</div>				
		</div>
	<%@ include file="/footer.jsp" %>
	</div>
	<!-- END Content -->
	</div>
</body>
</html>
