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
	List<MemberDto> list = new Vector<MemberDto>();
	String id = request.getParameter("id");
	System.out.println(id);
	if(id==null||id.equals("")){
		id="";
		list = dao.getadmindata();
	}else{
		list = dao.getadmindata(id);
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
</style>

<table class="table table-hover">
		<caption>회원 정보</caption>
		<thead>
			<th>아이디</th>
			<th>이름</th>
			<th>회원등급</td>
			<th>업</th>
			<th>다운</th>
			<th>삭제</th>
		</thead>
		
<%
	for(MemberDto dto : list){
%>
	
<tbody>
			<td width="200px"><%=dto.getId() %></td>
			<td width="200px"><%=dto.getName() %></td>
			<td width="150px"><%=dto.getType() %></td>
			<td width="50px">
        		<button type="button" class="up" id="<%=dto.getId()%>" memeber="<%=dto.getType()%>">
          		<span class="glyphicon glyphicon-arrow-up up" id=""></span>
       	 		</button>
       	 	</td>
       	 	
			<td width="50px">
				<button id="down">
          		<span class="glyphicon glyphicon-arrow-down"></span>
       	 		</button>
			</td>
			<td width="50px">
				<button id="del">
          		<span class="glyphicon glyphicon-trash"></span>
       	 		</button>
			</td>
</tbody>
<%} %>

</table>
