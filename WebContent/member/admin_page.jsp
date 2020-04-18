<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	MemberDao dao=new MemberDao();
	List<MemberDto> list= new Vector<MemberDto>();
	String id = request.getParameter("id");
	if(id==null||id.equals("")){
		id="";
		list = dao.getadmindata();
	}else{
		list = dao.getadmindata(id);
	}	
	
 	
 	String dark="";
 	dark=(String)session.getAttribute("dark_check");
	if(dark.equals("0")){
  		
  	}else if(dark.equals("1")){
 %>
  	  <link rel="stylesheet" href="css/dark/admin_dark.css" />
 <%	
  	}
 %>
	

<style>
button{
border:none;
background: none;
}
.search_admin{
float: right;
margin-right: 50px;
margin-top:20px;
border-radius: 5px;
}

table{
clear: both;
}
</style>
<table class="table">
		<caption>회원 정보</caption>
		<thead>
			<th>아이디</th>
			<th>이름</th>
			<th>회원등급</th>
			<th>업</th>
			<th>다운</th>
			<th>삭제</th>
		</thead>
<%
	for(MemberDto dto:list){
%>
	
	<tbody>
		<td width="200px"><%=dto.getId() %></td>
		<td width="200px"><%=dto.getName() %></td>
		<td width="150px"><%=dto.getType() %></td>
		<td width="50px">
      		<button class="glyphicon glyphicon-arrow-up up" type="button" 
      				id="<%=dto.getId()%>" member="<%=dto.getType()%>">
     	 	</button>
     	 </td>
	    <!-- 등급 다운 -->
		<td width="50px">
			<button  class="glyphicon glyphicon-arrow-down down" type="button"
					 id="<%=dto.getId()%>" member="<%=dto.getType()%>">
	     	 </button>
		</td>
		<!-- 회원 삭제 -->
		<td width="50px">
       		<button class="glyphicon glyphicon-trash del" type="button"
       				id="<%=dto.getId()%>" member="<%=dto.getType()%>">
    	 	</button>
		</td>
	</tbody>
<%} %>

</table>
