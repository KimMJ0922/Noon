function validate(){
	var cnt = $(".next").attr("cnt");
	var bool = true;
	var str = "";
	
	var nameCheck = RegExp(/^[가-힣]{2,8}$/);
	//2~8글자의 한글만 입력하였는지 검사
	var userIdCheck = RegExp(/^[A-Za-z0-9_\-]{5,20}$/);
	//영문 대.소문자, 숫자 _,-만 입력 가능하고 5에서 20자리를 입력했는지 체크
	var passwdCheck = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/);
	//패스워드 체크에서는 영문 대문자와 소문자, 숫자, 특수문자를 하나 이상 포함하여 8~16자가 되는지 검사
	var email2Check = RegExp(/^[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	//aa.aa
	var hp1Check = RegExp(/^01[0179]$/);
	//010,011,017,019 가능
	var hp2Check = RegExp(/^[0-9]{3,4}$/);
	//숫자로만 3~4자리
	var hp3Check = RegExp(/^[0-9]{4}$/);
	//숫자로만 4자리

	switch(cnt){
	case '0' : 
		if($("#name").val() == "" || !nameCheck.test($('#name').val())){
			$(".next").attr("bool",false);
			str = "이름을 양식에 맞게 입력 해주세요<br>2~8글자의 한글만 입력 가능합니다.";
			$("#name").addClass("has-error");
		}else{
			$(".next").attr("bool",true);
			$("#name").removeClass("has-error");
		}
		break;

	case '1' : 
		if($("#id").val() == "" || !userIdCheck.test($('#id').val())){
			$(".next").attr("bool",false);
			str = "아이디를 입력 하거나 중복체크 해주세요<br>영문 대.소문자, 숫자 _,-만 입력 가능하고 5에서 20자리를 입력가능";
			$("#id").addClass("has-error");
		}else{
			$(".next").attr("bool",true);
			$("#id").removeClass("has-error");
		}
		break;

	case '2' : 
		if($("#pass").val() == "" || !passwdCheck.test($('#pass').val()) || $("#pass").val() != $("#confirmPass").val()){
			$(".next").attr("bool",false);
			str = "비밀번호를 양식에 맞게 입력하거나 비밀번호 확인을 정확히 입력해 주세요<br>양식은 영문 대문자와 소문자, 숫자, 특수문자를 하나 이상 포함하여 8~16자입니다.";
			$("#pass").addClass("has-error");
		}else{
			$(".next").attr("bool",true);
			$("#pass").removeClass("has-error");
		}
		break;

	case '3' :
		if($("#hp2").val() == "" || !hp1Check.test($('#hp1').val()) || !hp2Check.test($('#hp2').val()) || !hp3Check.test($('#hp3').val())){
			$(".next").attr("bool",false);
			str = "휴대폰 번호를 양식에 맞게 입력 해주세요";
			$("#hp2").addClass("has-error");
			$("#hp3").addClass("has-error");
		}else{
			$(".next").attr("bool",true);
			$("#hp2").removeClass("has-error");
			$("#hp3").removeClass("has-error");
		}
		break;

	case '4' : 
		if($("#email1").val() == "" || $("#email2").val() == "" || !email2Check.test($('#email2').val())){
			$(".next").attr("bool",false);
			str = "이메일을 양식에 맞게 입력 해주세요";
			$("#email1").addClass("has-error");
			$("#email2").addClass("has-error");
		}else{
			$(".next").attr("bool",true);
			$("#email1").removeClass("has-error");
			$("#email2").removeClass("has-error");
		}
		break;

	case '5' : 
		if($("#addr1").val() == "" || $("#addr2").val() == ""){
			$(".next").attr("bool",false);
			str = "주소를 입력 해주세요";
			$("#addr1").addClass("has-error");
			$("#addr2").addClass("has-error");
		}else{
			$(".next").attr("bool",true);
			$("#addr1").removeClass("has-error");
			$("#addr2").removeClass("has-error");
		}
		break;
	}
	if(str!=""){
		$("#msg").html(str);
		$("#chkModal").modal('show');
	}
}