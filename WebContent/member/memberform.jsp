<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<%
	String url = request.getContextPath();
%>
<script src="progress-bar.js"></script>
<style>
	body{
		background-image: url("background.jpg");
	}
	.form{
		width: 50%;
		height: 500px;
		margin: 10% auto;
		padding: 10px;
		border: 1px solid gray;
		box-shadow: 3px 3px 3px 3px gray;
		border-radius: 30px; 
		background-color: white;
	}
	.top{
		height: 125px;
	}
	
	.next,.prev{
		margin-top: 20px;
	}
	
	ul.progress-bar {
		width: 100%;
		margin: 0;
		padding: 0;
		font-size: 0;
		list-style: none;
	}
	
	li.section {
		display: inline-block;
		padding-top: 45px;
		font-size: 13px;
		font-weight: bold;
		line-height: 16px;
		color: gray;
		vertical-align: top;
		position: relative;
		text-align: center;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	
	li.section:before {
		content: 'x';
		position: absolute;
		top: 2px;
		left: calc(50% - 15px);
		z-index: 1;
		width: 30px;
		height: 30px;
		color: white;
		border: 2px solid white;
		border-radius: 17px;
		line-height: 30px;
		background: gray;
	}
	
	.status-bar {
		height: 2px;
		background: gray;
		position: relative;
		top: 20px;
		margin: 0 auto;
	}
	
	.current-status {
		height: 2px;
		width: 0;
		border-radius: 1px;
		background: mediumseagreen;
	}
	
	li.section.visited:before {
		content: '\2714';
		animation: changeBackground .5s linear;
		animation-fill-mode: forwards;
	}
	
	li.section.visited.current:before {
		box-shadow: 0 0 0 2px mediumseagreen;
	}
	
	@keyframes changeBackground {
		from {background: gray
	}
	
	to {
		background: mediumseagreen
	}
	
	}
</style>
<body>
	<%-- <marquee direction="left" width="100%" behavior="scroll"
		scrollamount="10">
		<img alt="#" src="<%=url%>/image/a02.png">
	</marquee> --%>
	<div class="form">
		<div class="logo" align="center" style="margin-bottom: 20px;">
			<img alt="#" src="logo.jpg" style="width: 120px;height: 120px; border-radius: 30px;">
			<h3>NOON</h3>
		</div>
		<div class="custom-progress-bar-wrapper">
			<div class="status-bar" style="width: 78.5%;">
				<div class="current-status"
					style="width: 0%; transition: width 500ms linear 0s;"></div>
			</div>
			<ul class="custom-progress-bar">
				<li class="section" style="width: 16%;">이름 입력</li>
				<li class="section" style="width: 16%;">아이디 입력</li>
				<li class="section" style="width: 16%;">비밀번호 입력</li>
				<li class="section" style="width: 16%;">핸드폰 번호 입력</li>
				<li class="section" style="width: 16%;">이메일 입력</li>
				<li class="section" style="width: 16%;">주소입력</li>
				<!-- <li class="section visited current" style="width: 20%;">Hired Professional</li> -->
			</ul>
		</div>
		
		
		<!-- <div class="progress">
	  		<div class="progress-bar progress-bar-striped active" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
		</div> -->
		<form action="member/memberAdd.jsp" method="post" id="frm" name="frm">
			<div class="top">
				<div class="form-group">
					<label for="name">이름:</label> 
					<input type="text" class="form-control" id="name" name="name">
				</div>
				<div class="form-group" hidden>
					<label for="myid">아이디:</label>
					<div class="input-group">
					   <input type="text" class="form-control" id="myid" name="myid">
					   <span class="input-group-btn">
					        <input type="button" class="btn btn-default" id="btnid" value="중복체크">
					   </span>
					</div>
				</div>
				<div class="form-group" hidden>
					<label for="pass">비밀번호:</label> 
					<input type="password" class="form-control" id="pass" name="pass">
					<label for="confirmPass">비밀번호 확인:</label> 
					<input type="password" class="form-control" id="confirmPass">
				</div>
				<div class="form-group" hidden>
					<label for="hp1">핸드폰:</label>
					<div class="form-row">
						<div class="col-md-4">
							<select class="form-control" id="hp1" name="hp1">
								<option value="010">010</option>
								<option value="010">02</option>
								<option value="010">031</option>
							</select>
						</div>
						<div class="col-md-4">
							<input type="text" class="form-control" id="hp2" name="hp2" size="4">
						</div>
						<div class="col-md-4">
							<input type="text" class="form-control" id="hp3" name="hp3" size="4">
						</div>
					</div>
				</div>
				<div class="form-group" hidden>
					<label for="email1">이메일:</label>
					<div class="form-row">
						<div class="col-md-4"> 
							<input type="text" class="form-control" id="email1" name="email1">
						</div>
						<div class="col-md-4">
							<input type="text" class="form-control" id="email2" name="email2">
						</div>
						<div class="col-md-4">
							<select class="form-control" id="email3">
								<option value="">직접입력</option>
								<option value="naver.com">naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="nate.com">nate.com</option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group" hidden>
					<label for="addr1">주소:</label> 
					<div class="input-group">
					   <input type="text" class="form-control" id="addr1" name="addr1">
					   <span class="input-group-btn">
					        <input type="button" class="btn btn-default" id="btnaddr" value="주소검색">
					   </span>
					</div>
					<label for="addr2">상세주소:</label> 
					<input type="text" class="form-control" id="addr2" name="addr2">
				</div>
				<div class="form-group" hidden align="center">
					<b>완료하셨습니다 가입하시겠습니까?</b><br>
					<button type="submit" class="btn btn-default">Submit</button>
					<button type="reset" class="btn btn-default">Reset</button>
				</div>
			</div>
			<div class="bottom">
				<div style="float: left;">
					<button type="button" class="btn btn-default prev">이전</button>
				</div>
				<div style="float: right;">
					<button type="button" class="btn btn-default next">다음</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>