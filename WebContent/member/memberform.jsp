<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Montserrat+Subrayada&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/member/memberform.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<%
	String url = request.getContextPath();
%>
<script src="../js/member/memberform.js"></script>
<script src="../js/member/memberValidate.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function addr(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	            } 
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById("addr1").value = "("+data.zonecode+") "+addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("addr2").focus();
	        }
	    }).open();
	}
</script>
<body>
	<canvas class="snow"></canvas>
	<div class="form">
		<div class="logo" align="center" style="margin-bottom: 20px;">
			<img alt="#" src="../img/member/logo.jpg" style="width: 120px;height: 120px; border-radius: 30px;">
			<h3 style="font-family: 'Montserrat Subrayada';">NOON</h3>
		</div>
		<div class="custom-progress-bar-wrapper">
			<div class="status-bar" style="width: 78.5%;">
				<div class="current-status"
					style="width: 0%; transition: width 200ms linear 0s;"></div>
			</div>
			<ul class="custom-progress-bar">
				<li class="section" style="width: 16%;">이름 입력</li>
				<li class="section" style="width: 16%;">아이디 입력</li>
				<li class="section" style="width: 16%;">비밀번호 입력</li>
				<li class="section" style="width: 16%;">핸드폰 번호 입력</li>
				<li class="section" style="width: 16%;">이메일 입력</li>
				<li class="section" style="width: 16%;">주소입력</li>
			</ul>
		</div>
		
		<form action="memberaction.jsp" method="post" id="frm" name="frm">
			<div class="top">
				<div class="form-group">
					<label for="name">이름:</label> 
					<input type="text" class="form-control" id="name" name="name" required="required">
				</div>
				<div class="form-group" hidden>
					<label for="id">아이디:</label>
					<div class="input-group">
					   <input type="text" class="form-control" id="id" name="id" required="required" readonly>
					   <span class="input-group-btn">
					        <input type="button" class="btn btn-default" id="idcheckbtn" value="중복체크" data-toggle="modal" data-target="#idchkModal">
					   </span>
					</div>
				</div>
				<div class="form-group" hidden>
					<label for="pass">비밀번호:</label> 
					<input type="password" class="form-control" id="pass" name="pass" required="required">
					<label for="confirmPass">비밀번호 확인:</label> 
					<input type="password" class="form-control" id="confirmPass" required="required">
				</div>
				<div class="form-group" hidden>
					<label for="hp1">핸드폰:</label>
					<div class="form-row">
						<div class="col-md-4">
							<select class="form-control" id="hp1" name="hp1" required="required">
								<option value="010">010</option>
								<option value="010">02</option>
								<option value="010">031</option>
							</select>
						</div>
						<div class="col-md-4">
							<input type="text" class="form-control" id="hp2" name="hp2" size="4" maxlength="4" required="required">
						</div>
						<div class="col-md-4">
							<input type="text" class="form-control" id="hp3" name="hp3" size="4" maxlength="4" required="required">
						</div>
					</div>
				</div>
				<div class="form-group" hidden>
					<label for="email1">이메일:</label>
					<div class="form-row">
						<div class="col-md-4"> 
							<input type="text" class="form-control" id="email1" name="email1" required="required">
						</div>
						<div class="col-md-4">
							<input type="text" class="form-control" id="email2" name="email2" required="required">
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
					   <input type="text" class="form-control" id="addr1" name="addr1" required="required">
					   <span class="input-group-btn">
					        <input type="button" class="btn btn-default" id="btnaddr" onclick="addr()" value="주소검색">
					   </span>
					</div>
					<label for="addr2">상세주소:</label> 
					<input type="text" class="form-control" id="addr2" name="addr2" required="required">
				</div>
				<div class="form-group" hidden align="center">
					<b>완료하셨습니다 가입하시겠습니까?</b><br>
					<button type="submit" class="btn btn-default">회원가입</button>
					<button type="reset" class="btn btn-default">다시작성</button>
				</div>
			</div>
			<div class="bottom">
				<div style="float: left;">
					<button type="button" class="btn btn-default prev btn-lg">이전</button>
				</div>
				<div style="float: right;">
					<button type="button" class="btn btn-primary next btn-lg" onclick="validate()" cnt="0" bool="">다음</button>
				</div>
			</div>
		</form>
	</div>
	
	<!-- Modal -->
	<div id="idchkModal" class="modal fade" role="dialog" style="top: 38%;">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">아이디 중복체크</h4>
	      </div>
	      <div class="modal-body">
	      	<div class="form-group">
	      		<label for="checkid">아이디:</label>
	      		<input type="text" class="form-control" id="checkid">
	      		<p id="idchkResult" style="margin-top: 5px;"></p>
	      	</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default com" chk="no" data-dismiss="modal">완료</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div id="chkModal" class="modal fade" role="dialog" style="top: 38%;">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">에러</h4>
	      </div>
	      <div class="modal-body">
	      	<div class="form-group">
	      		<p id="msg"></p>
	      	</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">완료</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>