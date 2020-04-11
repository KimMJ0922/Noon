<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardDAO dao = new BoardDAO();
	String minrow = request.getParameter("minrow");
	String maxrow = request.getParameter("maxrow");
	String sort = request.getParameter("sort");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm",Locale.KOREA);
	List<BoardDTO> list = dao.getBoardList(minrow,maxrow,sort);
	
	//시간 구하기
	Calendar c = Calendar.getInstance();

	long now = c.getTimeInMillis();
   
	JSONArray arr = new JSONArray();
	for(BoardDTO dto : list){
		JSONObject ob=new JSONObject();
		ob.put("num",dto.getNum());
		ob.put("id",dto.getId());
		ob.put("nickname",dto.getNickname());
		ob.put("content",dto.getContent());
		ob.put("likes",dto.getLikes());
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
		ob.put("reply",dto.getReply());
		arr.add(ob);
	}
%>
<%=arr.toString()%>