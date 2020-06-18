package com.lbl.regprecise.web;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider;
import com.lbl.regprecise.ent.Genome;


/**
 * @author Pavel Novichkov
 *
 */
 public class ImageGenomeNameServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
	public ImageGenomeNameServlet() {
		super();
	}   	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("image/png");

		Color textColor = Color.black;
		String name =  "Unknown";
		String genomeId = request.getParameter("genomeId");
		if(genomeId != null)
		{
			ConstrainedDataProvider dp = DataProviderHelper.getDataProvider();
			Genome genome = dp.getGenome(Integer.parseInt(genomeId));
			name = genome.getName();
		}
		String selected = request.getParameter("selected");
		boolean isSelected  = (selected != null && selected.length() == 1 && selected.charAt(0) == '1');
		if(isSelected)
		{
			name = "* " + name;
			textColor = new Color(180,0,0);
		}
		
		
		int width = 10;
		int height = 250;
		
		BufferedImage bi = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);

		Graphics2D gr = (Graphics2D)bi.getGraphics();
		gr.setColor(Color.white);
		gr.fillRect(0, 0, bi.getWidth(), bi.getHeight());
		
		
		gr.rotate( -Math.PI/2, 0,0 );
		
			
			
		gr.setColor(textColor);
		gr.drawString( name, -height , width);		
		gr.dispose();

		//Write the image as a jpg  
		ImageIO.write(bi, "png", response.getOutputStream());  
	}  	  	  	    
}