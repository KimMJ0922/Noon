<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="history.HistoryDTO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="history.HistoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = "qwe";
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
	HistoryDAO dao = new HistoryDAO();
	List<HistoryDTO> list = dao.getHistory(id);
	JSONArray arr = new JSONArray();
	if(list.size()!=0){
		for(HistoryDTO dto : list){
			JSONObject ob = new JSONObject();
			ob.put("fromid",dto.getFormid());
			ob.put("action",dto.getAction());
			ob.put("actionday",sdf.format(dto.getActionday()));
			
			arr.add(ob);
		}
	}
%>

<%=arr.toString() %>