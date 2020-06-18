package com.lbl.regprecise.web;

import java.text.NumberFormat;

import com.lbl.regprecise.ent.Regulog;
import com.lbl.regprecise.ent.Site;
import com.lbl.regprecise.ent.Term;

/**
 * @author Pavel Novichkov
 *
 */
public class Formatter {
    static NumberFormat nf = NumberFormat.getInstance();
    
    static{
        nf.setMaximumFractionDigits(1);
    }
    
    public static String formatSiteScore(float score)
    {
    	return nf.format(score);
    }
    
    public static String toNotNull(String val)
    {
    	return val != null? val : "";
    }
    
    
    public static String formatSiteSequence(Site site)
    {
    	Regulog regulog = site.getRegulon().getRegulog();
    	if(regulog.getRegulationTypeTermId() == Term.TERM_REGULATION_TYPE_TF)
    	{
    		return site.getSequence();
    	}
    	else if(regulog.getRegulationTypeTermId() == Term.TERM_REGULATION_TYPE_RNA){
    		return site.getSequence().length() > 15 ? site.getSequence().substring(0, 15) + "...": site.getSequence(); 
    	}
    	return "";
    }
    
    public static String getDescriptionPart1(String text)
    {    	
    	int lastIndex = getDescriptionPart1LastIndex(text);
    	return text.substring(0,lastIndex);
    }
    
    public static String getDescriptionPart2(String text)
    {    	
    	int firstIndex = getDescriptionPart1LastIndex(text);
    	return text.substring(firstIndex);
    }
    
    private static int getDescriptionPart1LastIndex(String text)
    {
    	int maxLength = 600;
    	
    	if(text.length() <= maxLength) return text.length();
    	if( text.charAt(maxLength - 1) == '.' 
    			&& !text.startsWith("e.g.", maxLength -2)
    			&& !text.startsWith("e.g.", maxLength -4)
    			
    	) return maxLength;
    	
    	int i = maxLength;
    	for(; i < text.length(); i++)
    	{
    		char ch = text.charAt(i);
    		if(ch == '.' 
    			&& !text.startsWith("e.g.", i -1)
    			&& !text.startsWith("e.g.", i -3)
    			) break;
    	}
    	return i < text.length() ? i + 1: text.length();
    }   
}
