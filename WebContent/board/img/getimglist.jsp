<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardImgDAO"%>
<%@page import="board.BoardImgDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String minrow = request.getParameter("minrow");
	String maxrow = request.getParameter("maxrow");
	String sort = request.getParameter("sort");
	String text = request.getParameter("text");
	BoardImgDAO dao = new BoardImgDAO();
	System.out.println("getimglist.jsp에 text : "+text);
	List<BoardImgDTO> list = dao.getImglist(minrow,maxrow,sort,text);
	
	String url=request.getContextPath();
	JSONArray arr = new JSONArray();
	if(list.size()!=0){
		for(BoardImgDTO dto : list){
			String num = dto.getNum();
			String fileName = url+"/save/"+dto.getImgfile();
			JSONObject ob=new JSONObject();
			ob.put("num",num);
			ob.put("file",fileName);
			arr.add(ob);
		}
%>
		<%=arr.toString()%>
<% 
	}
%>
	
