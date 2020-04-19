<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
				<div class="inputline">비밀번호 :</div>
				<input  type="password" name="pwd" id="pwd" style="width: 78%;">
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
				<input type="text" name="id" id="id" style="width: 78%;">
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
		<div class="col-md-12 col-sm-12 col-xs-12 findbox findresult">
		</div>
	</div>
</body>
</html>