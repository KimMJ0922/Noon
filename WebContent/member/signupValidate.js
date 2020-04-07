function validate(){
	var cnt = $(".next").attr("cnt");
	var bool = true;
	var str = "";

	switch(cnt){
	case '0' : 
		if($("#name").val() == ""){
			$(".next").attr("bool",false);
			str = "이름을 입력해주세요";
			$(".next").attr("str",false);
		}
		break;

	case '1' : 
		break;

	case '2' : 
		break;

	case '3' : 
		break;

	case '4' : 
		break;

	case '5' : 
		break;
	}

}