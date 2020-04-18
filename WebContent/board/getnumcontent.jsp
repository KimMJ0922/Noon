<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
	
	BoardDAO dao = new BoardDAO();
	String con = dao.getNumContent(num);
	String href = "main.jsp?view=board/board_Detail/board_Detail_form.jsp?num="+num;
	
	String dark = (String)session.getAttribute("dark_check");
	String color = "color:black";
	if(dark.equals("1")){
		color = "color:white";
	}
%>

	<pre class="con">
		<a href="<%=href%>" style="<%=color%>">
			<%=con%>
		</a>
	</pre>

