package com.lbl.regprecise.web;

import java.util.List;
import java.util.Vector;

import com.lbl.regprecise.ent.Gene;
import com.lbl.regprecise.ent.Operon;
import com.lbl.regprecise.ent.Regulon;
import com.lbl.regprecise.ent.Site;

/**
 * @author Pavel Novichkov
 *
 */
public class SubRegulon {
	private Regulon regulon;
	private List<Operon> operons = new Vector<Operon>();
	
	public SubRegulon(Regulon regulon)
	{
		this.setRegulon(regulon);
	}
	
	public static int SITE_WIDTH = 9;
	
	public int getPixelLength() {
		int width = 0;
		Util util = new Util();
		for(Operon operon: operons) {
			width += 10;
					// for padding between operon divs.
			for(Site site: operon.getSites()) {
				width += SITE_WIDTH;
			}
			for(Gene gene: operon.getGenes()) {
				width += util.getGenePixelLength(gene);
			}
			width = width + 3 + 3*operon.getGenes().size() + 5;
					// for extra space between genes/sites/etc.
		}
		return width+50;
	}
	
	public void addOperon(Operon operon)
	{
		operons.add(operon);
	}
	
	public String getGenomeName()
	{
		return getRegulon().getGenomeName();
	}
	
	public List<Operon> getOperons()
	{
		return operons;
	}
	
	public List<Site> getSites()
	{
		List<Site> sites = new Vector<Site>();
		for(Operon operon: operons)
		{
			for(Site site: operon.getSites())
			{
				sites.add(site);
			}
		}
		return sites;
	}

	public void setRegulon(Regulon regulon) {
		this.regulon = regulon;
	}

	public Regulon getRegulon() {
		return regulon;
	}
	
}
