<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<%
	MemberDto dto1 = (MemberDto)session.getAttribute("dto");
	String profilesrc = "profile/default.png";
	String id = dto1.getId();
	if(dto1.getPic()!=null && dto1.getPic()!=""){
		profilesrc = "profile/"+id+"/"+dto1.getPic();
	}
%>
<script type="text/javascript">
	$(function(){
		 getData();
		 logincheck();
		 
	});
	function getData(){
		<%
		MemberDao db = new MemberDao();
		MemberDto dto = db.getdata(dto1.getId());
		String Path = getServletContext().getRealPath("/profile/"+id);
		%>
	}
	
	function logincheck(){
		<%
		String loginok = (String)session.getAttribute("loginok");
		if(loginok==null){%>
			alert("로그인이 필요한 서비스 입니다.");
			location.replace("../login/noonlogin.jsp");
		<%}	%>
	}
</script>
<body>
	<div class="profile">
		<div class="row">
			<div class="col-md-3" style="text-align: center; line-height: 412px;">
				<div class="picarea">
					<img alt="#" class="pic" src="<%=profilesrc %>"	style="width: 180px; height: 180px;"> 
						<a class="glyphicon glyphicon-plus-sign picadd" data-toggle="modal" data-target="#myModal"
						style="color: black; text-decoration: none; cursor: pointer; top: 80px;"></a>
				</div>
			</div>
			<div class="col-md-8">
				<h1 class="font1">내 정보</h1>
				<input type="hidden" name="num" id="num" value="<%=dto.getNum() %>">
				<h2 class="font2">이름</h2>
				<p class="custom-p view">
					<%=dto.getName() %>
				</p>

				<h2 class="font2">아이디</h2>
				<p class="custom-p">
					<%=dto.getId() %>
				</p>

				<h2 class="font2">휴대전화</h2>
				<p class="custom-p">
					<%=dto.getHp1() %>-<%=dto.getHp2() %>-<%=dto.getHp3() %>
					<button class="custom-btn update">변경</button>
				</p>
				<p class="custom-p form hidden">
					<input type="text" class="custom-input" name="hp"
						value="<%=dto.getHp1() %>-<%=dto.getHp2() %>-<%=dto.getHp3() %>"
						required="required">
					<button class="custom-btn cancel">취소</button>
					<button class="custom-btn submit">변경</button>
				</p>

				<h2 class="font2">이메일</h2>
				<p class="custom-p">
					<%=dto.getEmail1() %>@<%=dto.getEmail2() %>
					<button class="custom-btn update">변경</button>
				</p>
				<p class="custom-p form hidden">
					<input type="text" class="custom-input" name="email"
						value="<%=dto.getEmail1() %>@<%=dto.getEmail2() %>"
						required="required">
					<button class="custom-btn cancel">취소</button>
					<button class="custom-btn submit">변경</button>
				</p>

				<h2 class="font2">주소</h2>
				<p class="custom-p">
					<%=dto.getAddr1() %>/<%=dto.getAddr2() %>
					<button class="custom-btn update">변경</button>
				</p>
				<p class="custom-p form hidden">
					<input type="text" class="custom-input" name="addr"
						value="<%=dto.getAddr1() %>/<%=dto.getAddr2() %>"
						required="required">
					<button class="custom-btn cancel">취소</button>
					<button class="custom-btn submit">변경</button>
				</p>

				<h2 class="font2">비밀번호</h2>
				<p class="custom-p">
					•••••••
					<button class="custom-btn update">변경</button>
				</p>
				<p class="custom-p form hidden">
					<input type="password" class="custom-input" name="pass" value=""
						required="required">
					<button class="custom-btn cancel">취소</button>
					<button class="custom-btn submit">변경</button>
				</p>
			</div>
		</div>
	</div>
	
	<div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
		<form action="member/updateProfilePic.jsp" enctype="multipart/form-data" method="post">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">프로필 사진 변경</h4>
		      </div>
		      <div class="modal-body">
		        <div class="profilePic" style="text-align: center;">
					<img id="preview" src="http://placehold.it/180" style="width: 180px;height: 180px; margin-bottom: 10px;" />
					<div class="filebox">
						<input type="file" class="form-control" name="photo" id="photo" accept="image/gif, image/jpeg, image/png, image/jpg" onchange="readURL(this);">
					</div>
				</div>
		      </div>
		      <div class="modal-footer">
		        <input type="submit" class="btn btn-pimary" value="변경">
		        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		      </div>
		    </div>
		</form>
	  </div>
	</div>
</body>
</html>