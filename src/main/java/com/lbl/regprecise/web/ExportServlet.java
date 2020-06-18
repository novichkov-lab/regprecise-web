package com.lbl.regprecise.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider;
import com.lbl.regprecise.dto.RegulogRegulatorDTO;
import com.lbl.regprecise.dto.RegulogStatDTO;
import com.lbl.regprecise.ent.Genome;
import com.lbl.regprecise.ent.Regulator;
import com.lbl.regprecise.ent.Regulog;
import com.lbl.regprecise.ent.Regulon;
import com.lbl.regprecise.ent.TFFamily;
import com.lbl.regprecise.ent.Term;

/**
 * @author Elena Novichkova
 *
 */
public class ExportServlet extends HttpServlet {

	private static final long serialVersionUID = -720609433205846658L;
	
	static final String TYPE_SITE = "site";
	static final String TYPE_GENE = "gene";
	static final String TYPE_REGULATOR = "regulator";
	static final String TYPE_REGULOG = "regulog";
	
	static final String FORMAT_FASTA = "fasta";
	static final String FORMAT_FASTA_EXT = "fasta_ext";
	static final String FORMAT_TABLE = "table";
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		PrintWriter pw = response.getWriter();
 
				
		ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
		String type = request.getParameter("type");
		String format = request.getParameter("format");
		
		if(type.equals(TYPE_SITE))
		{
			if(request.getParameter("regulogId") != null)
			{
				exportRegulogSites(request, dataProvider, pw);
			}
			else if(request.getParameter("regulonId") != null)
			{
				exportRegulonSites(request, dataProvider, pw);
			}
			else if(request.getParameter("genomeId") != null)
			{
				exportGenomeSites(request, dataProvider, pw);
			}

		}
		
		if(type.equals(TYPE_GENE))
		{
			if(request.getParameter("regulogId") != null)
			{
				exportRegulogGenes(request, dataProvider, pw);
			}
			else if(request.getParameter("regulonId") != null)
			{
				exportRegulonGenes(request, dataProvider, pw);
			}
			else if(request.getParameter("genomeId") != null)
			{
				exportGenomeGenes(request, dataProvider, pw);
			}			
		}		
		
		
		if(type.equals(TYPE_REGULATOR))
		{
			if(request.getParameter("tfFamId") != null)
			{
				exportTfFamilyRegualtors(request, format, dataProvider, pw);
			}			
		}

		if(type.equals(TYPE_REGULOG))
		{
			if(request.getParameter("tfFamId") != null)
			{
				exportTfFamilyRegulogs(request, format, dataProvider, pw);
			}			
		}
		
		pw.flush();
		pw.close();
	}
	
	private void exportTfFamilyRegulogs(HttpServletRequest request,
			String format, ConstrainedDataProvider dataProvider, PrintWriter pw) {
		
		Integer tfFamilyId = Integer.parseInt( request.getParameter("tfFamId") );
		TFFamily tfFamily = dataProvider.getTFFamily(tfFamilyId);
		

		
		 pw.println(
					"regulogId"
					+ "\t" + "regulatorName"
					+ "\t" + "taxonName"
					+ "\t" + "phylum"
					+ "\t" + "pathway"
					+ "\t" + "effector"
					+ "\t" + "regulatorFamily"
					+ "\t" + "genomeCount"
					+ "\t" + "regulonCount"
					+ "\t" + "siteCount"
		 );			 
		
		 List<RegulogStatDTO> regulogStats = dataProvider.getRegulogStatsDTO(tfFamily);
		 for(RegulogStatDTO rs: regulogStats)
		 {
			 pw.println("" + rs.getRegulogId()
					 + "\t" + rs.getRegulatorName()
					 + "\t" + rs.getTaxonName()
					 + "\t" + rs.getPhylum()
					 + "\t" + rs.getPathway()
					 + "\t" + rs.getEffector()
					 
					 + "\t" + rs.getRegulatorFamily()
					 + "\t" + rs.getGenomeCount()
					 + "\t" + rs.getRegulonCount()
					 + "\t" + rs.getSiteCount()
					 );
		 }
	}
	
	private void exportTfFamilyRegualtors(HttpServletRequest request,
			String format, ConstrainedDataProvider dataProvider, PrintWriter pw) {

		Integer tfFamilyId = Integer.parseInt( request.getParameter("tfFamId") );
		TFFamily tfFamily = dataProvider.getTFFamily(tfFamilyId);
		
		List<RegulogRegulatorDTO> regulators = dataProvider.getRegulogRegulatorsDTO(tfFamily);
		if(format.equals(FORMAT_FASTA) || format.equals(FORMAT_FASTA_EXT)){
			exportTfFamilyRegualtorsFasta(format, regulators, pw);
		} else if ( format.equals(FORMAT_TABLE) )
		{
			exportTfFamilyRegualtorsTable(regulators, pw);
		}		
	}

	private void exportTfFamilyRegualtorsTable(List<RegulogRegulatorDTO> regulators, PrintWriter pw) {
		pw.println("name"
				+ "\t" + "locusTag"
				+ "\t" + "vimssId"
				+ "\t" + "regulogId"
				+ "\t" + "regulonId"
				+ "\t" + "taxonId"
				+ "\t" + "genomeName"
				+ "\t" + "taxonName"
				+ "\t" + "phylum"
				+ "\t" + "pathway"
				+ "\t" + "effector"
				);
		
		
		for(RegulogRegulatorDTO rr: regulators)
		{
			pw.println(
					rr.getRegulatorName() 
					+ "\t" + rr.getRegulatorLocusTag()
					+ "\t" + rr.getRegulatorVimssId() 
					+ "\t" + rr.getRegulogId() 
					+ "\t" + rr.getRegulonId()
					+ "\t" + rr.getTaxonId()
					+ "\t" + rr.getGenomeName()					
					+ "\t" + rr.getTaxonName()					
					+ "\t" + rr.getPhylum()					
					+ "\t" + rr.getPathway()					
					+ "\t" + rr.getEffector()					
			);
		}
	}

	private void exportTfFamilyRegualtorsFasta(String format, List<RegulogRegulatorDTO> regulators, PrintWriter pw) {
		for(RegulogRegulatorDTO rr: regulators)
		{
			
			// Header
			if( format.equals(FORMAT_FASTA) ){
				pw.println(">" + rr.getRegulatorLocusTag());
				
			} else if( format.equals(FORMAT_FASTA_EXT) ){
				pw.println(">"
						+ "name=" + rr.getRegulatorName() 
						+ "; locusTag=" + rr.getRegulatorLocusTag()
						+ "; vimssId=" + rr.getRegulatorVimssId() 
						+ "; regulogId=" + rr.getRegulogId() 
						+ "; regulonId=" + rr.getRegulonId()
						+ "; taxonId=" + rr.getTaxonId()
						+ "; genomeName=" + rr.getGenomeName()
				);				
			}
			
			toFastaSequence(rr.getAaSequence(), pw);
		}
	}

	private void toFastaSequence(String seq, PrintWriter pw) {
		for(int i = 0 ; i < seq.length(); i++)
		{
			pw.print(seq.charAt(i));
			if( (i+1)%80 == 0) pw.print("\n");
		}
		pw.print("\n\n");
	}

	private void exportGenomeGenes(HttpServletRequest request,
			ConstrainedDataProvider dataProvider, PrintWriter pw) {
		
		Integer genomeId = Integer.parseInt( request.getParameter("genomeId") );		
		Genome genome = dataProvider.getGenome(genomeId);  
		List<Regulon> regulons  = dataProvider.getRegulons(genome);
		for(Regulon regulon: regulons)
		{
			if(!regulon.hasSites()) continue;
			pw.write( getRegulonHeader(regulon) );
			pw.write(regulon.exportGenes());
		}
	}

	private void exportGenomeSites(HttpServletRequest request,
			ConstrainedDataProvider dataProvider, PrintWriter pw) {
		
		Integer genomeId = Integer.parseInt( request.getParameter("genomeId") );		
		Genome genome = dataProvider.getGenome(genomeId);  
		List<Regulon> regulons  = dataProvider.getRegulons(genome);
		for(Regulon regulon: regulons)
		{
			if(!regulon.hasSites()) continue;
			pw.write( getRegulonHeader(regulon) );
			pw.write(regulon.getSitesPlainSequenceFasta());
		}
	}

	private String getRegulonHeader(Regulon regulon) {
		StringBuffer sb = new StringBuffer();
		
		sb.append("#");
		if(regulon.getRegulog().getRegulationTypeTermId() == Term.TERM_REGULATION_TYPE_TF)
		{
			sb.append(" TF - ");
		}
		else{
			sb.append(" RNA - ");
		}
		sb.append(regulon.getRegulog().getRegulatorName());
		
		boolean firstRow = true; 
		for(Regulator regulator: regulon.getRegulators())
		{
			sb.append(  firstRow ? ": " : ", " );
			sb.append(regulator.getLocusTag());
			firstRow = false;
		}
		
		sb.append("\n");
		
		return sb.toString();
	}

	
	private void exportRegulogGenes(HttpServletRequest request,
			ConstrainedDataProvider dataProvider, PrintWriter pw) 
	{		
		Integer regulogId = Integer.parseInt( request.getParameter("regulogId") );
		Regulog regulog = dataProvider.getRegulog(regulogId);
		pw.write(regulog.exportGenes());		
	}

	private void exportRegulonGenes(HttpServletRequest request,
			ConstrainedDataProvider dataProvider, PrintWriter pw) 
	{
		Integer regulonId = Integer.parseInt( request.getParameter("regulonId") );
		Regulon regulon = dataProvider.getRegulon(regulonId);
		pw.write(regulon.exportGenes());			
	}

	private void exportRegulonSites(HttpServletRequest request,
			ConstrainedDataProvider dataProvider, PrintWriter pw) 
	{		
		Integer regulonId = Integer.parseInt( request.getParameter("regulonId") );
		Regulon regulon = dataProvider.getRegulon(regulonId);
		pw.write(regulon.getSitesPlainSequenceFasta());			
	}

	private void exportRegulogSites(HttpServletRequest request,
			ConstrainedDataProvider dataProvider, PrintWriter pw) 
	{
		
		Integer regulogId = Integer.parseInt( request.getParameter("regulogId") );
		Regulog regulog = dataProvider.getRegulog(regulogId);
		pw.write(regulog.getSitesPlainSequenceFasta());
	}


}
