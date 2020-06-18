package com.lbl.regprecise.web;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Polygon;
import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Pavel Novichkov
 *
 */
public class ImageOperonServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   final int signalWindow = 20;
   final int signalHeight = 4;
   final int signalHeadRadius = 5;
   final int geneHeight = 5;
   final int geneWidth = 13;
   final int geneArrowWidth = 5;
   
   final int geneGap = 5;
   
   final Color signalHead_OutlineColor = new Color(0,0,0);
   final Color signalHead_FillColor = new Color(10,0,200);
   final Color backgroundColor = new Color(230,230,250);
   final Color gene_OutlinColor = new Color(0,0,10);
   
   
   final int defaultSiteCount = 1;
   final int defaultGeneCount = 1; 
 
	public ImageOperonServlet() {
		super();
	}   	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("image/png");

		int siteCount = defaultSiteCount;
		int geneCount = defaultGeneCount;
		
		String siteCountPrm = request.getParameter("site_count");
		if(siteCountPrm != null) siteCount = Integer.parseInt(siteCountPrm);

		String geneCountPrm = request.getParameter("gene_count");
		if(geneCountPrm != null) geneCount = Integer.parseInt(geneCountPrm);
		
		String operonId = request.getParameter("operon_id");
		BufferedImage bi = new BufferedImage(getWidth(geneCount, siteCount), 40,
				BufferedImage.TYPE_INT_ARGB);

		Graphics2D gr = (Graphics2D)bi.getGraphics();
		 
		// Clear backgroundColor
		gr.setColor(backgroundColor);
		gr.fillRect(0, 0, bi.getWidth(), bi.getHeight());

		// Draw picture
		int xStart = 0;
		drawCentralLine(gr, bi);
		xStart = drawSignals(gr, bi, xStart, siteCount);
		drawOperon(gr, bi, geneCount, xStart);
		
		// Dispose graphics
		gr.dispose();

		//Write the image as a png  
		ImageIO.write(bi, "png", response.getOutputStream());  
	}

	private int getWidth(int geneCount, int siteCount) {
		return signalWindow*siteCount + geneGap + (geneWidth + geneArrowWidth + geneGap)*geneCount + geneGap;
	}

	private void drawOperon(Graphics2D gr, BufferedImage bi, int geneCount, int xStart) {
				
		int x = xStart;
		int y = bi.getHeight()/2;
		for(int i = 0; i < geneCount; i++)
		{
			x += geneGap;
			
			int x1 = x; // left
			int y1 = y - geneHeight; // upper
			int x2 = x + geneWidth; // right;
			int y2 = y + geneHeight; // down
			int x3 = x + geneWidth + geneArrowWidth;
			
			Polygon p = new Polygon();
			p.addPoint(x1, y1);
			p.addPoint(x2, y1);
			p.addPoint(x3, y);
			p.addPoint(x2, y2);
			p.addPoint(x1, y2);
			
			gr.setColor(Color.white);
			gr.fillPolygon(p);
			gr.setColor(gene_OutlinColor);
			gr.drawPolygon(p);
			x += geneWidth + geneArrowWidth;
		}
	}

	private int drawSignals(Graphics2D gr, BufferedImage bi, int xStart, int siteCount) {
		for(int i = 0; i < siteCount; i++)
		{
			xStart = drawSignal(gr, bi, xStart);
		}
		return xStart;
	}
	
	private int drawSignal(Graphics2D gr, BufferedImage bi, int xStart) {
		gr.setColor(Color.black);
		
		int yCenter = bi.getHeight()/2;
		int xCenter = xStart + signalWindow/2;
		
		// Stem
//		gr.setColor(Color.black);
//		gr.drawLine(x, y, x, y - signalHeight);
		
		// Head
		gr.setColor(signalHead_FillColor);
		fillCircle(gr,xCenter, yCenter,  signalHeadRadius);
		gr.setColor(signalHead_OutlineColor);
		drawCircle(gr,xCenter, yCenter,  signalHeadRadius);
		return xStart + signalWindow;
	}

	private void drawCircle(Graphics2D gr, int x, int y, int radius)
	{
		gr.drawOval(x-radius, y-radius, radius*2, radius*2);
	}
	
	private void fillCircle(Graphics2D gr, int x, int y, int radius)
	{
		gr.fillOval(x-radius, y-radius, radius*2, radius*2);
	}
	
	private void drawCentralLine(Graphics2D gr, BufferedImage bi) {
		gr.setColor(Color.black);
		int x1 = 0;
		int x2 = bi.getWidth();
		int y = bi.getHeight()/2;
		
		gr.drawLine(x1, y, x2, y);
	}
}