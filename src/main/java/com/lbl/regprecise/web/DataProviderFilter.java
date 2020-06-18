package com.lbl.regprecise.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * @author Pavel Novichkov
 *
 */
public class DataProviderFilter implements Filter {

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		
		try {
			onRequestBegin(httpServletRequest);
			chain.doFilter(request, response);
		} 
		finally {
			onRequestEnd(httpServletRequest);
		}		
	}

	public void init(FilterConfig filterConfig) throws ServletException {
	}
	
	private void onRequestBegin(HttpServletRequest request) {
		DataProviderHelper.init(request);
	}

	private void onRequestEnd(HttpServletRequest request){
		DataProviderHelper.clear();
	}
}
