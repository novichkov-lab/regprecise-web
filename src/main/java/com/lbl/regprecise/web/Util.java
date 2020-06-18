package com.lbl.regprecise.web;

import java.io.StringReader;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;

import com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider;
import com.lbl.regprecise.ent.Gene;
import com.lbl.regprecise.ent.Operon;
import com.lbl.regprecise.ent.Ortholog;
import com.lbl.regprecise.ent.Regulog;
import com.lbl.regprecise.ent.Regulon;
//import com.lbl.regus.util.PhylogeneticTree;
//import com.lbl.regus.util.PhylogeneticTreeNode;

/**
 * @author Pavel Novichkov
 *
 */
public class Util {

	static public double RATIO = .025;
	static public int FIXED_TABLE_WIDTH = 400;
	
	
	public int getGenePixelLength(Gene gene)
	{
		if(!(gene.getPosMax() == null)) {
			return (int)Math.abs(((gene.getPosMax() - gene.getPosMin())*RATIO));
		}
		else return 30;
	}
	
	
//	public PhylogeneticTree getRegulogTree(int regulogId) throws Exception
//	{
//		ConstrainedDataProvider dp = DataProviderHelper.getDataProvider();
//        Regulog regulog = dp.getRegulog(regulogId);	       
//        PhylogeneticTree tree = new PhylogeneticTree();
//        tree.load(new StringReader(regulog.getGenomeTree()), PhylogeneticTreeNode.class);        
//        return tree;		
//	}
	
	
//    public void sortSubRegulons(PhylogeneticTree tree, List<SubRegulon> subRegulons) {
//    	
//        int index = 0;
//        final Hashtable<Integer, Integer> genomeId2Index = new Hashtable<Integer, Integer>();
//        for(PhylogeneticTreeNode node: tree.getLeaves())
//        {
//                int genomeId = Integer.parseInt(node.getLabel());
//                genomeId2Index.put(genomeId, index++);
//        }
//        
//        // hack
//        for(int i = subRegulons.size() - 1; i >= 0; i--)
//        {
//        	SubRegulon sr = subRegulons.get(i);        	
//        	if( ! genomeId2Index.containsKey(sr.getRegulon().getGenome().getMoId()) )
//        	{
//        		subRegulons.remove(i);
//        	}
//        }
//                        
//        Collections.sort(subRegulons, new Comparator<SubRegulon>(){
//                public int compare(SubRegulon r1, SubRegulon r2) {
//                        Integer index1 = genomeId2Index.get(r1.getRegulon().getGenome().getMoId());
//                        Integer index2 = genomeId2Index.get(r2.getRegulon().getGenome().getMoId());
//                        return index1.compareTo(index2);
//                }});
//    }	
	
	public int getTableWidth(List<SubRegulon> subRegulons) {
		int maxwidth = 0;
		for(SubRegulon subRegulon: subRegulons) {
			maxwidth = Math.max(subRegulon.getPixelLength(), maxwidth);
		}
		
		return maxwidth+FIXED_TABLE_WIDTH;
			
	}
	
	public Hashtable<Ortholog, String> getOrthologsColor(List<SubRegulon> subRegulons)
	{
		ColorProvider colorProvider = new ColorProvider();
		Hashtable<Ortholog, String> ortholog2ColorHash = new Hashtable<Ortholog, String>();
		HashSet<Ortholog> orthologs = new HashSet<Ortholog>();
		for(SubRegulon subRegulon: subRegulons)
		{
			for(Operon operon: subRegulon.getOperons())
			{
				for(Gene gene: operon.getGenes())
				{
					Ortholog ortholog = gene.getOrtholog();
					if(orthologs.contains(ortholog)){
						
						ortholog2ColorHash.put(ortholog, colorProvider.nextColor());
					}
					
					orthologs.add(ortholog);
				}
			}
		}
		
		return ortholog2ColorHash;
	}
	
	public List<SubRegulon> getOrthologousOperons(Operon srcOperon) {
		HashSet<Ortholog> operonOrthologs = getOperonOrthologs(srcOperon);

		List<SubRegulon> subRegulons = new Vector<SubRegulon>();
		Regulog regulog = srcOperon.getRegulon().getRegulog();
		for (Regulon regulon : regulog.getRegulons()) {
			SubRegulon subRegulon = new SubRegulon(regulon);

			if (regulon == srcOperon.getRegulon()) {
				subRegulon.addOperon(srcOperon);
			} else {
				// Populate operons
				for (Operon operon : regulon.getOperons()) {
					for (Gene gene : operon.getGenes()) {
						if (operonOrthologs.contains(gene.getOrtholog())) {
							subRegulon.addOperon(operon);
							break;
						}
					}
				}
			}
			subRegulons.add(subRegulon);
		}

		return subRegulons;
	}

	private HashSet<Ortholog> getOperonOrthologs(Operon operon) {
		HashSet<Ortholog> orthologs = new HashSet<Ortholog>();
		for (Gene gene : operon.getGenes()) {
			orthologs.add(gene.getOrtholog());
		}
		return orthologs;
	}

	public void test() {
		HashSet<Integer> set = new HashSet<Integer>();

		for (int i = 0; i < 100; i++) {
			set.add(i);
		}

		System.out.println("set has 1001: " + set.contains(1001));
		System.out.println("set has 5: " + set.contains(5));
	}

	public static void main(String[] args) {
		new Util().test();
	}

	public static int getFIXED_TABLE_WIDTH() {
		return FIXED_TABLE_WIDTH;
	}

	public static void setFIXED_TABLE_WIDTH(int fIXED_TABLE_WIDTH) {
		FIXED_TABLE_WIDTH = fIXED_TABLE_WIDTH;
	}
}