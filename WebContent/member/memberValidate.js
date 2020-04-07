function validate(){
	var cnt = $(".next").attr("cnt");
	var bool = true;
	var str = "";
	
	switch(cnt){
	case '0' : 
		if($("#name").val() == ""){
			$(".next").attr("bool",false);
			str = "이름을 양식에 맞게 입력 해주세요";
			$("#name").addClass("has-error");
		}else{
			$(".next").attr("bool",true);
			$("#name").removeClass("has-error");
		}
		break;

	case '1' : 
		if($("#id").val() == ""){
			$(".next").attr("bool",false);
			str = "아이디를 입력 하거나 중복체크 해주세요";
			$("#id").addClass("has-error");
		}else{
			$(".next").attr("bool",true);
			$("#id").removeClass("has-error");
		}
		break;

	case '2' : 
		if($("#pass").val() == ""){
			$(".next").attr("bool",false);
			str = "비밀번호를 양식에 맞게 입력 해주세요";
			$("#pass").addClass("has-error");
		}else{
			$(".next").attr("bool",true);
			$("#pass").removeClass("has-error");
		}
		break;

	case '3' :
		if($("#hp2").val() == ""){
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
		if($("#email1").val() == "" && $("#email2").val() == ""){
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
		if($("#addr1").val() == "" && $("#addr2").val() == ""){
			$(".next").attr("bool",false);
			str = "주소를 양식에 맞게 입력 해주세요";
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
		$("#msg").text(str);
		$("#chkModal").modal('show');
	}
}