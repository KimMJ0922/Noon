$(function(){
	
//비밀번호찾기 누르면 나머지 display:none
	$("#findPwd").click(function(){
		$(".findid").css({"display":"none"});
		$(".findresult").css({"display":"none"});
		$(".findpwd").css({"display":"block"});
		//값 초기화
		$(".findpwd>.findlist>#findid").val("");
		$(".findpwd>.findlist>#email").val("");
		$(".findid>.findlist>#email").val("");
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
		//값 초기화
		$(".findpwd>.findlist>#findid").val("");
		$(".findpwd>.findlist>#email").val("");
		$(".findid>.findlist>#email").val("");
		$("#pwd").val("");
		//아이디 비번 찾기 click css유지
		$("#findId").css({"background-color":"#FFF",
			"color":"#000"})
		$("#findPwd").css({"background-color":"#44474a",
							"color":"#fff"})
	});
//	id 버튼 누르면 결과화면
	$(".resultidbtn").click(function(){
		
		var email=$(".findid>.findlist>#email").val();
		var pass=$("#pwd").val();
		$.ajax({
			type:"get",
			url:"../WebContent/member/findIdAction.jsp",
			dataType:"html",
			data:{
				"email":email,
				"pass":pass
			},
			success:function(data){
				var id = $.trim(data);
				console.log(data);
				if(id!="null"){
					$(".findresult").css({"display":"block"});
					$(".findid").css({"display":"none"});
					$(".findresult").html("아이디는 :"+id);
				}else{
					$(".findresult").css({"display":"block"});
					$(".findid").css({"display":"none"});
					$(".findresult").html("회원정보가 일치하지 않습니다.");
				}
			}
		});
	});
	
//	pwd 버튼 누르면 결과화면
	
	$(".resultpwdbtn").click(function(){
		var id=$("#findid").val();
		var email=$(".findpwd>.findlist>#email").val();
		$.ajax({
			type:"get",
			url:"../WebContent/member/findIdAction.jsp",
			dataType:"html",
			data:{
				"id":id,
				"email":email
			},
			success:function(data){
				var pass = $.trim(data);
				console.log(pass)
				if(pass!=""){
					$(".findresult").css({"display":"inline-block"});
					$(".findpwd").css({"display":"none"});
					$(".findresult").html("비밀번호는 :"+pass);
				}else{
					$(".findresult").css({"display":"inline-block"});
					$(".findpwd").css({"display":"none"});
					$(".findresult").html("회원정보가 일치하지 않습니다.");
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
		}
	});
	//취소 버튼 누르면 모든css 값 초기화후 모달창 닫힘
	$(".resulcancelbtn").click(function(){
		$(".findinfo").css({"background-color":"#44474a","color": "#fff"});
		$(".findmodal").css({"display":"none"});
	});
});