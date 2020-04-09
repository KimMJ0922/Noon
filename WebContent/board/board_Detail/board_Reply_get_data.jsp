<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="reply.ReplyDTO"%>
<%@page import="java.util.List"%>
<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String boardnum =request.getParameter("boardnum");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	request.setCharacterEncoding("UTF-8");
	ReplyDAO dao=new ReplyDAO();
	System.out.println(boardnum);
	List<ReplyDTO> list= dao.getAllDatas(boardnum);
	JSONArray arr = new JSONArray();
	if(list.size()!=0){
		for(ReplyDTO dto : list){
			JSONObject ob=new JSONObject();
			ob.put("boardnum",dto.getBoardnum());
			ob.put("replynum",dto.getReplynum());
			ob.put("parentnum",dto.getParentnum());
			ob.put("sortnum",dto.getSortnum());
			ob.put("name",dto.getName());
			ob.put("content",dto.getContent());
			ob.put("writeday",sdf.format(dto.getWriteday()));
			arr.add(ob);
		}
	}
%>
<%=arr.toString()%>