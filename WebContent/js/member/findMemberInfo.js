$(function(){
	$(".findpwd>.findlist>#findid").val("");
	$(".findpwd>.findlist>#email").val("");
	$(".findid>.findlist>#email").val("");
	$(".phone").val("");
	$(".findid").css({"display":"block"});
	

	//전화번호 관련 유효성
	$(document).on("keyup",".phone",function(e){
		var text = $(this).val();
		var idx = $(this).attr("idx");
		var regexp = /^[0-9]*$/;
		
		if(!regexp.test(text)){
			alert("숫자만 입력해주세요.");
			var leng = $(this).val().length;
			var sub = $(this).val().substring(0,leng-1);
			$(this).val(sub);
			return false;
		}
		if(e.keyCode!=8){
			if(idx=="0"){
				text = $(this).val();
				if(text.length>=3){
					$(".phone:eq(1)").focus();
				}
			}else if(idx=="1"){
				text = $(this).val();
				if(text.length>=4){
					$(".phone:eq(2)").focus();
				}
			}
		}
	});
	//새 비밀번호
	$(document).on("keyup","#newPassword, #newPasswordCheck",function(){
		var pass = $("#newPassword").val();
		var passCheck = $("#newPasswordCheck").val();
		
		//영문 대.소문자, 숫자 _,-만 입력 가능하고 5에서 20자리를 입력했는지 체크
		var RegExp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/;
		if(!RegExp.test(pass)||!RegExp.test(passCheck)){
			$("#hdCheck").val("no");
			$(".passCheck").css({
				"display":"block"
			});
			$(".passCheck").text("영문 대문자와 소문자, 숫자, 특수문자를 하나 이상 포함하여 8~16자입니다.");
			return false;
		}
		
		if(pass != passCheck){
			$("#hdCheck").val("no");
			$(".passCheck").css({
				"display":"block"
			});
			$(".passCheck").text("입력한 비밀번호와 비밀번호 확인이 맞지 않습니다.");
		}else{
			$("#hdCheck").val("yes");
			$(".passCheck").css({
				"display":"none"
			});
		}
		
	});
	$(document).on("click","#newPassBtn",function(){
		var check = $("#hdCheck").val();
		var id = $("#hdId").val();
		var pass = $("#newPassword").val();
		if(check=="no"){
			alert("비밀번호를 확인해주세요");
			return false;
		}else{
			$.ajax({
				type:"get",
				url:"../member/newpassword.jsp",
				dataType:"html",
				data:{
					"id":id,
					"pass":pass
				},
				success:function(data){
					alert("수정완료");
					$(".findpwd>.findlist>#findid").val("");
					$(".findpwd>.findlist>#email").val("");
					$(".findid>.findlist>#email").val("");
					$(".phone").val("");
					$("#pwd").val("");
					$(".findinfo").css({"background-color":"#44474a","color": "#fff"});
					$(".findmodal").css({"display":"none"});
					$(".newPassword").css({"display":"none"});
					$("#newPassword").val("");
					$("#newPasswordCheck").val("");
					$(".findbox").css({"display":"block"});
					$(".findpwd").css({"display":"none"});
					$(".findresult").css({"display":"none"});
				}
			});
		}
	});
	//아이디를 찾은 후 버튼클릭 이벤트
	$(document).on("click",".gologin",function(){
		$(".findpwd>.findlist>#findid").val("");
		$(".findpwd>.findlist>#email").val("");
		$(".findid>.findlist>#email").val("");
		$(".phone").val("");
		$("#pwd").val("");
		$(".findinfo").css({"background-color":"#44474a","color": "#fff"});
		$(".findmodal").css({"display":"none"});
		$(".newPassword").css({"display":"none"});
		$("#newPassword").val("");
		$("#newPasswordCheck").val("");
		$(".findbox").css({"display":"block"});
		$(".findpwd").css({"display":"none"});
		$(".findresult").css({"display":"none"});
	});
	
	//비밀번호찾기 누르면 나머지 display:none
	$("#findPwd").click(function(){
		$(".findid").css({"display":"none"});
		$(".findresult").css({"display":"none"});
		$(".findpwd").css({"display":"block"});
		$(".newPassword").css({"display":"none"});
		
		//값 초기화
		$(".findpwd>.findlist>#findid").val("");
		$(".findpwd>.findlist>#email").val("");
		$(".findid>.findlist>#email").val("");
		$(".phone").val("");
		$("#pwd").val("");
		//아이디 비번 찾기 click css유지
		$("#findPwd").css({"background-color":"#FFF",
							"color":"#000"})
		$("#findId").css({"background-color":"#44474a",
							"color":"#fff"})					
	});
//아이디찾기 누르면  나머지 display:none
	$("#findId").click(function(){
		$(".findpwd").css({"display":"none"});
		$(".findresult").css({"display":"none"});
		$(".findid").css({"display":"block"});
		$(".newPassword").css({"display":"none"});
		//값 초기화
		$(".findpwd>.findlist>#findid").val("");
		$(".findpwd>.findlist>#email").val("");
		$(".findid>.findlist>#email").val("");
		$(".phone").val("");
		$("#pwd").val("");
		//아이디 비번 찾기 click css유지
		$("#findId").css({"background-color":"#FFF",
			"color":"#000"})
		$("#findPwd").css({"background-color":"#44474a",
							"color":"#fff"})
	});

	
	//id 버튼 누르면 결과화면
	$(".resultidbtn").click(function(){
		var email=$(".findid>.findlist>#email").val();
		var phone = "";
		var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		$(".phone").each(function(){
			phone = phone + $(this).val() + "-";
		});
		phone = phone.substring(0,phone.length-1);
		if(email.length==0||email.indexOf(" ")>=0){
			alert("이메일을 확인해주세요.");
			return false;
		}else if(!regExp.test(email)){
			alert("이메일을 확인해주세요.");
			return false;
		}
		if(phone.length==0||phone.indexOf(" ")>=0){
			alert("전화번호를 확인해주세요.");
			return false;
		}
		
		$.ajax({
			type:"get",
			url:"../member/findIdAction.jsp",
			dataType:"html",
			data:{
				"email":email,
				"phone":phone
			},
			success:function(data){
				var id = $.trim(data);
				if(id!="null"){
					$(".findresult").css({"display":"block"});
					$(".findid").css({"display":"none"});
					$(".findresult").html("<p class='idmsg'>회원님의 아이디는 "+id+"입니다.</p>" +
							"<div class='col-md-12 col-sm-12 col-xs-12 gologinbox'>" +
								"<button type='button' class='gologin'>로그인 하기</button>" +
							"</div>");
				}else{
					$(".findresult").css({"display":"block"});
					$(".findid").css({"display":"none"});
					$(".findresultmsg").html("회원정보가 일치하지 않습니다.");
					$(".returnpwdbtn").css({"display":"none"});
					$(".returnidbtn").css({"display":"block"});
				}
			}
		});
	});
	
//	pwd 버튼 누르면 결과화면
	$(".resultpwdbtn").click(function(){
		var id=$("#findid").val();
		var email=$(".findpwd>.findlist>#email").val();
		var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

		if(id.length==0||id.indexOf(" ")>=0){
			alert("아이디를 확인해주세요.");
			return false;
		}
		
		if(email.length==0||email.indexOf(" ")>=0){
			alert("이메일을 확인해주세요.");
			return false;
		}else if(!regExp.test(email)){
			alert("이메일을 확인해주세요.");
			return false;
		}
		
		$.ajax({
			type:"get",
			url:"../member/findpasscheck.jsp",
			dataType:"html",
			data:{
				"id":id,
				"email":email
			},
			success:function(data){
				var findId = $.trim(data);
				if(id==findId){
					$(".findpwd").css({"display":"none"});
					$(".newPassword").css({
						"display":"inline-block"
					});
					$("#hdId").val(id);
				}else{
					$(".findresult").css({"display":"inline-block"});
					$(".findpwd").css({"display":"none"});
					$(".findresultmsg").html("회원정보가 일치하지 않습니다.");
					$(".returnidbtn").css({"display":"none"});
					$(".returnpwdbtn").css({"display":"block"});
					
				}
			}
		
		});
	});
	//모달 실행
	$("#mymodalbtn").click(function(){
		$("#myfindmodal").css({"display":"block"});
	});
	// 모든css 값 초기화후 모달창 닫힘
	$(".findmodal").click(function(e){
		var target = $(e.target);
		if(target.is(".findmodal")){
			$(this).css({"display":"none"});
			$(".findinfo").css({"background-color":"#44474a","color": "#fff"});
			$(".findpwd>.findlist>#findid").val("");
			$(".findpwd>.findlist>#email").val("");
			$(".findid>.findlist>#email").val("");
			$(".phone").val("");
			$("#pwd").val("");
			$(".findinfo").css({"background-color":"#44474a","color": "#fff"});
			$(".findmodal").css({"display":"none"});
			$(".newPassword").css({"display":"none"});
			$("#newPassword").val("");
			$("#newPasswordCheck").val("");
			$(".findbox").css({"display":"block"});
			$(".findpwd").css({"display":"none"});
			$(".findresult").css({"display":"none"});
		}
	});
	//취소 버튼 누르면 모든css 값 초기화후 모달창 닫힘
	$(".resulcancelbtn,.resulbtnpassm").click(function(){
		$(".findpwd>.findlist>#findid").val("");
		$(".findpwd>.findlist>#email").val("");
		$(".findid>.findlist>#email").val("");
		$(".phone").val("");
		$("#pwd").val("");
		$(".findinfo").css({"background-color":"#44474a","color": "#fff"});
		$(".findmodal").css({"display":"none"});
		$(".newPassword").css({"display":"none"});
		$("#newPassword").val("");
		$("#newPasswordCheck").val("");
		$(".findbox").css({"display":"block"});
	});
	
	//돌아가기 버튼 누르면   값 초기화후 #findPwd display block
	$(".returnpwdbtn").click(function(){
		//값 초기화
		$(".findpwd>.findlist>#findid").val("");
		$(".findpwd>.findlist>#email").val("");
		$(".findid>.findlist>#email").val("");
		$(".phone").val("");
		$("#pwd").val("");
		//뒤로 가기
		$(".findpwd").css({"display":"block"});
		$(".findresult").css({"display":"none"});
	});
	$(".returnidbtn").click(function(){
		//값 초기화
		$(".findpwd>.findlist>#findid").val("");
		$(".findpwd>.findlist>#email").val("");
		$(".findid>.findlist>#email").val("");
		$(".phone").val("");
		$("#pwd").val("");
		//뒤로 가기
		$(".findid").css({"display":"block"});
		$(".findresult").css({"display":"none"});
	});
});