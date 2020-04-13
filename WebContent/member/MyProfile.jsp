<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정</title>
<!-- <link rel= "stylesheet" type="text/css" href="../css/top/topmenu.css"> -->
<link rel= "stylesheet" type="text/css" href="member/style.css">
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.0.10/css/all.css'>
<!-- <link rel= "stylesheet" type="text/css" href="../css/bootstrap.min.css">  -->
<!-- <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'> -->

<!--  <script src="https://code.jquery.com/jquery-1.10.2.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 -->
 
 <script src="member/script.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-image-editor/latest/tui-image-editor.css">
<script src="https://uicdn.toast.com/tui-image-editor/latest/tui-image-editor.js"></script>
<style>
.topmain{
	width:100%;
	background-color: #FAFAFA;
	max-height: 120px;
	border-bottom: 1px solid #DBDBDB;
}
.content{
	display:block;
	height:600px;
}
</style>
</head>
<script type="text/javascript">
	function getData(){
		<%
		String id = (String)session.getAttribute("id");
		MemberDao db = new MemberDao();
		MemberDto dto = db.getdata(id);
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
<%
	MemberDto dto1 = (MemberDto)session.getAttribute("dto");
	String profilesrc = "profile/default.png";
	if(dto1.getPic()!=null && dto1.getPic()!=""){
		profilesrc = "profile/"+id+"/"+dto.getPic();
	}
%>
<body>
	<div class="container">
		<nav class="custom-nav">
			<a id="profile"><i class="fa fa-user"> 계정설정</i></a> 
			<a id="payment"><i class="fa fa-credit-card"> 게시물</i></a> 
			<a id="subscription"><i class="fa fa-tv"> 팔로워</i></a> 
			<a id="privacy"><i class="fa fa-tasks"> 좋아요</i></a>
			<a id="settings"><i class="fa fa-cog"> 회원탈퇴</i></a>
		</nav>

		<div class="profile">
			<div class="row">
				<div class="col-md-3"
					style="text-align: center; line-height: 412px;">
					<div class="picarea">
						<%-- <img alt="#" class="pic" src="profile/<%=id %>/<%=dto.getPic()%>" style="width: 180px;height: 180px;"> --%>
						<img alt="#" class="pic" src="<%=profilesrc%>"
							style="width: 180px; height: 180px;"> <a
							class="glyphicon glyphicon-plus-sign picadd" data-toggle="modal"
							data-target="#myModal"
							style="color: black; text-decoration: none; cursor: pointer; top: 80px;"></a>
					</div>
				</div>
				<div class="col-md-8">
					<h1 class="font1">내 정보</h1>
					<input type="hidden" name="num" id="num" value="<%=dto.getNum()%>">
					<h2 class="font2">이름</h2>
					<p class="custom-p view">
						<%=dto.getName()%>
					</p>

					<h2 class="font2">아이디</h2>
					<p class="custom-p">
						<%=dto.getId()%>
					</p>

					<h2 class="font2">휴대전화</h2>
					<p class="custom-p">
						<%=dto.getHp1()%>-<%=dto.getHp2()%>-<%=dto.getHp3()%>
						<button class="custom-btn update">변경</button>
					</p>
					<p class="custom-p form hidden">
						<input type="text" class="custom-input" name="hp"
							value="<%=dto.getHp1()%>-<%=dto.getHp2()%>-<%=dto.getHp3()%>"
							required="required">
						<button class="custom-btn cancel">취소</button>
						<button class="custom-btn submit">변경</button>
					</p>

					<h2 class="font2">이메일</h2>
					<p class="custom-p">
						<%=dto.getEmail1()%>@<%=dto.getEmail2()%>
						<button class="custom-btn update">변경</button>
					</p>
					<p class="custom-p form hidden">
						<input type="text" class="custom-input" name="email"
							value="<%=dto.getEmail1()%>@<%=dto.getEmail2()%>"
							required="required">
						<button class="custom-btn cancel">취소</button>
						<button class="custom-btn submit">변경</button>
					</p>

					<h2 class="font2">주소</h2>
					<p class="custom-p">
						<%=dto.getAddr1()%>/<%=dto.getAddr2()%>
						<button class="custom-btn update">변경</button>
					</p>
					<p class="custom-p form hidden">
						<input type="text" class="custom-input" name="addr"
							value="<%=dto.getAddr1()%>/<%=dto.getAddr2()%>"
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
		<!-- 해당 회원이 작성한 글 -->
		<div class="payment noshow"></div>

		<div class="subscription noshow">
			<h1 class="font1">Your Subscription</h1>
			<h2 class="font2">Payment Date</h2>
			<p class="custom-p">
				05-15-2018
				<button class="custom-btn">pay now</button>
			</p>
			<h2 class="font2">Your Next Charge</h2>
			<p class="custom-p">
				$8.48<span class="custom-span"> includes tax</span>
			</p>
			<h2 class="font2">Hulu Base Plan</h2>
			<p class="custom-p">
				Limited Commercials
				<button class="custom-btn">change plan</button>
			</p>
			<h2 class="font2">Add-ons</h2>
			<p class="custom-p">
				None
				<button class="custom-btn">manage</button>
			</p>
			<h2 class="font2">Monthly Recurring Total</h2>
			<p class="custom-p">$7.99/month</p>
		</div>

		<div class="privacy noshow">
			<h1 class="font1">Privacy Settings</h1>
			<h2 class="font2">
				Manage Email Notifications
				<button class="custom-btn">manage</button>
			</h2>
			<p class="custom-p"></p>
			<h2 class="font2">
				Manage Privacy Settings
				<button class="custom-btn">manage</button>
			</h2>
			<p class="custom-p"></p>
			<h2 class="font2">
				View Terms of Use
				<button class="custom-btn">view</button>
			</h2>
			<p class="custom-p"></p>
			<h2 class="font2">
				Personalize Ad Experience
				<button class="custom-btn">update</button>
			</h2>
			<p class="custom-p"></p>
			<h2 class="font2">
				Protect Your Account
				<button class="custom-btn">protect</button>
			</h2>
			<p class="custom-p"></p>
		</div>
		<div class="settings noshow">
			<h1 class="font1" style="font-size: 10pt">회원탈퇴</h1>
			<h3>
				정말로 탈퇴 하시겠습니까?
				</h2>
				<div class="input-group">
					<label id="password" style="display: block;">비밀번호</label> <input
						type="password" id="deletePass" class="form-control"
						style="margin-bottom: 10px;">
					<button type="button" class="btn btn-primary"
						onclick="deleteMember()">탈퇴</button>
					<button type="button" class="btn btn-default">취소</button>
				</div>
		</div>
	</div>
	
	<div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
		<form action="updateProfilePic.jsp" enctype="multipart/form-data" method="post">
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