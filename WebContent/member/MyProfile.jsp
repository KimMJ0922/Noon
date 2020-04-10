<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정</title>
<link rel= "stylesheet" type="text/css" href="../css/top/topmenu.css">
<link rel= "stylesheet" type="text/css" href="style.css">
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.0.10/css/all.css'>
<link rel= "stylesheet" type="text/css" href="../css/bootstrap.min.css"> 
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="script.js"></script>
<style>
.topmain{
	width:100%;
	background-color: #FAFAFA;
	max-height: 120px;
	border-bottom: 1px solid #DBDBDB;
}
</style>
</head>
<script type="text/javascript">
	$(function(){
		logincheck();
		getData();
		
		$(".update").click(function(){
			$("p").addClass('')
		});
	});
	function logincheck(){
		<%
		String loginok = (String)session.getAttribute("loginok");
		if(loginok==null){%>
			<script type="text/javascript">
				alert("로그인이 필요한 서비스 입니다.");
				location.replace("../login/noonlogin.jsp");
			</script>
		<%}	%>
	}
	function getData(){
		<%
		String id = (String)session.getAttribute("id");
		MemberDao db = new MemberDao();
		MemberDto dto = db.getdata(id);
		%>
	}
</script>
<body>
	<div class="topmain" style="padding:0; margin:0;">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-sm-12 ">
				<jsp:include page="../top/topmenu.jsp"/>
			</div>
		</div>
	</div>
	<div class="container">
		<nav class="custom-nav">
			<a id="profile"><i class="fa fa-user"> 계정설정</i></a> 
			<a id="payment"><i class="fa fa-credit-card"> 게시물</i></a> 
			<a id="subscription"><i class="fa fa-tv"> 팔로워</i></a> 
			<a id="privacy"><i class="fa fa-tasks"> 좋아요</i></a>
			<a id="settings"><i class="fa fa-cog"> 회원탈퇴</i></a>
		</nav>
		<div class="content">
		
			<div class="profile">
				<h1 class="font1">내 정보</h1>
				<h2 class="font2">이름</h2>
				<p class="custom-p">
					<%=dto.getName() %>
					<!-- <button class="custom-btn" data-toggle="modal" data-target="#changeModal">변경</button> -->
					<button class="custom-btn update">변경</button>
				</p>
				<p class="custom-p noshow">
					<input type="text" name="name" value="<%=dto.getName() %>" required="required">
					<button class="custom-btn">변경</button>
				</p>
				<h2 class="font2">아이디</h2>
				<p class="custom-p"><%=dto.getId() %>
					<button class="custom-btn">변경</button>
				</p>
				<h2 class="font2">휴대전화</h2>
				<p class="custom-p"><%=dto.getHp1() %>-<%=dto.getHp2() %>-<%=dto.getHp3() %>
					<button class="custom-btn">변경</button>
				</p>
				<h2 class="font2">이메일</h2>
				<p class="custom-p">
					<%=dto.getEmail1() %>@<%=dto.getEmail2() %>
					<button class="custom-btn">변경</button>
				</p>
				<h2 class="font2">주소</h2>
				<p class="custom-p">
					<%=dto.getAddr1() %> <%=dto.getAddr2() %>
					<button class="custom-btn">변경</button>
				</p>
				<h2 class="font2">비밀번호</h2>
				<p class="custom-p">
					•••••••
					<button class="custom-btn">변경</button>
				</p>
			</div>
			
			<div class="payment noshow">
				<h1 class="font1">Payment Info</h1>
				<h2 class="font2">Payment Method</h2>
				<p class="custom-p">
					Mastercard •••• •••• •••• 0000
					<button class="custom-btn">update</button>
				</p>
				<h2 class="font2">Billing Address</h2>
				<p class="custom-p">
					1234 Example Ave | Seattle, WA
					<button class="custom-btn">change</button>
				</p>
				<h2 class="font2">Zipcode</h2>
				<p class="custom-p">999000</p>
				<h2 class="font2">Billing History</h2>
				<p class="custom-p">
					2018
					<button class="custom-btn">view</button>
				</p>
				<h2 class="font2">Redeem Gift Subscription</h2>
				<p class="custom-p">
					<input class="custom-input"  type="text" placeholder="Enter Gift Code"></input>
					<button class="custom-btn">Redeem</button>
				</p>
			</div>

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
				<h1 class="font1">Account Settings</h1>
				<h2 class="font2">
					Sync Watchlist to My Stuff
					<button class="custom-btn">sync</button>
				</h2>
				<p class="custom-p"></p>
				<h2 class="font2">
					Hold Your Subscription
					<button class="custom-btn">hold</button>
				</h2>
				<p class="custom-p"></p>
				<h2 class="font2">
					Cancel Your Subscription
					<button class="custom-btn">cancel</button>
				</h2>
				<p class="custom-p"></p>
				<h2 class="font2">
					Your Devices
					<button class="custom-btn">Manage Devices</button>
				</h2>
				<p class="custom-p"></p>
				<h2 class="font2">
					Referrals
					<button class="custom-btn">get $10</button>
				</h2>
				<p class="custom-p"></p>
			</div>
		</div>
	</div>
	
	<!-- Modal -->
	<div id="changeModal" class="modal fade" role="dialog" style="top: 38%;">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">이름 변경</h4>
	      </div>
	      <div class="modal-body">
	      	<div class="form-group">
	      		<label for="checkid">아이디:</label>
	      		<input type="text" class="form-control" id="checkid">
	      		<p id="idchkResult" style="margin-top: 5px;"></p>
	      	</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default com" data-dismiss="modal">완료</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>