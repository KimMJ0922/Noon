<%@page import="java.util.Calendar"%>
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
	String id = (String)session.getAttribute("id");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
	HistoryDAO dao = new HistoryDAO();
	List<HistoryDTO> list = dao.getHistory(id);
	
	//시간 구하기
	Calendar c = Calendar.getInstance();

	long now = c.getTimeInMillis();
		
	JSONArray arr = new JSONArray();
	if(list.size()!=0){
		for(HistoryDTO dto : list){
			JSONObject ob = new JSONObject();
			ob.put("num",dto.getNum());
			ob.put("fromid",dto.getFormid());
			ob.put("action",dto.getAction());
			String day = sdf.format(dto.getActionday());
			long dateM = dto.getActionday().getTime();
			
			long gap = now - dateM;

	        String ret = "";
	        
	        gap = (long)(gap/1000);
	        long hour = gap/3600;
	        gap = gap%3600;
	        long min = gap/60;
	        long sec = gap%60;

	        if(hour > 24){
	            ret = day;
	        }
	        else if(hour > 0){
	            ret = hour+"시간 전";
	        }
	        else if(min > 0){
	            ret = min+"분 전";
	        }
	        else if(sec >= 0){
	            ret = sec+"초 전";
	        }
	        else{
	            ret = day;
	        }
	        
	        
			ob.put("actionday",ret);
			ob.put("profilepic",dto.getProfilepic());
			arr.add(ob);
		}
	}
%>

<%=arr.toString() %>