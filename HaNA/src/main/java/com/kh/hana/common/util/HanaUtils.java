package com.kh.hana.common.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class HanaUtils {

	

	public static String rename(String originalFilename) {
		// 새파일명 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000");

		// 확장자명
		String ext = "";
		int dot = originalFilename.lastIndexOf(".");
		if(dot > -1)
			ext = originalFilename.substring(dot);
		
		return sdf.format(new Date()) + df.format(Math.random() * 999) + ext;
	}
	
	
	/**
	 * 
	 * @param cPage
	 * @param numPerPage
	 * @param totalContent
	 * @param url
	 * 
	 * totalPage 전체페이지
	 * pagebarSize 페이지바 크기 5
	 * pageNo
	 * pageStart - pageEnd
	 * 
	 * @return
	 */
	public static String getPagebar(int cPage, int numPerPage, int totalContent, String url) {
		StringBuilder pagebar = new StringBuilder(); 
		url = url + "?cPage="; // pageNo 추가전 상태
		
		final int pagebarSize = 5;
		final int totalPage = (int) Math.ceil((double) totalContent / numPerPage);
		final int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		pageEnd = totalPage < pageEnd ? totalPage : pageEnd;
		int pageNo = pageStart;
		
		pagebar.append("<nav aria-label=\"Page navigation example\">\n"
				+ "  <ul class=\"pagination justify-content-center\">");
		// [이전]
		if(pageNo == 1) {
			// cPage = 1, 2, 3, 4, 5
			/*
				<li class="page-item disabled">
			      <a class="page-link" href="#" tabindex="-1">Previous</a>
			    </li>
 
			 */
			pagebar.append(" <li class=\"page-item disabled\">\n"
					+ "      <a class=\"page-link\" href=\"#\" tabindex=\"-1\">Previous</a>\n"
					+ "    </li>");
			
		}
		else {
			/*
				<li class="page-item">
			      <a class="page-link" href="#" tabindex="-1">Previous</a>
			    </li>
			 */
			pagebar.append(" <li class=\"page-item \">\n"
					+ "      <a class=\"page-link\" href=\""+url + (pageNo - 1)+"\" tabindex=\"-1\">Previous</a>\n"
					+ "    </li>");

		}
		
		// pageNo
		while(pageNo <= pageEnd) {
			if(pageNo == cPage) {
				pagebar.append("    <li class=\"page-item active\">\n"
						+ "      <a class=\"page-link\" href=\""+url+pageNo+"\">"+pageNo+" <span class=\"sr-only\">(current)</span></a>\n"
						+ "    </li>");
			}
			else {
				pagebar.append("    <li class=\"page-item\"><a class=\"page-link\" href=\""+url+pageNo+"\">"+pageNo+"</a></li>\n"
						);
			}
			
			pageNo++;
		}
		
		
		// [다음]
		if(pageNo > totalPage) {
			pagebar.append(" <li class=\"page-item disabled\">\n"
					+ "      <a class=\"page-link\" href=\"#\" tabindex=\"-1\">Next</a>\n"
					+ "    </li>");
			 
		}

		else {
			pagebar.append(" <li class=\"page-item \">\n"
					+ "      <a class=\"page-link\" href=\""+url + pageNo+"\" tabindex=\"-1\">Next</a>\n"
					+ "    </li>");

		}
		pagebar.append("  </ul>\n"
				+ "</nav>");
		
		return pagebar.toString();
	}

}
