package com.lbl.regprecise.web;

/**
 * @author Pavel Novichkov
 *
 */
public class ColorProvider {
	
	String[] colors = new String[]{
			"#22F",
			"#66F",
			"#AAF",
			"#CCF",
	};
	
	int index = -1;
	
	public void init()
	{
		index = -1;
	}
	
	public String nextColor()
	{
		index = (index + 1) % colors.length;
		return colors[index];
	}
}
