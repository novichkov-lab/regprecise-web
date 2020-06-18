package com.lbl.regprecise.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.lbl.regprecise.dao.hibernate.DataProvider;
import com.lbl.regprecise.ent.Collection;
import com.lbl.regprecise.ent.Cron;
import com.lbl.regprecise.ent.Gene;
import com.lbl.regprecise.ent.Genome;
import com.lbl.regprecise.ent.Ortholog;
import com.lbl.regprecise.ent.Regulator;
import com.lbl.regprecise.ent.Regulog;
import com.lbl.regprecise.ent.Regulon;

/**
 * @author Pavel Novichkov
 *
 */
public class MultiRegulogOrthologMap {
	private Hashtable<Integer, Integer> genomeMoId2Index = new Hashtable<Integer, Integer>();;
	private Hashtable<Integer,OrthologRow> geneMoId2OrtRow = new Hashtable<Integer,OrthologRow>();
	private List<OrthologRow> orthologRows = new ArrayList<OrthologRow>();
	List<Genome> genomes;
	
	public MultiRegulogOrthologMap(List<Genome> genomes){
		this.genomes = genomes;
		buildGenomesIndex();
	}

	public void processRegulog(Regulog regulog) throws Exception {
		
		for(Cron cron: regulog.getCrons()){
			for(Ortholog ort: cron.getOrthologs()){
				
				OrthologRow targetOrtRow = null;
				
				// Search for target ortholog row
				for(Gene gene: ort.getGenes()){
					if(gene.getOperon().hasSites()){
						// Search for ortholog rows that have the same gene
						OrthologRow ortRow = geneMoId2OrtRow.get(gene.getMoId());						
						if(ortRow == null) continue;
						
						if(targetOrtRow == null){
							targetOrtRow = ortRow;
						} else if(targetOrtRow != ortRow){
							throw new Exception("Genes from DB ortholog belongs to diffrent OrthologRows");
						}
					}
				}
				
				if(targetOrtRow == null){
					targetOrtRow = new OrthologRow();
					orthologRows.add(targetOrtRow);
				}
				populateOrthologRow(targetOrtRow, ort);
			}
		}
	}

	private void populateOrthologRow(OrthologRow ortRow, Ortholog ort) {
		
		boolean regGenesAdded = false;
		for(Gene gene: ort.getGenes()){
			if(!gene.getOperon().hasSites()) continue;
			
			Regulon regulon = gene.getRegulon();
			Integer genomeIndex = genomeMoId2Index.get(regulon.getGenome().getMoId());

			if(ortRow.cells[genomeIndex] == null){
				ortRow.cells[genomeIndex] = new Cell();
			}
			
			for(Regulator regulator: regulon.getRegulators()){
				ortRow.cells[genomeIndex].addRegualtedGene(gene, regulator);
				geneMoId2OrtRow.put(gene.getMoId(), ortRow);
				regGenesAdded = true;
			}
		}		
		
		if(regGenesAdded){
			ortRow.orthologs.add(ort);
		}
	}

	private void buildGenomesIndex() {		
		for(int i = 0 ; i < genomes.size(); i++){
			genomeMoId2Index.put(genomes.get(i).getMoId(), i);
		}
	}
	
	public class OrthologRow{
		Cell[] cells = new Cell[genomes.size()];
		List<Ortholog> orthologs = new ArrayList<Ortholog>();
		
		public void write(PrintWriter pw){
			pw.write("\n");
			
			pw.write("ortCount=" +  orthologs.size());
			pw.write(";OrtName=");
			for(Ortholog ort: orthologs){
				pw.write("," + ort.getName());
			}
			
			for(Cell cell: cells){
				pw.write("\t");
				if(cell == null){
					pw.write("null");
				} else{
					cell.write(pw);
				}
			}
			
			pw.write("\t");
			pw.write("OrtFunction=");
			for(Ortholog ort: orthologs){
				pw.write("," + ort.getFunction());
			}
			
			
		}
	}
	
	public class Cell{
		List<RegulatedGene> regGenes = new ArrayList<RegulatedGene>();
		
		public void addRegualtedGene(Gene gene, Regulator regulator){
			RegulatedGene targetRegGene = null;
			for(RegulatedGene rg: regGenes){
				if(rg.gene.getMoId().intValue() == gene.getMoId().intValue()){
					targetRegGene = rg;
					break;
				}
			}
			if(targetRegGene == null){
				targetRegGene = new RegulatedGene(gene);
				regGenes.add(targetRegGene);
			}
			targetRegGene.regulators.add(regulator);
		}
		
		public void write(PrintWriter pw){
			for(RegulatedGene rg: regGenes){
				pw.write(";");
				rg.write(pw);
			}
		}
	}
	
	public class RegulatedGene{
		Gene gene;
		List<Regulator> regulators = new ArrayList<Regulator>();
		public RegulatedGene(Gene gene){
			this.gene = gene;
		}
		
		public void write(PrintWriter pw){
			pw.write(gene.getLocusTag() + ":");
			for(Regulator regulator: regulators){
				pw.write(",");
				pw.write(regulator.getRegulon().getRegulog().getRegulatorName());
			}
		}		
	}	
	
	private void print() {
		PrintWriter pw = new PrintWriter(System.out);
		
		for(Genome genome: genomes){
			pw.write("\t" + genome.getName());
		}
		
		for(OrthologRow ortRow: orthologRows){
			if(ortRow.orthologs.size() > 0){
				ortRow.write(pw);
			}
		}
		pw.flush();
	}	
	public static void main(String[] args) throws Exception{
		int collectionId = 6;
		int[] regulogIds = new int[]{3036,809, 4823};
		DataProvider dp = new DataProvider();
		
		Collection col = dp.getCollection(collectionId);
		MultiRegulogOrthologMap map = new MultiRegulogOrthologMap(col.getGenomes());
		for(int regulogId: regulogIds){
			Regulog regulog = dp.getRegulog(regulogId);
			System.out.print("Processing regulog: " + regulog.getRegulatorName() + "...");
			map.processRegulog(regulog);
			System.out.println(" Done!");
		}
		
		map.print();
	}

}
