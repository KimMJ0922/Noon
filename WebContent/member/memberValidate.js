function validate(){
	var cnt = $(".next").attr("cnt");
	var bool = true;
	var str = "";
	
	switch(cnt){
	case '0' : 
		if($("#name").val() == ""){
			$(".next").attr("bool",false);
			str = "이름을 양식에 맞게 입력 해주세요";
			$(".next").attr("str",str);
		}else{
			$(".next").attr("bool",true);
		}
		break;

	case '1' : 
		if($("#id").val() == ""){
			$(".next").attr("bool",false);
			str = "아이디를 입력 하거나 중복체크 해주세요";
			$(".next").attr("str",str);
			
		}else{
			$(".next").attr("bool",true);
		}
		break;

	case '2' : 
		if($("#pass").val() == ""){
			$(".next").attr("bool",false);
			str = "비밀번호를 양식에 맞게 입력 해주세요";
			$(".next").attr("str",str);
		}else{
			$(".next").attr("bool",true);
		}
		break;

	case '3' :
		if($("#hp2").val() == ""){
			$(".next").attr("bool",false);
			str = "휴대폰 번호를 양식에 맞게 입력 해주세요";
			$(".next").attr("str",str);
		}else{
			$(".next").attr("bool",true);
		}
		break;

	case '4' : 
		if($("#email1").val() == ""){
			$(".next").attr("bool",false);
			str = "이메일을 양식에 맞게 입력 해주세요";
			$(".next").attr("str",str);
		}else{
			$(".next").attr("bool",true);
		}
		break;

	case '5' : 
		if($("#addr1").val() == ""){
			$(".next").attr("bool",false);
			str = "주소를 양식에 맞게 입력 해주세요";
			$(".next").attr("str",str);
		}else{
			$(".next").attr("bool",true);
		}
		break;
	}
}