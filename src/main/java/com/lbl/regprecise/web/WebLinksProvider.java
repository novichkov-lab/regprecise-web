package com.lbl.regprecise.web;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.lbl.regprecise.ent.Article;
import com.lbl.regprecise.ent.Collection;
import com.lbl.regprecise.ent.Gene;
import com.lbl.regprecise.ent.Operon;
import com.lbl.regprecise.ent.PropagatedRegulator;
import com.lbl.regprecise.ent.Regulator;
import com.lbl.regprecise.ent.Regulog;
import com.lbl.regprecise.ent.Term;

/**
 * @author Pavel Novichkov
 *
 */
public class WebLinksProvider {

	public static String getMicrobesOnlineRef(int locusId)
	{
		return "http://www.microbesonline.org/cgi-bin/fetchLocus.cgi?locus=" + locusId + "&disp=0";		
	}

	public static String getPropagatedRegulatorMicrobesOnlineRefHTML(List<PropagatedRegulator> regulators)
	{
		String res = "";
		
		for(PropagatedRegulator regulator: regulators)
		{
			if(res.length() > 0 ) res += ", ";
			if(regulator.getMoLocusId() != null)
			{
				res += getRefHTML( getMicrobesOnlineRef(regulator.getMoLocusId()),  regulator.getMoLocusTag());
			}
			else 
			{
				res += regulator.getMoLocusTag();
			}
		}		
		return res;		
	}
	
	public static String getRFAMRefHTML(String rfamId)
	{
		return getRefHTML("http://rfam.sanger.ac.uk/family/" + rfamId, rfamId);
	}
	
	

	public static String getMicrobesOnlineRefHTML(List<Regulator> regulators)
	{
		String res = "";
		
		for(Regulator regulator: regulators)
		{
			if(res.length() > 0 ) res += ", ";
			if(regulator.getMoId() != null)
			{
				res += getRefHTML( getMicrobesOnlineRef(regulator.getMoId()) ,regulator.getLocusTag() );
			}
			else 
			{
				res += regulator.getLocusTag();
			}
		}		
		return res;
	}
	
	public static String getMicrobesOnlineRefHTML(Gene gene)
	{
		return
			gene.getMoId() != null
				? getRefHTML( getMicrobesOnlineRef(gene.getMoId()),  gene.getLocusTag() )
				: gene.getLocusTag();
	}
	
	public static String getMicrobesOnlineRefHTML(Operon operon)
	{
		return getMicrobesOnlineRefHTML(operon.getFirstGene());
	}
	
	public static String getRegulogsRefHTML(List<Regulog> regulogs)
	{
		StringBuffer sb = new StringBuffer();
		for(Regulog regulog: regulogs)
		{
			if(sb.length() > 0) sb.append(", ");
			sb.append(
				getRefHTML("regulog.jsp?regulog_id=" + regulog.getId(), regulog.getName() )
			);
		}
		return sb.toString();
	}
	
	public static String getRegulogRefHTML(Regulog regulog)
	{
		return getRefHTML("regulog.jsp?regulog_id=" + regulog.getId(), regulog.getName());
	}	
	

	public static String getCollectionRef(Collection collection)
	{
		String collectionURL = "";
		switch(collection.getTypeTermId())
		{
			case Term.COLLECTION_TYPE_BY_TAXONOMY:  collectionURL = "collection_tax.jsp"; break;
			case Term.COLLECTION_TYPE_BY_REGULATOR:  collectionURL = "collection_tf.jsp"; break;
		}
		collectionURL += "?collection_id=" + collection.getId();
		return collectionURL;
	}
	
	
	public static String getPubmedRefHTML(Article article)
	{
		String url = "http://www.ncbi.nlm.nih.gov/pubmed/" 
			+ article.getPmid() 
			+ "?ordinalpos=1&itool=EntrezSystem2.PEntrez.Pubmed.Pubmed_ResultsPanel.Pubmed_DefaultReportPanel.Pubmed_RVDocSum";

		
		return getRefHTML( url, "PMID: " + article.getPmid());
	}
	
	public static String getMOExpressionCorrelationRef(String locusIds)
	{
		return
			"http://www.microbesonline.org/cgi-bin/microarray/geneCor.cgi?locusIds=" + locusIds;
	}
	
	public static String getMOExpressionFitnessRef(String locusIds)
	{
		return
			"http://jkbaumohl.tst.microbesonline.org/cgi-bin/microarray/geneCor.cgi?locusIds=" + locusIds
				+ "&expType=Fitness";
	}

	
	public static String getMOCorrelationRef(String type, String locusIds)
	{
		if(type.equalsIgnoreCase("fitness") )
		{
			return getMOExpressionFitnessRef(locusIds);
		}
		if(type.equalsIgnoreCase("expression") )
		{
			return getMOExpressionCorrelationRef(locusIds);
		}
		return "";
	}
	
	private static String getRefHTML(String url, String text) {
		return "<a href=\"" + url + "\">" + text + "</a>";
	}
	
	public static String changePMIDIds2Refs(String text)
	{
		Pattern p = Pattern.compile("\\[\\s*[0-9]+\\s*(\\,\\s*[0-9]+\\s*)*\\]");
		Matcher m = p.matcher(text);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			String group = m.group();
			group = group
					.replaceAll("([0-9]+)",
							"<a href=\"http://www.ncbi.nlm.nih.gov/pubmed?term=$1\">$1</a>");
			m.appendReplacement(sb, group);
		}
		m.appendTail(sb);
		return sb.toString();
	}
	
}
