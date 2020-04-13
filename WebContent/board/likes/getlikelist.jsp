<%@page import="member.MemberDto"%>
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
	String sort = request.getParameter("sort");
	
	//MemberDto mdto = (MemberDto)session.getAttribute("dto");
	String id = (String)session.getAttribute("id");
	/* if(mdto.getId()==null){
		System.out.println("dto id 널 ");
	}else{
		System.out.println("dto id 널 아님	");
	} */
	
	BoardLikesDAO dao = new BoardLikesDAO();
	List<BoardLikesDTO> list = dao.getLikeList(minrow, maxrow, id,sort);
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
