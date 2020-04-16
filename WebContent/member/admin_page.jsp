<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	MemberDao dao=new MemberDao();
 	List<MemberDto> list= dao.getadmindata();
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
<div class="search_admin">
<input type="text" style="border-radius: 5px;" placeholder="검색하쉴"></div>
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
	for(int i=1;i<list.size();i++){
		MemberDto dto=list.get(i);
		String id=dto.getId();
		String name=dto.getName();
		String type=dto.getType();
%>
	
<tbody>
			<td width="200px"><%=id %></td>
			<td width="200px"><%=name %></td>
			<td width="150px"><%=type %></td>
			<td width="50px">
        		<button type="button" class="up" id="<%=id%>" memeber="<%=type%>">
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
