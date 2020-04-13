<%@page import="java.util.Calendar"%>
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
	
	
	Calendar c = Calendar.getInstance();

	long now = c.getTimeInMillis();
	
	
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
			
			String day = sdf.format(dto.getWriteday());
			
			long dateM = dto.getWriteday().getTime();
			
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
			ob.put("writeday",ret);
			ob.put("profilepic",dto.getProfilepic());
			arr.add(ob);
		}
	}
%>
<%=arr.toString()%>