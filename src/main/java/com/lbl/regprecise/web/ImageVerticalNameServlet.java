package com.lbl.regprecise.web;

import java.awt.Color;
import java.awt.Graphics2D;
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
 public class ImageVerticalNameServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   int defaultWidth = 10;
   int defaultHeight = 250;
   

	public ImageVerticalNameServlet() {
		super();
	}   	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int width = defaultWidth;
		int height = defaultHeight;
		
		response.setContentType("image/png");

		String name = request.getParameter("name");
		if(name == null) name = "Unknown";
		
		String widthStr = request.getParameter("width");
		if(widthStr != null) width = Integer.parseInt(widthStr);
		
		String heightStr = request.getParameter("heigth");
		if(heightStr != null) height = Integer.parseInt(heightStr);
		
		BufferedImage bi = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);

		Graphics2D gr = (Graphics2D)bi.getGraphics();
		gr.setColor(Color.white);
		gr.fillRect(0, 0, bi.getWidth(), bi.getHeight());
		
		
		gr.rotate( -Math.PI/2, 0,0 );
		
		gr.setColor(Color.black);
		gr.drawString( name, -height , width);		
		gr.dispose();

		//Write the image as a jpg  
		ImageIO.write(bi, "png", response.getOutputStream());  
	}  	  	  	    
}