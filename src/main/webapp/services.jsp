<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>RegPrecise Web Services</title>

	<link rel="shortcut icon" href="images/favicon.ico" />
	<link rel="stylesheet" type="text/css" href="styles/base.css" />

  <style type="text/css">
      a 
      {
	  /* color: #555555;  */
	  text-decoration: underline; 
	  cursor: pointer;
      }

      body {
          font-family: sans-serif;
          font-size: 0.85em;
          margin: 2em 8em;
      }
      .methods {
          background-color: #eef;
          padding: 1em;
      }
      h1 {
          font-size: 2.5em;
      }
      h2 {
          border-bottom: 1px solid black;
          margin-top: 1em;
          margin-bottom: 0.5em;
          font-size: 2em;
      }
      h3 {
          color: darkred;
          font-size: 1.75em;
          margin-top: 0em;
          margin-bottom: 0em;
      }
      h4 {
          margin: 0em;
          padding: 0em;
          border-bottom: 2px solid white;
      }
      h6 {
          font-size: 1.1em;
          color: #99a;
          margin: 0.5em 0em 0.25em 0em;
      }
      dd {
          margin-left: 1em;
      }
      tt {
          font-size: 1.2em;
      }
      table {
          margin-bottom: 0.5em;
      }
      th {
          text-align: left;
          font-weight: normal;
          color: black;
          border-bottom: 1px solid black;
          padding: 3px 6px;
      }
      td {
          padding: 3px 6px;
          vertical-align: top;
          background-color: f6f6ff;
          font-size: 0.85em;
      }
      td p {
          margin: 0px;
      }
      ul {
          padding-left: 1.75em;
      }
      p + ul, p + ol, p + dl {
          margin-top: 0em;
      }
      .optional {
          font-weight: normal;
          opacity: 0.75;
      }
      .super {
	  position: relative;
	  bottom: 0.7em;
	  font-size: 0.7em;
      }
      .sample-req {
	  background-color: #eef;
	  width: auto;
	  height: auto;
	  padding: 0.5em;
	  margin: 0em;
	  border: solid black 1px;
	  overflow: auto;
      }
      .service-header {
	  background-color: #FFCC99;
	  width: auto;
	  height: auto;
	  padding: 0.5em;
	  margin: 0em;
	  /* border: solid #FFCC99 1px; */
	  overflow: auto;
      }


      .string {
	  /* font-lock-string-face */
	  color: #000066;
      }
      .constant {
	  /* font-lock-string-face */
	  color: #006600;
      }      
      .string-keyword {
	  /* font-lock-string-face */
	  color: #000066;
      }
      .object {
	  /* font-lock-string-face */
	  color: #000066;
      }
      .array {
	  /* font-lock-string-face */
	  color: #000066;
      }
      .keyword {
	  /* font-lock-string-face */
	  color: #000066;
      }      
      .json-code {
	  width: 80%;
	  height: 32em;
	  padding: 0.5em;
	  margin: 0em;
	  border: solid black 1px;
	  overflow: auto;
      }


      div.tableblock {
	  margin-top: 0.25em;
	  margin-bottom: 1.5em;
      }
      
      div.tableblock > table {
	  border: 3px solid #527bbd;
      }


      div.tableblock > table[frame="void"] {
	  border-style: none;
      }
      div.tableblock > table[frame="hsides"] {
	  border-left-style: none;
	  border-right-style: none;
      }
      div.tableblock > table[frame="vsides"] {
	  border-top-style: none;
	  border-bottom-style: none;
      }

      caption.title {
	  color: #527bbd;
	  font-family: sans-serif;
	  font-weight: bold;
	  text-align: left;
	  margin-top: 1.0em;
	  margin-bottom: 0.5em;
      }
      
    </style>
</head>
<body>
	<div id="page">
	<%@ include file="/header.jsp" %>	

    <h1>RegPrecise Web Services API 1.0</h1>

    <ul>      
      <li>
      <a href="#resources">Resources</a>
	<ul>
	  <li><a href="#id_formats">Formats</a></li>	  
	  <li><a href="#id_notes">Notes</a></li>	  
	  
	  <li><a href="#id_regulogCollections">http://regprecise.lbl.gov/Services/rest/regulogCollections</a></li>
	  <li><a href="#id_genomes">http://regprecise.lbl.gov/Services/rest/genomes</a></li>
	  <li><a href="#id_regulogs">http://regprecise.lbl.gov/Services/rest/regulogs</a></li>
	  <li><a href="#id_regulog">http://regprecise.lbl.gov/Services/rest/regulog</a></li>
	  <li><a href="#id_regulons">http://regprecise.lbl.gov/Services/rest/regulons</a></li>
	  <li><a href="#id_regulon">http://regprecise.lbl.gov/Services/rest/regulon</a></li>
	  <li><a href="#id_regulators">http://regprecise.lbl.gov/Services/rest/regulators</a></li>
	  <li><a href="#id_genes">http://regprecise.lbl.gov/Services/rest/genes</a></li>
	  <li><a href="#id_sites">http://regprecise.lbl.gov/Services/rest/sites</a></li>
	  <li><a href="#id_genomeStats">http://regprecise.lbl.gov/Services/rest/genomeStats</a></li>
	  <li><a href="#id_regulogCollectionStats">http://regprecise.lbl.gov/Services/rest/regulogCollectionStats</a></li>
	  <li><a href="#id_searchRegulons">http://regprecise.lbl.gov/Services/rest/searchRegulons</a></li>
	  <li><a href="#id_searchExtRegulons">http://regprecise.lbl.gov/Services/rest/searchExtRegulons</a></li>
	  <li><a href="#id_release">http://regprecise.lbl.gov/Services/rest/release</a></li>
                 
<!--       <li><a href='http://yeastract.com/owl/yontology.owl'>OWL ontology</a></li>  -->
	</ul>
	</li>
	
      <li><a href="#client_examples">Example of the client code</a></li>	
	

<!--       <li><a href="#id_status_codes">Status Codes</a></li>  -->
          
<!--      <li> <a href="tutorial.html">Tutorial</a> </li>-->
    </ul>

    <h2 id="resources">Resources</h2>        

    <div class="tableblock">
      <table rules="all" width="100%" frame="border" cellspacing="0" cellpadding="4">
	<caption class="title">Table 1: Resources</caption>
	<col width="20%" />
	<col width="40%" />
	<col width="40%" />
	<thead>
	  <tr>
	    <th align="left" valign="top"><div class="paragraph"><p><b>Resource</b></p></div></th>
	    <th align="left" valign="top"><div class="paragraph"><p><b>URI(s)</b></p></div></th>
	    <th align="left" valign="top"><div class="paragraph"><p><b>Description</b></p></div></th>
	  </tr>
	</thead>
	<tbody>
  	  <tr>
			<td colspan="3" align="center"><b>Core resources</b></td> 
	  </tr>
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Regulators</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/regulators?[regulonId={regulonId},regulogId={regulogId}]</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Represents a list of analyzed regulators that belong to either a given regulon or <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a>.</p></div></div></td>
	  </tr>
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Genes</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/genes?[regulonId={regulonId},regulogId={regulogId}]</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Represents a list of regulated genes that belong to either a given regulon or <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a>.</p></div></div></td>
	  </tr>
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Sites</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/sites??[regulonId={regulonId},regulogId={regulogId}]</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Represents a list of transcription factor binding sites or RNA regulatory elements belonging to either a given regulon or <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a>.</p></div></div></td>
	  </tr>
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Regulon</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/regulon?regulonId={id}</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Represents a regulon.</p></div></div></td>
	  </tr>
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Regulog</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/regulog?regulogId={id}</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Represents a <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a>.</p></div></div></td>
	  </tr>
  	  <tr>
			<td colspan="3" align="center"><b>Navigation resources</b></td> 
	  </tr>	  
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Collections of regulons</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/regulogCollections?collectionType={type}</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Represents various types of <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a> classifications:</p>
	    	<ul>
	    		<li>By taxonomic group</li>
	    		<li>By orthologous transcription factor</li>
	    		<li>By transcription factor family</li>
	    		<li>By RNA regulatory element</li>
	    		<li>By metabolic pathway or biological process</li>
	    		<li>By effector molecule or environmental signal</li>
	    	</ul>
	    </div></div></td>
	  </tr>
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Genomes</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/genomes</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Represents a list of genomes that have at least one reconstructed regulon.</p></div></div></td>
	  </tr>
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Regulogs</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/regulogs?collectionType={type}&amp;collectionId={id}</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Represents a list of <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulogs</a> in a collection of a given type and identifier.</p></div></div></td>
	  </tr>

	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Regulons</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/regulons?[regulogId={regulogId},genomeId={genomeId}]</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Represents a list of regulons in either a particular <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a>, or genome.</p></div></div></td>
	  </tr>

  	  <tr>
			<td colspan="3" align="center"><b>Statistics resources</b></td> 
	  </tr>
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Statistics for collections of regulogs</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/regulogCollectionStats?collectionType={type}</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Represents general statistics on <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a> collections of a particular type.</p></div></div></td>
	  </tr>
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Stastics for genomes</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/genomeStats</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Represents general statistics on genomes that have at least one reconstructed regulon.</p></div></div></td>
	  </tr>
	  
  	  <tr>
			<td colspan="3" align="center"><b>Utility resources</b></td> 
	  </tr>	  
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Search regulons</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/searchRegulons?objType={type}&amp;text={text}</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Search regulons by the name or locus tag of either regulator or target regulated genes.</p></div></div></td>
	  </tr>
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Search regulons</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/searchExtRegulons?taxonomyId={taxonomyId}&amp;locusTags={locusTags}</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Search regulons by a genome and list of gene locus tags.</p></div></div></td>
	  </tr>	  
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Current version of the database</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/release</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Represents the version and the release date of the current version of RegPrecise.</p></div></div></td>
	  </tr>
	</tbody>
      </table>
    </div>


	<!-- ******************* -->
	<!-- OUTPUT FORMATS  -->
	<!-- ******************* -->
	
<!-- 
	<p><em>available response representations:</em></p>
	<ul>
		<li>application/json</a></li>
		<li>text/n3</a></li>  
		<li>application/xml</a></li>
	</ul>
	<p>If not provided defaults to <em>json</em>.</p>
	  
	<p>The correspondence between each output format specifier and the MIME types is as follows:</p>
	<ul>
		<li><tt>json: application/json</tt></li>
		<li><tt>n3: text/n3</tt></li>
		<li><tt>xml: application/rdf+xml</tt></li>
	</ul>
 -->

  <h4 id="id_formats">Formats</h4>
	<br/>
	<p>Currently two response representations are available:</p>
	<ul>
		<li>application/json</li>
		<li>application/xml</li>
	</ul>
	<br/>
	<p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>:</p> 
     
	<ul>
		<li>XML : <code>curl -H "Accept: application/xml" -i 'http://regprecise.lbl.gov/Services/rest/genomeStats'</code></li>	    
		<li>JSON: <code>curl -H "Accept: application/json" -i 'http://regprecise.lbl.gov/Services/rest/genomeStats'</code>	</li>    
	</ul>
	<br/>
	<p>If not provided defaults to <em>json</em>.</p>
	  



    <br/>


	<!-- ******************* -->
	<!-- Notes  -->
	<!-- ******************* -->
    <!-- <img id="id_notes" src="./note.png"> -->
  	<h4 id="id_notes">Notes</h4>
    <p>
    <ul>
      <li> In the descriptions below, a parameter between curly brackets, e.g., {<em>parameter</em>}, stands for a value to be supplied by the user (without the curly brackets).</li>
      <li> In the descriptions below, among arguments in square brackets, e.g. [regulogId=<em>{regulogId}</em>,genomeId=<em>{genomeId}</em>], only one argument can be submited (in this case either regulogId or genomeId).</li>
<!--       <li>In the resources URI templates a stronger/softer red tone is used for required/optional parameters, respectively.</li>  -->
    </ul>
    </p>
	<br/>

	<!-- ******************* -->
	<!-- Clisent examples  -->
	<!-- ******************* -->
    <h4 id="client_examples">Example of the client code</h4>
	
	<br/>    
	<p>    	
    	The template program in perl that can be run to access several of the web services and parse the output data 
    	can be dowloaded <a href="http://regprecise.lbl.gov/RegPrecise/regprecise_api.tar.gz">here</a>.
		The program is organized in two perl scripts:    	    	
    	<ul>
      	<li> RegPreciseAdapter.pm - a perl module that provides access to the individual web services</li>
      	<li> regulons.pl - an example of workflow that can be implemented using a combination of several web services</li>
    	</ul>
		<br/>    	
    	Dependecies:
    	<ul>
      	<li> <a href="http://search.cpan.org/~makamaka/JSON-2.53/lib/JSON.pm">JSON.pm</a> </li>
    	</ul>
    </p>
	<br/>



	<!-- ******************* -->
	<!-- regulogCollections  -->
	<!-- ******************* -->
	
    <div id="id_regulogCollections" class="service-box">
    <div class="service-header">	
		<h3>/regulogCollections?collectionType=<em>{type}</em></h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves description of regulog collections of a specific type.</p></dd>
	<dt><b>Input</b></dt>
	<dd><p>Requires a type of regulog collections.</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a list of regulog collections. Each regulog collection is provided with the following data:
	<ul>
	  <li>collectionType - type of regulog collection</li>
	  <li>collectionId - identifier of collection</li>
	  <li>name - collection name</li>
	  <li>className - name of collection class </li>
	</ul>	
	</p>
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
                
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/regulogCollections?collectionType=taxGroup>'http://regprecise.lbl.gov/Services/rest/regulogCollections?collectionType=taxGroup'</a>
	    </code>	    
	  </div>
	  </p>
	</dd>
      </dl>

    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_regulogCollections_get">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
		<tr>
			<td>
				<p><b>collectionType</b></p>
			</td>

			<td>
				<p><b><em>string</em></b> <!-- <small> (optional)</small> --></p>
				<p><em>One of:</em></p>
				<ul>
					<li><tt>taxGroup - collections by taxonomic groups</tt></li>
					<li><tt>tf - collections classified by orthologous transcription factor</tt></li>
					<li><tt>tfFam - collections classified by transcription factor family</tt></li>
					<li><tt>rnaFam - collections classified by RNA regulatory element family</tt></li>
					<li><tt>pathway - collections classified by metabolic pathway or biological process</tt></li>
					<li><tt>effector - collections classified by effector molecule or environmental signal</tt></li>
				</ul>
			</td>
			<td>Type of a collection of regulogs</td>
		</tr>
	  </table>

	</div>
	</div>
    </div>

	<br/>

	<!-- ******************* -->
	<!-- genomes  -->
	<!-- ******************* -->
	
    <div id="id_genomes" class="service-box">
    <div class="service-header">	
		<h3>/genomes</h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves a list of genomes that have at least one reconstructed regulon.</p></dd>
	<dt><b>Input</b></dt>
	<dd><p>None.</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a list of genomes with the following data:</p>
	<ul>
	  <li>genomeId - genome identifier</li>
	  <li>name - genome name</li>
	  <li>taxonomyId - NCBI taxonomy id</li>
	</ul>
	
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
                
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/genomes>'http://regprecise.lbl.gov/Services/rest/genomes'</a>
	    </code>	    
	  </div>
	  </p>
	</dd>
      </dl>

    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_genomes_get">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
	  </table>

	</div>
	</div>
    </div>

	<br/>
	
	<!-- ******************* -->
	<!-- Regulogs  -->
	<!-- ******************* -->
	
    <div id="id_regulogs" class="service-box">
    <div class="service-header">	
		<h3>/regulogs?collectionType=<em>{type}</em>&amp;collectionId=<em>{id}</em></h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves a list of <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulogs</a> 
		that belongs to a specific collection</p></dd>
	<dt><b>Input</b></dt>
	<dd><p>Requires type and identifier of a regulog collection </p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a list of regulogs. Each regulog is provided with the following data:
	<ul>
	  <li>regulogId - identifier of regulog</li>
	  <li>regulatorName - name of regulator</li>
	  <li>regulatorFamily - family of regulator</li>
	  <li>regulationType - type of regulation: either TF (transcription factor) or RNA</li>	  	  
	  <li>taxonName - name of taxonomic group</li>
	  <li>effector - effector molecule or environmental signal of a regulator</li>
	  <li>pathway - metabolic pathway or biological process controlled by a regulator </li>	  
	</ul>	
	</p>
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
                
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/regulogs?collectionType=taxGroup&collectionId=1>'http://regprecise.lbl.gov/Services/rest/regulogs?collectionType=taxGroup&amp;collectionId=1'</a>
	    </code>	    
	  </div>
	  </p>
	</dd>
      </dl>

    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_regulogs_get">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
		<tr>
			<td>
				<p><b>collectionType</b></p>
			</td>

			<td>
				<p><b><em>string</em></b> <!-- <small> (optional)</small> --></p>
				<p><em>One of:</em></p>
				<ul>
					<li><tt>taxGroup - collections by taxonomic groups</tt></li>
					<li><tt>tf - collections classified by orthologous transcription factor</tt></li>
					<li><tt>tfFam - collections classified by transcription factor family</tt></li>
					<li><tt>rnaFam - collections classified by RNA regulatory element family</tt></li>
					<li><tt>pathway - collections classified by metabolic pathway or biological process</tt></li>
					<li><tt>effector - collections classified by effector molecule or environmental signal</tt></li>
				</ul>
			</td>
			<td>Type of a collection of regulogs</td>
		</tr>
		<tr>
			<td>
				<p><b>collectionId</b></p>
			</td>

			<td>
				<p><b><em>int</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>Identifier of collection</td>
		</tr>
	  </table>

	</div>
	</div>
    </div>

	<br/>
	
	<!-- ******************* -->
	<!-- Regulog  -->
	<!-- ******************* -->
	
    <div id="id_regulog" class="service-box">
    <div class="service-header">	
		<h3>/regulog?regulogId=<em>{id}</em></h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves a <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a> </p></dd>
	<dt><b>Input</b></dt>
	<dd><p>Regulog identifier</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a regulog. A regulog is provided with the following data:
	<ul>
	  <li>regulogId - identifier of regulog</li>
	  <li>regulatorName - name of regulator</li>
	  <li>regulatorFamily - family of regulator</li>
	  <li>regulationType - type of regulation: either TF (transcription factor) or RNA</li>	  	  
	  <li>taxonName - name of taxonomic group</li>
	  <li>effector - effector molecule or environmental signal of a regulator</li>
	  <li>pathway - metabolic pathway or biological process controlled by a regulator </li>	  
	</ul>	
	</p>
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
                
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/regulog?regulogId=621>'http://regprecise.lbl.gov/Services/rest/regulog?regulogId=621'</a>
	    </code>	    
	  </div>
	  </p>
	</dd>
      </dl>

    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_regulog_get">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
		<tr>
			<td>
				<p><b>regulogId</b></p>
			</td>

			<td>
				<p><b><em>int</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>Identifier of regulog</td>
		</tr>
	  </table>
	</div>
	</div>
    </div>

	<br/>


	<!-- ******************* -->
	<!-- Regulons  -->
	<!-- ******************* -->
	
    <div id="id_regulons" class="service-box">
    <div class="service-header">	
		<h3>/regulons?[regulogId=<em>{regulogId}</em>,genomeId=<em>{genomeId}</em>]</h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves a list of regulons belonging to either a particular <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a> or to a particular genome </p></dd>
	<dt><b>Input</b></dt>
	<dd><p>Either regulog identifier or genome identifier</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a list of regulons. A regulon is provided with the following data:
	<ul>
	  <li>regulonId - identifier of a regulon</li>
	  <li>regulogId - identifier of a regulog</li>
	  <li>genomeId - identifier of a genome</li>
	  <li>genomeName - name of a genome</li>
	  <li>regulatorName - name of a regulator</li>
	  <li>regulatorFamily - famliy of a regulator</li>
	  <li>regulationType - type of regulation: either TF (transcription factor) or RNA</li>	  	  
<!--   <li>taxonName - name of taxonomic group</li> -->	
	  <li>effector - effector molecule or environmentla signal of a regulator</li>
	  <li>pathway - metabolic pathway or biological process controlled by regulator</li>	  
	</ul>	
	</p>
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/regulons?regulogId=621>'http://regprecise.lbl.gov/Services/rest/regulons?regulogId=621'</a></code>	    
	  </div>
	  <br/>
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/regulons?genomeId=1>'http://regprecise.lbl.gov/Services/rest/regulons?genomeId=1'</a></code>	    
	  </div>
	  </p>
	</dd>
      </dl>

    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_regulons_get">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
		<tr>
			<td>
				<p><b>regulogId</b></p>
			</td>

			<td>
				<p><b><em>int</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>Identifier of regulog</td>
		</tr>
		<tr>
			<td>
				<p><b>genomeId</b></p>
			</td>

			<td>
				<p><b><em>int</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>Identifier of genome</td>
		</tr>
	  </table>
	</div>
	</div>
    </div>

	<br/>


	<!-- ******************* -->
	<!-- Regulon  -->
	<!-- ******************* -->
	
    <div id="id_regulon" class="service-box">
    <div class="service-header">	
		<h3>/regulon?regulonId=<em>{id}</em></h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves a regulon.</p></dd>
	<dt><b>Input</b></dt>
	<dd><p>Regulon identifier</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a regulon with the following data:
	<ul>
	  <li>regulonId - identifier of a regulon</li>
	  <li>regulogId - identifier of a regulog</li>
	  <li>genomeId - identifier of a genome</li>
	  <li>genomeName - name of a genome</li>
	  <li>regulatorName - name of a regulator</li>
	  <li>regulatorFamily - famliy of a regulator</li>
	  <li>regulationType - type of regulation: either TF (transcription factor) or RNA</li>	  	  
	  <li>taxonName - name of taxonomic group</li>
	  <li>effector - effector molecule or environmentla signal of a regulator</li>
	  <li>pathway - metabolic pathway or biological process controlled by regulator</li>	  
	</ul>	
	</p>
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/regulon?regulonId=6423>'http://regprecise.lbl.gov/Services/rest/regulon?regulonId=6423'</a></code>	    
	  </div>
	  </p>
	</dd>
      </dl>

    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_regulons_get">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
		<tr>
			<td>
				<p><b>regulonId</b></p>
			</td>

			<td>
				<p><b><em>int</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>Identifier of regulon</td>
		</tr>
	  </table>
	</div>
	</div>
    </div>

	<br/>


	<!-- ******************* -->
	<!-- Regulators  -->
	<!-- ******************* -->
	
    <div id="id_regulators" class="service-box">
    <div class="service-header">	
		<h3>/regulators?[regulonId=<em>{regulonId}</em>,regulogId=<em>{regulogId}</em>]</h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves a list of regulators that belong to either a given regulon or <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a>.</p></dd>
	<dt><b>Input</b></dt>
	<dd><p> Regulon or regulog identifier</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a list of regulators. A regulator is provided with the following data:
	<ul>
	  <li>regulonId - identifier of regulon to which a regulator belongs to</li>
	  <li>name - name of regulator</li>
	  <li>locusTag - locus tag of regulator gene in GeneBank</li>
	  <li>vimssId - identifier of regulator gene in <a href="http://www.microbesonline.org/">MicrobesOnline</a> database </li>
	  <li>regulatorFamily - family of a regulator</li>
<!-- 	  <li>regulationType - type of regulation: either TF (transcription factor) or RNA</li> -->	  	  	  
<!--   <li>regulogId - identifier of a regulog to which a regulator belongs to</li>  -->	
	</ul>	
	</p>
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/regulators?regulonId=6423>'http://regprecise.lbl.gov/Services/rest/regulators?regulonId=6423'</a></code>	    
	  </div>
	  <br/>
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/regulators?regulogId=647>'http://regprecise.lbl.gov/Services/rest/regulators?regulogId=647'</a></code>	    
	  </div>
	  </p>
	</dd>
      </dl>

    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_regulators_get">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
		<tr>
			<td>
				<p><b>regulonId</b></p>
			</td>

			<td>
				<p><b><em>int</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>Identifier of regulon</td>
		</tr>	    
		<tr>
			<td>
				<p><b>regulogId</b></p>
			</td>

			<td>
				<p><b><em>int</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>Identifier of regulog</td>
		</tr>
	  </table>
	</div>
	</div>
    </div>

	<br/>

	<!-- ******************* -->
	<!-- Genes  -->
	<!-- ******************* -->
	
    <div id="id_genes" class="service-box">
    <div class="service-header">	
		<h3>/genes?[regulonId=<em>{regulonId}</em>,regulogId=<em>{regulogId}</em>]</h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves a list of regulated genes that belongs to either a given regulon or <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a>.</p></dd>
	<dt><b>Input</b></dt>
	<dd><p>Regulon or regulog identifier</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a list of genes with the following data:
	<ul>
	  <li>regulonId - identifier of a regulon </li>
	  <li>name - name of gene</li>
	  <li>locusTag - locus tag of a gene in GeneBank</li>
	  <li>vimssId - identifier of gene in <a href="http://www.microbesonline.org/">MicrobesOnline</a> database </li>
	  <li>function - gene function</li>	  
<!-- 	  <li>regulogId - identifier of a regulog </li> -->
	</ul>			
	</p>
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/genes?regulonId=6423>'http://regprecise.lbl.gov/Services/rest/genes?regulonId=6423'</a></code>	    
	  </div>
	  <br/>
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/genes?regulogId=647>'http://regprecise.lbl.gov/Services/rest/genes?regulogId=647'</a></code>	    
	  </div>
	  </p>
	</dd>
      </dl>

    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_genes_get">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
		<tr>
			<td>
				<p><b>regulonId</b></p>
			</td>

			<td>
				<p><b><em>int</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>Identifier of regulon</td>
		</tr>	    
		<tr>
			<td>
				<p><b>regulogId</b></p>
			</td>

			<td>
				<p><b><em>int</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>Identifier of regulog</td>
		</tr>
	  </table>
	</div>
	</div>
    </div>

	<br/>

	<!-- ******************* -->
	<!-- Sites  -->
	<!-- ******************* -->
	
    <div id="id_sites" class="service-box">
    <div class="service-header">	
		<h3>/sites?[regulonId=<em>{regulonId}</em>,regulogId=<em>{regulogId}</em>]</h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves a list of regulatory sites (TF binding sites or RNA regulatory elements) and associated regulated genes that belong to a given regulon or <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a>.</p></dd>
	<dt><b>Input</b></dt>
	<dd><p>Regulon or regulog identifier</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a list of regulatory sites and regulated genes with the following data:
	<ul>
	  <li>regulonId - identifier of regulon</li>
	  <li>sequence - sequence of a regualtory site</li>
	  <li>score - score of a regualtory site</li>
	  <li>position - position of a regulatory site relative to the start of a downstream gene </li>
	  <li>geneLocusTag - locus tag of a downstream gene in GeneBank</li>
	  <li>geneVIMSSId - identifier of a downstream gene in <a href="http://www.microbesonline.org/">MicrobesOnline</a> database </li>	  
<!--   <li>regulogId - identifier of regulog</li> -->	
	</ul>			
	</p>
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/sites?regulonId=6423>'http://regprecise.lbl.gov/Services/rest/sites?regulonId=6423'</a></code>	    
	  </div>
	  <br/>
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/sites?regulogId=647>'http://regprecise.lbl.gov/Services/rest/sites?regulogId=647'</a></code>	    
	  </div>
	  </p>
	</dd>
      </dl>

    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_sites_get">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
		<tr>
			<td>
				<p><b>regulonId</b></p>
			</td>

			<td>
				<p><b><em>int</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>Identifier of regulon</td>
		</tr>	    
		<tr>
			<td>
				<p><b>regulogId</b></p>
			</td>

			<td>
				<p><b><em>int</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>Identifier of regulog</td>
		</tr>
	  </table>
	</div>
	</div>
    </div>
	<br/>


	<!-- ******************* -->
	<!-- regulogCollectionStats  -->
	<!-- ******************* -->
	
    <div id="id_regulogCollectionStats" class="service-box">
    <div class="service-header">	
		<h3>/regulogCollectionStats?collectionType=<em>{type}</em></h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves general statistics on <a href="http://regprecise.lbl.gov/RegPrecise/help.jsp#what">regulog</a> collections of a particular type.</p></dd>
	<dt><b>Input</b></dt>
	<dd><p>Collection type.</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a list of regulog collections with the following data:
	<ul>
	  <li>collectionType - type of collection</li>
	  <li>collectionId - identifier of collection</li>
	  <li>name - collection name</li>
	  <li>className - name of collection class</li>

	  <li>totalGenomeCount - total number of genomes that have at least one regulon in collection</li>
	  <li>totalRegulogCount - total number of regulogs in collection</li>
	  <li>tfCount - number of different transcription factors in collection</li>
	  <li>tfRegulogCount - number of TF-controlled regulogs in collection</li>
	  <li>tfSiteCount - number of TF binding sites in collection</li>
	  <li>rnaCount - number of RNA families in collection</li>
	  <li>rnaRegulogCount - number of RNA-controlled regulogs in collection</li>
	  <li>rnaSiteCount - number of RNA regulatory sites in collection</li>	  
	</ul>	
	</p>
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
                
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/regulogCollectionStats?collectionType=taxGroup>'http://regprecise.lbl.gov/Services/rest/regulogCollectionStats?collectionType=taxGroup'</a>
	    </code>	    
	  </div>
	  </p>
	</dd>
      </dl>

    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_regulogCollectionStats_get">GET</h4>
	  <h6>resource parameters</h6>
	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
		<tr>
			<td>
				<p><b>collectionType</b></p>
			</td>
			<td>
				<p><b><em>string</em></b> <!-- <small> (optional)</small> --></p>
				<p><em>One of:</em></p>
				<ul>
					<li><tt>taxGroup - collections by taxonomic groups</tt></li>
					<li><tt>tf - collections classified by orthologous transcription factor</tt></li>
					<li><tt>tfFam - collections classified by transcription factor family</tt></li>
					<li><tt>rnaFam - collections classified by RNA regulatory element family</tt></li>
					<li><tt>pathway - collections classified by metabolic pathway or biological process</tt></li>
					<li><tt>effector - collections classified by effector molecule or environmental signal</tt></li>
				</ul>
			</td>
			<td>Type of a collection of regulogs</td>
		</tr>
	  </table>
	</div>
	</div>
    </div>
	<br/>


	<!-- ******************* -->
	<!-- genomeStatistics  -->
	<!-- ******************* -->
	
    <div id="id_genomeStats" class="service-box">
    <div class="service-header">	
		<h3>/genomeStats</h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves a general statistics on regulons and regulatory sites in genomes </p></dd>
	<dt><b>Input</b></dt>
	<dd><p>None.</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a list of genomes with the following data:</p>
	<ul>
	  <li>genomeId - genome identifier</li>
	  <li>name - genome name</li>
	  <li>taxonomyId - NCBI taxonomy id</li>
	  
	  <li>tfRegulonCount - total number of TF-controlled regulons reconstructed in genome</li>
	  <li>tfSiteCount - total number of TF binding sites in genome</li>
	  <li>rnaRegulonCount - total number of RNA-controlled regulons reconstructed in genome</li>
	  <li>rnaSiteCount - total number of RNA regulatory sites in genome</li>
	</ul>	
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
                
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/genomeStats>'http://regprecise.lbl.gov/Services/rest/genomeStats'</a>
	    </code>	    
	  </div>
	  </p>
	</dd>
      </dl>

    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_genomeStats_get">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
	  </table>
	</div>
	</div>
    </div>
	<br/>


	<!-- ******************* -->
	<!-- Search regulons  -->
	<!-- ******************* -->
	
    <div id="id_searchRegulons" class="service-box">
    <div class="service-header">	
		<h3>/searchRegulons?objType=<em>{type}</em>&amp;text=<em>{text}</em></h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves a list of regulon references by the name/locus tag of either regulator or target regulated genes </p></dd>
	<dt><b>Input</b></dt>
	<dd><p>Object type (either 'gene' or 'regulator') and text value representing either locusTag or name</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a list of regulon references with the following data:
	<ul>
	  <li>regulonId - identifier of regulon</li>
	  <li>genomeName - name of genome</li>
	  <li>regulatorName - the name of regulator</li>
	  
	  <li>foundObjType - found object type (either 'gene' or 'regulator')</li>	  
	  <li>foundObjName - found object name (or locusTag)</li>
	</ul>		
	</p>
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/searchRegulons?objType=regulator&text=argR>'http://regprecise.lbl.gov/Services/rest/searchRegulons?objType=regulator&amp;text=argR'</a></code>	    
	  </div>
	  <br/>
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/searchRegulons?objType=gene&text=SO_2706>'http://regprecise.lbl.gov/Services/rest/searchRegulons?objType=gene&amp;text=SO_2706'</a></code>	    
	  </div>
	  </p>
	</dd>
      </dl>
    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_searchRegulons_get">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
		<tr>
			<td>
				<p><b>objType</b></p>
			</td>

			<td>
				<p><b><em>string</em></b> <!-- <small> (optional)</small> --></p>
				<p><em>One of:</em></p>
				<ul>
					<li><tt>gene</tt></li>
					<li><tt>regulator</tt></li>
				</ul>
			</td>
			<td>Object type to search</td>
		</tr>
		<tr>
			<td>
				<p><b>text</b></p>
			</td>

			<td>
				<p><b><em>string</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>Either locus tag or a name of gene/regulator to search</td>
		</tr>
	  </table>
	</div>
	</div>
    </div>
	<br/>

	<!-- ******************* -->
	<!-- Search ext regulons  -->
	<!-- ******************* -->
	
	  <tr>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Search regulons</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>/searchExtRegulons?taxonomyId={taxonomyId}&amp;locusTags={locusTags}</p></div></div></td>
	    <td align="left" valign="top"><div><div class="paragraph"><p>Search regulons by a genome and list of gene locus tags.</p></div></div></td>
	  </tr>		
	
	
    <div id="id_searchExtRegulons" class="service-box">
    <div class="service-header">	
		<h3>/searchExtRegulons?taxonomyId=<em>{taxonomyId}</em>&amp;locusTags=<em>{locusTags}</em></h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves a list of regulon references by genome taxonomy id and comma-delimited list of gene locusTags </p></dd>
	<dt><b>Input</b></dt>
	<dd><p>NCBI taxonomy id and comma-delimited list of gene locusTags</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns a list of regulon references with the following data:
	<ul>
	  <li>regulonId - identifier of regulon</li>
	  <li>genomeName - name of genome</li>
	  <li>regulatorName - the name of regulator</li>
	  
	  <li>foundObjType - found object type </li>	  
	  <li>foundObjName - found object name (or locusTag)</li>
	</ul>		
	</p>
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/searchExtRegulons?taxonomyId=882&locusTags=DVU0043,DVU0694,DVU3234,DVU3233,DVU0910,DVU3384,DVU0863>'http://regprecise.lbl.gov/Services/rest/searchExtRegulons?taxonomyId=882&locusTags=DVU0043,DVU0694,DVU3234,DVU3233,DVU0910,DVU3384,DVU0863'</a></code>	    
	  </div>
	  <br/>
	  </p>
	</dd>
      </dl>
    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_searchRegulons_get">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
		<tr>
			<td>
				<p><b>taxonomyId</b></p>
			</td>
			<td>
				<p><b><em>int</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>NCBI taxonomy id of a genome</td>
		</tr>
		<tr>
			<td>
				<p><b>locusTags</b></p>
			</td>

			<td>
				<p><b><em>string</em></b> <!-- <small> (optional)</small> --></p>
			</td>
			<td>comma-delimited list of gene locusTags</td>
		</tr>
	  </table>
	</div>
	</div>
    </div>
	<br/>



	<!-- ******************* -->
	<!-- release  -->
	<!-- ******************* -->
	
    <div id="id_release" class="service-box">
    <div class="service-header">	
		<h3>/release</h3>
    </div>
      
    <dl>
	<dt><b>Description</b></dt>
	<dd><p>Retrieves version and date of the current release of RegPrecise database</p></dd>
	<dt><b>Input</b></dt>
	<dd><p>None</p></dd>
	<dt><b>Output</b></dt>
	<dd><p>Returns the current database release information:
	<ul>
	  <li>majorVersion - major version of the current database release </li>
	  <li>mionrVersion - minor version of the current database release</li>
	  <li>releaseDate - date of the current database release</li>
	</ul>		
	</p>
	</dd>
	<dt><b>Example</b></dt>
	<dd>
	  <p>Sample requests using <a href="http://curl.haxx.se/docs/manpage.html">curl</a>: 
	  <div class="sample-req">
		<code>curl -i <a href=http://regprecise.lbl.gov/Services/rest/release>'http://regprecise.lbl.gov/Services/rest/release'</a></code>	    
	  </div>
	  </p>
	</dd>
      </dl>

    <h6>Methods</h6>
	<div class="methods">
	<div class="method">
	  <h4 id="id_release">GET</h4>

	  <h6>resource parameters</h6>

	  <table>
	    <tr>
	      <th>parameter</th>
	      <th>value</th>
	      <th>description</th>
	    </tr>
		<tr>
		</tr>
	  </table>
	</div>
	</div>
    </div>

	<br/>


	<!-- ******************* -->
	<!-- STATUS CODES  -->
	<!-- ******************* -->

    <h2 id="id_status_codes">Status Codes</h2>

    <p>All resources return the following standard HTTP status codes:</p>
    
    <table>
      <tr>
        <th>error code</th>

        <th>description</th>
      </tr>

      <tr>
        <td>
          <p><b>200 OK</b></p>
        </td>

        <td>
          <p>Success status code</p>
        </td>


      </tr>

      <tr>
        <td>
          <p><b>400 Bad request</b></p>
        </td>

        <td>
          <p>The parameters passed to the service did not match as expected. The messages should tell the user what was missing or incorrect. </p>
        </td>


      </tr>

      <tr>
        <td>
          <p><b>401 Unauthorized</b></p>
        </td>

        <td>
          <p>The user has no authorization to access the resource. Use for example when a service is rate limited and the user exceeded his quota.</p>
        </td>
      </tr>
    </table>
    
    <br/>
    <br/>
    
    
	<%@ include file="/footer.jsp" %>
	</div>
</body>
</html>