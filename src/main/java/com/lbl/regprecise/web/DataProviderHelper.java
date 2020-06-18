package com.lbl.regprecise.web;

import javax.servlet.http.HttpServletRequest;

import com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider;
import com.lbl.regprecise.dao.hibernate.StatusConstrainedDataProvider;

/**
 * @author Pavel Novichkov
 *
 */
public class DataProviderHelper {
	
	public static class Context{
		ConstrainedDataProvider dataProvider;
		ConstrainedDataProvider lacidbDataProvider;
		
		public Context()
		{
			dataProvider = new StatusConstrainedDataProvider(
					Config.MIN_REGULOG_STATUS_TERM_ID,
					Config.MIN_COLLECTION_STATUS_TERM_ID);
			lacidbDataProvider = new StatusConstrainedDataProvider( -100, -100);			
		}
		
		public void close()
		{
			if( dataProvider != null){
				dataProvider.close();
			}		
			dataProvider = null;
			if( lacidbDataProvider != null){
				lacidbDataProvider.close();
			}		
			lacidbDataProvider = null;
		}
	}
	
	private static ThreadLocal<Context> pmThreadLocal = new ThreadLocal<Context>();  
	
	public static void init(HttpServletRequest request)
	{
		pmThreadLocal.set(new Context());
	}
	
	public static ConstrainedDataProvider getLacidbDataProvider()
	{
		return pmThreadLocal.get().lacidbDataProvider;
	}
	
	public static ConstrainedDataProvider getDataProvider()	
	{
		return pmThreadLocal.get().dataProvider;
	}
	
	public static void clear()
	{
		Context context = pmThreadLocal.get();
		if( context != null){
			context.close();
		}		
		pmThreadLocal.set(null);
	}
}
