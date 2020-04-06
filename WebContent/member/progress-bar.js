$(function(){
	var cnt = 0;
	var headline = [
		"이름을 입력해주세요",
		"아이디를 입력해주세요",
		"비밀번호를 입력해주세요",
		"핸드폰번호를 입력해주세요",
		"이메일을 입력해주세요",
		"주소를 입력해주세요",
		"완료하셨습니다"
	];
	
	$(".prev").hide();
	$("#email3").change(function(){
		$("#email2").val($(this).val());
	});
	
	$("#hp2").keyup(function(){
		if($(this).val().length==4)
			$("#hp3").focus();
	});
	$(".next").click(function(){
		//이전 폼 숨기기 다음 폼 출력
		console.log("다음 버튼 : "+cnt);
		$(".top .form-group").eq(cnt).attr("hidden","true");
		cnt++;
		$(".top .form-group").eq(cnt).removeAttr("hidden");
		console.log(cnt);
		
		$("#headline").text(headline[cnt]);
		/*$(".progress-bar").attr("aria-valuenow",cnt*20);
		$(".progress-bar").css("width",""+cnt*2+"0%");*/
		
		//프로그레스 바 이벤트
		var timeout = setTimeout(function(){
			$(".section").eq(cnt-1).addClass("visited current");
			$(".section").eq(cnt-2).removeClass("current");
		},600);
		if(cnt==1)
			$(".section").eq(cnt-1).addClass("visited current");
		else{
			$(".current-status").css("width",(cnt-1)*20+"%");
			timeout;
		}
		
		//완료 시 다음 및 이전 버튼 숨김 첫 폼에서 이전버튼 숨김 
		if(cnt==6){
			$(".section").eq(cnt).addClass("visited");
			$(".section").eq(cnt-2).removeClass("current");
			$(".bottom").hide();
		}else if(cnt==0){
			$(".prev").hide();
		}else{
			$(".bottom").show();
			$(".prev").show();
		}
	});
	$(".prev").click(function(){
		console.log("이전 버튼 : "+cnt);
		$(".top .form-group").eq(cnt).attr("hidden","true");
		cnt--;
		$(".top .form-group").eq(cnt).removeAttr("hidden");
		console.log(cnt);
		$("#headline").text(headline[cnt]);
		/*$(".progress-bar").attr("aria-valuenow",cnt*20);
		$(".progress-bar").css("width",""+cnt*2+"0%");*/
		
		//프로그레스 바 이벤트
		if(cnt==1){
			$(".section").eq(cnt-1).addClass("visited current");
			$(".section").eq(cnt).removeClass("visited current");
			$(".current-status").css("width",(cnt-1)*20+"%");
		}
		else{
			$(".section").eq(cnt-1).addClass("visited current");
			$(".section").eq(cnt).removeClass("visited current");
			$(".current-status").css("width",(cnt-1)*20+"%");
		}
		
		if(cnt==6){
			$(".bottom").hide();
		}else if(cnt==0){
			$(".prev").hide();
		}else{
			$(".bottom").show();
			$(".prev").show();
		}
	});
	
	$('button[type="reset"]').click(function(){
		location.reload();
	});
	
	$("#btnid").click(function(){
		window.open("member/idsearch.jsp","","width=371px,height=151px,left=800px,top=100px");			
	});
	
	$("#btnaddr").click(function(){
		window.open("member/postsearch.jsp","","width=500px,height=600px,left=800px,top=100px");			
	});
	
	$("#frm").keyup(function(e){
		if(e.keyCode==13){
			e.preventDefault();
			$(".next").click();
		}
	});
		
});