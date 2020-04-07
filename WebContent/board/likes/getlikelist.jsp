<%@page import="org.json.simple.JSONObject"%>
<%@page import="board.BoardLikesDTO"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="board.BoardLikesDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String minrow = request.getParameter("minrow");
	String maxrow = request.getParameter("maxrow");
	String id = (String)session.getAttribute("id");
	BoardLikesDAO dao = new BoardLikesDAO();
	List<BoardLikesDTO> list = dao.getLikeList(minrow, maxrow, id);
	String url=request.getContextPath();
	JSONArray arr = new JSONArray();
	if(list.size()!=0){
		for(BoardLikesDTO dto : list){
			JSONObject ob=new JSONObject();
			ob.put("num",dto.getNum());
			arr.add(ob);
		}
	}
%>
<%=arr.toString()%>	
