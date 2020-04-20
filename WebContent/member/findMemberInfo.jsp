<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../js/member/findMemberInfo.js"></script>
</head>
<body>
	<div class="infoBox">
		<div class="col-md-6 col-sm-6 col-xs-6 findinfo" id="findId">아이디 찾기</div>
		<div class="col-md-6 col-sm-6 col-xs-6 findinfo" id="findPwd">비밀번호 찾기</div>
		
		<!--아이디를 클릭시 -->
		<div class="col-md-12 col-sm-12 col-xs-12  findbox findid">
			<div class="col-md-12 col-sm-12 col-xs-12 findlist">
				<div class="inputline">이메일 :</div> 
				<input type="text" name="email" id="email" style="width: 78%;">
			</div>
			<div class="col-md-12 col-sm-12 col-xs-12 findlist">
				<div class="inputline">전화번호 :</div>
				<input  type="text" class="phone" idx="0" style="width: 24%;" maxlength="3"> -
				<input  type="text" class="phone" idx="1" style="width: 24%;" maxlength="4"> -
				<input  type="text" class="phone" idx="2" style="width: 24%;" maxlength="4">
			</div>
			<div class="col-md-6 col-sm-6 col-xs-6 findinfobtn">
				<button type="button" class="resultidbtn resulbtn">확인</button>
			</div>
			<div class="col-md-6 col-sm-6 col-xs-6 findinfobtn">
				<button type="button" class="resulcancelbtn resulbtn">취소</button>
			</div>
		</div>
		
		<!--비밀번호 클릭시 -->
		<div class="col-md-12 col-sm-12 col-xs-12 findbox findpwd">
			<div class="col-md-12 col-sm-12 col-xs-12 findlist">
				<div class="inputline">아이디 :</div> 
				<input type="text" name="findid" id="findid" style="width: 78%;">
			</div>
			<div class="col-md-12 col-sm-12 col-xs-12 findlist" >
				<div class="inputline">이메일 :</div> 
				<input type="text"name="email" id="email" style="width: 78%;">
			</div>
			<div class="col-md-6 col-sm-6 col-xs-6 findinfobtn ">
				<button type="button" class="resultpwdbtn resulbtn">확인</button>
			</div>
			<div class="col-md-6 col-sm-6 col-xs-6 findinfobtn">
				<button type="button" class="resulcancelbtn resulbtn">취소</button>
			</div>
		</div>
		<!--아이디/비밀번호 찾기 결과화면 -->
		<div class="col-md-12 col-sm-12 col-xs-12 findresult">
			<div class="findresultmsg">
			
			</div>
			<div class="col-md-12 col-sm-12 col-xs-12 findinfobtn">
					<button type="button" class="returnpwdbtn">돌아가기</button>
					<button type="button" class="returnidbtn">돌아가기</button>
			</div>
		</div>
		<div class="newPassword">
		<div class="col-md-12 col-sm-12 col-xs-12 findlist">
				<div class="inputlinepass">새 비밀번호 :</div> 
				<input type="password" id="newPassword" style="width: 70%;">
			</div>
			<div class="col-md-12 col-sm-12 col-xs-12 findlist" >
				<div class="inputlinepass">새 비밀번호 확인 :</div> 
				<input type="password"name="email" id="newPasswordCheck" style="width: 70%;">
			</div>
			<div class="col-md-12 col-sm-12 col-xs-12 findinfobtn ">
				<button type="button" class="resultpwdbtn resulbtnpass"id="newPassBtn">확인</button>
			</div>
			<p class="passCheck" style="display:none"></p>
			<input type="hidden" id="hdCheck" value="no">
			<input type="hidden" id="hdId">
		</div>
	</div>
</body>
</html>