<%@page import="member.MemberFollowDao"%>
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
	String id = request.getParameter("id");
	MemberFollowDao fdb = new MemberFollowDao();
	boolean followed = fdb.followed(dto1.getId(), id);
%>
<script type="text/javascript">
	$(function(){
		getData();
		logincheck();
		$(".slidein").each(function(i,item){
	    	/*$(this).css("visibility", "visible").animate({
	    		"margin-left" : "0px"
	    	},2000);*/
	    	$(this).css({"margin-left":"500px","opacity": "0.0"}).delay(i*300).animate({"margin-left": "0px", opacity:1.0},500);
	    	
	    });
	});
	function getData(){
		<%
		MemberDao db = new MemberDao();
		MemberDto dto = db.getdata(id);
		if(dto.getPic()!=null && dto.getPic()!=""){
			profilesrc = "profile/"+id+"/"+dto.getPic();
		}
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
<%
	if(dto.getId()==null){
%>
		<div style="text-align:center; line-height:500px; font-size:30pt">
			<%=id %>은(는) 없는 아이디 입니다.
		</div>
<%
	}else if(id.equals(dto1.getId())){
%>
	<div class="profile">
		<div class="row">
			<div class="col-md-3" style="text-align: center; line-height: 569px;">
				<div class="picarea">
					<img alt="#" class="pic" src="<%=profilesrc %>"	style="width: 180px; height: 180px;"> 
						<a class="glyphicon glyphicon-plus-sign picadd" data-toggle="modal" data-target="#myModal"
						style="color: black; text-decoration: none; cursor: pointer; top: 80px;"></a>
				</div>
			</div>
			<input type="hidden" name="num" id="num" value="<%=dto.getNum() %>">
			<div class="col-md-8">
				<div class="slidein">
					<h1 class="font1">내 정보</h1>
				</div>
				
				<div class="slidein">
					<h2 class="font2">이름</h2>
					<p class="custom-p view">
						<%=dto.getName() %>
					</p>
				</div>
				
				<div class="slidein">
					<h2 class="font2">아이디</h2>
					<p class="custom-p">
						<%=dto.getId() %>
					</p>
				</div>
				
				<div class="slidein">
					<h2 class="font2">휴대전화</h2>
					<p class="custom-p">
						<%=dto.getHp1() %>-<%=dto.getHp2() %>-<%=dto.getHp3() %>
						<button class="custom-btn update">변경</button>
					</p>
				</div>
				<p class="custom-p form hidden">
					<input type="text" class="custom-input" name="hp"
						value="<%=dto.getHp1() %>-<%=dto.getHp2() %>-<%=dto.getHp3() %>"
						required="required">
					<button class="custom-btn cancel">취소</button>
					<button class="custom-btn submit">변경</button>
				</p>
				
				<div class="slidein">
					<h2 class="font2">이메일</h2>
					<p class="custom-p">
						<%=dto.getEmail1() %>@<%=dto.getEmail2() %>
						<button class="custom-btn update">변경</button>
					</p>
				</div>
				<p class="custom-p form hidden">
					<input type="text" class="custom-input" name="email"
						value="<%=dto.getEmail1() %>@<%=dto.getEmail2() %>"
						required="required">
					<button class="custom-btn cancel">취소</button>
					<button class="custom-btn submit">변경</button>
				</p>
				
				<div class="slidein">
					<h2 class="font2">주소</h2>
					<p class="custom-p">
						<%=dto.getAddr1() %>/<%=dto.getAddr2() %>
						<button class="custom-btn update">변경</button>
					</p>
				</div>
				<p class="custom-p form hidden">
					<input type="text" class="custom-input" name="addr"
						value="<%=dto.getAddr1() %>/<%=dto.getAddr2() %>"
						required="required">
					<button class="custom-btn cancel">취소</button>
					<button class="custom-btn submit">변경</button>
				</p>
				
				<div class="slidein">
					<h2 class="font2">비밀번호</h2>
					<p class="custom-p">
						•••••••
						<button class="custom-btn update">변경</button>
					</p>
				</div>
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
		<div class="modal-dialog"style="width: 90%; height: 90%;">
	
		<!-- Modal content-->
		<form action="member/updateProfilePic.jsp" enctype="multipart/form-data" method="post" style="height: 100%;">
			<div class="modal-content" style="height: 100%;">
				<div class="modal-header" style="padding: 10px 10px 5px 20px;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">프로필 사진 변경</h4>
				</div>
				<div class="modal-body" style="height: 96%;padding:0px;">
					<div id="tui-image-editor-container" style="height: 95%;margin: 0px;"></div>
					<input type="hidden" name="base64" id="base64">
				</div>
			</div>
		</form>
		</div>
	</div>
<%
	}else{
%>
	<div class="profile">
		<div class="row">
			<div class="col-md-3" style="text-align: center; line-height: 569px;">
				<div class="picarea" style="line-height: 450px;">
					<img alt="#" class="pic" src="<%=profilesrc %>"	style="width: 180px; height: 180px;"> 
				</div>
			</div>
			<div class="col-md-8">
				<h1 class="font1"><%=id %>님 정보</h1>
				<input type="hidden" name="num" id="num" value="<%=dto.getNum() %>">
				<h2 class="font2">이름</h2>
				<p class="custom-p view">
					<%=dto.getName() %>
				</p>

				<h2 class="font2">아이디</h2>
				<p class="custom-p">
					<%=dto.getId() %>
				</p>

				<h2 class="font2">이메일</h2>
				<p class="custom-p">
					<%=dto.getEmail1() %>@<%=dto.getEmail2() %>
				</p>
				<%if(followed==true){ %>
					<a fromid='<%=dto1.getId() %>' toid='<%=id %>' class='pro-btn following' id="fbtn">언팔로우</a>
				<%}else{ %>
					<a fromid='<%=dto1.getId() %>' toid='<%=id %>' class='pro-btn follow' id="fbtn">팔로우</a>
				<%} %>
			</div>
		</div>
	</div>
<%} %>
</body>
</html>