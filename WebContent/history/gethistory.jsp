<%@page import="format.DateFormat"%>
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
	DateFormat df = new DateFormat();
	
%>
	<ul>
<%
	String img = "profile/default.png";
	for(HistoryDTO dto : list){
		if(dto.getProfilepic()!=null&&!dto.getProfilepic().equals("")){
			img = "profile/"+dto.getFormid()+"/"+dto.getProfilepic();
		}
		String str = "";
		if(dto.getAction().indexOf("좋아요")>=0||dto.getAction().indexOf("댓글")>=0){
			str = "main.jsp?view=board/board_Detail/board_Detail_form.jsp?num="+dto.getBoardnum();
%>
		<li class="alamLi">
			<img src="<%=img %>">
			<a class="move" href="<%=str %>">
				<%=dto.getFormid() %>님이 회원님의 게시물에 <%=dto.getAction() %><br>
			</a>
			<button type="button" class="alamDelBtn"
					num="<%=dto.getNum()%>">
				삭제
			</button>
			<span class="actionday" >
				<%=df.dateFormat(dto.getActionday()) %>
			</span>
		</li>
<%
		
		}else if(dto.getAction().indexOf("팔로우")>=0){
%>
		<li class="alamLi">
			<img src="<%=img %>">
			<a class="showProfile"><%=dto.getFormid() %></a>님이 회원님을 <%=dto.getAction() %><br>
			<button type="button" class="alamDelBtn" 
					num="<%=dto.getNum()%>">
				삭제
			</button>
			<span class="actionday">
				<%=df.dateFormat(dto.getActionday()) %>
			</span>
		</li>
			
<%
		}
	}
%>

	</ul>