package com.lbl.regprecise.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;

import com.lbl.regprecise.ent.Cron;
import com.lbl.regprecise.ent.Gene;
import com.lbl.regprecise.ent.Operon;
import com.lbl.regprecise.ent.Ortholog;
import com.lbl.regprecise.ent.Regulon;
import com.lbl.regprecise.ent.Site;

/**
 * @author Pavel Novichkov
 *
 */
public class OrthologMap {
	
	List<Regulon> regulons;
	Cron cron;
	Hashtable<Regulon,Integer> regulon2ColumnIndexHash = new Hashtable<Regulon, Integer>();
	List<OrthologRow> orthologRows;
	List<OperonDescriptor> operonDescriptors;
	final String noRegulationColor = "#FAA";
		
	
	public OrthologMap(ColorProvider colorProvider, List<Regulon> regulons, Cron cron)
	{
		this.regulons = regulons;
		this.cron = cron;
		buildRegulon2ColumnIndexHash();
		buildOperonDescriptors();
		buildOrthologRows();
		colorOperons(colorProvider);
	}
	
	
	private void buildOperonDescriptors() {
		operonDescriptors = new ArrayList<OperonDescriptor>();
		for(Operon operon: cron.getOperons())
		{
			operonDescriptors.add(new OperonDescriptor(operon));
		}
		
		
		Collections.sort(operonDescriptors, new Comparator<OperonDescriptor>() {

			public int compare(OperonDescriptor od1, OperonDescriptor od2) {
				boolean hasSites1 = od1.operon.hasSites();
				boolean hasSites2 = od2.operon.hasSites();
				int gcount1 = od1.operon.getGenes().size();
				int gcount2 = od2.operon.getGenes().size();
				
				if(hasSites1 && hasSites2)
				{
					return gcount1 < gcount2 ? 1 : (gcount1 > gcount2 ? -1 : 0 );
				}
				
				if(hasSites1) return -1;
				if(hasSites2) return 1;
				return gcount1 < gcount2 ? 1 : (gcount1 > gcount2 ? -1 : 0 );
			}
		});
		
	}


	private void colorOperons(ColorProvider colorProvider) {
	
		try{
		
		ColorProvider[] colorProviders = new ColorProvider[regulons.size()];
		for(int i = 0 ; i < colorProviders.length; i++)
		{
			colorProviders[i] = new ColorProvider();
		}
		
		
		
		Hashtable<Operon,OperonDescriptor> operon2OperonDescriptrHash = buildOperon2OperonDescriptrHash();		
		for(OrthologRow orthologRow: orthologRows)
		{
			for(int i = 0 ; i < orthologRow.items.length; i++)
			{
				MapItem item = orthologRow.items[i];
				if(item == null) continue;
				for(Gene gene: item.getGenes())
				{
					Operon operon = gene.getOperon();
					OperonDescriptor operonDescriptor = operon2OperonDescriptrHash.get(operon);
					if(operon.hasSites())
					{
						if(!operonDescriptor.isAnalyzed)
						{
							operonDescriptor.color = colorProviders[i].nextColor();
							operonDescriptor.isAnalyzed = true;
						}
					}
					else{
						operonDescriptor.color = noRegulationColor;
					}
				}
			}
		}
		
		Hashtable<Gene,MapItem> gene2mapItems = buildGene2MapItemHash();
		for(OperonDescriptor od: operonDescriptors)
		{
			for(Gene gene: od.operon.getGenes())
			{
				MapItem item = gene2mapItems.get(gene);
				if(item != null)
				{
					if(!item.color.equals(noRegulationColor)) continue;
					item.color = od.color;
				}
			}
		}
		} catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	private Hashtable<Operon, OperonDescriptor> buildOperon2OperonDescriptrHash() {
		Hashtable<Operon, OperonDescriptor> hash = new Hashtable<Operon, OperonDescriptor>();
		for(OperonDescriptor od: operonDescriptors)
		{
			hash.put(od.operon, od);
		}
		return hash;
	}


	private Hashtable<Gene, MapItem> buildGene2MapItemHash() {
		Hashtable<Gene,MapItem> gene2mapItems = new Hashtable<Gene, MapItem>();
		for(OrthologRow row: orthologRows)
		{
			for(MapItem item: row.items)
			{
				if(item != null && item.hasGenes())
				{
					for(Gene gene: item.genes)
					{
						gene2mapItems.put(gene, item);
					}
				}
			}
		}
		return gene2mapItems;
	}


	public int getColumnCount()
	{
		return regulons.size();
	}
	
	public int getRowCount()
	{
		return orthologRows.size();
	}
	
	
	public Ortholog getOrtholog(int rowIndex)
	{
		return orthologRows.get(rowIndex).ortholog;
	}
	
	public String getItemHTML(int rowIndex, int columnIndex)
	{
		MapItem item = orthologRows.get(rowIndex).items[columnIndex];
		return item != null? item.getHTML() : "";
	}
	
	public List<Gene> getGenes(int rowIndex, int columnIndex)
	{
		MapItem item = orthologRows.get(rowIndex).items[columnIndex];
		return item != null? item.genes : null;
	}
	
	public String getOperonColor(int rowIndex, int columnIndex)
	{
		MapItem item = orthologRows.get(rowIndex).items[columnIndex];
		return item != null? item.color : "#FFF";
	}
	
	public boolean hasSites(int rowIndex, int columnIndex)
	{
		MapItem item = orthologRows.get(rowIndex).items[columnIndex];
		return item.hasSites();
	}

	
	public boolean hasRegulatedGenes(int rowIndex)
	{
		for(MapItem item: orthologRows.get(rowIndex).items)
		{
			if(item != null && item.hasRegulatedGenes() )
			{
				return true;
			}
		}
		return false;
	}
	

	private void buildOrthologRows() {
		orthologRows = new ArrayList<OrthologRow>(cron.getOrthologs().size());
		
		HashSet<Ortholog> consideredOrthologs = new HashSet<Ortholog>(); 
		for(OperonDescriptor operonDescriptor: operonDescriptors)
		{
			for(Gene gene: operonDescriptor.operon.getGenes())
			{
				Ortholog ortholog = gene.getOrtholog();
				if(!consideredOrthologs.contains(ortholog))
				{
					orthologRows.add(new OrthologRow(ortholog));
					consideredOrthologs.add(ortholog);
				}
			}
		}
	}

	private void buildRegulon2ColumnIndexHash() {
		for(int i = 0; i < regulons.size(); i++)
		{
			regulon2ColumnIndexHash.put(regulons.get(i), i);
		}
	} 

	
	class OperonDescriptor
	{
		Operon operon;
		String color;
		boolean isAnalyzed;
		
		public OperonDescriptor(Operon operon) {
			this.operon = operon;
		}
	}
	
	class OrthologRow{
		Ortholog ortholog;
		MapItem[] items = new MapItem[regulons.size()];
		public OrthologRow(Ortholog ortholog)
		{
			this.ortholog = ortholog;
			for(Gene gene: ortholog.getGenes())
			{
				int index = regulon2ColumnIndexHash.get( gene.getRegulon() );
				if( items[index] == null )
				{
					items[index] = new MapItem(); 
				}
				items[index].addGene(gene); 
			}
		}
	}
	
	
	class MapItem{
		String color = noRegulationColor;
		List<Gene> genes = new ArrayList<Gene>(1);
		
		public MapItem() {
		}

		public boolean hasRegulatedGenes() {
			for(Gene gene: genes)
			{
				if(gene.getOperon().hasSites()) return true;
			}
			return false;
		}

		public List<Gene> getGenes()
		{
			return genes;
		}

		public void addGene(Gene gene)
		{
			genes.add(gene);
		}
		
		public boolean hasGenes()
		{
			return genes.size() > 0;
		}
		
		public boolean hasSites()
		{
			for(Gene gene: genes)
			{
				if(gene.hasSites()) return true;
			}			
			return false;
		}
		
		public int getGeneIndex()
		{
			int minIndex = genes.get(0).getOperonIndex();
			for(Gene gene: genes)
			{
				int index = gene.getOperonIndex();
				if(index < minIndex){
					minIndex = index;
				}
			}
			
			return minIndex + 1;			
		}	
		
		public String getHTML()
		{
			StringBuffer sb = new StringBuffer();
			for(Gene gene: genes)
			{
				for(Site site: gene.getSites())
				{
					sb.append("<br><br>");
					sb.append("<b>Site:</b> <br> position = " + site.getRelativePosition() 
							+ "<br> score = " + site.getScore() 
							+ " <br> sequence = " +  Formatter.formatSiteSequence( site) );
				}
				
				sb.append("<br><br>");				
				String function = gene.getFunction();
				sb.append("<b>Gene:</b> " + gene.getLocusTag()
						+  ( (function != null && function.length() > 0) ? ": " + function : "") );
				
			}			
			return sb.toString();
		}
	}
}
