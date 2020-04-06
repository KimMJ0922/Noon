$(function(){
	var cnt = 0;
	
	//첫번째 폼에서 이전버튼 숨김
	$(".prev").hide();
	
	//포커스 자동 넘김
	$("#email3").change(function(){
		$("#email2").val($(this).val());
	});
	
	$("#hp2").keyup(function(){
		if($(this).val().length==4)
			$("#hp3").focus();
	});
	
	//처음 브라우저 크기
	var windowWidth = window.innerWidth;
	var width = 1920 - windowWidth;
	var csswidth =$(".status-bar").css("width");
	$(".status-bar").css("width",csswidth-width);
	if(windowWidth<660){
		$("li.section").css("left",-15);
		$(".section").css("width","15.2%");
	}else if(windowWidth<750){
		$(".section").css("width","15.2%");
		$("li.section").css("left",-10);
	}else{
		$("li.section").css("left",-10);
		$(".section").css("width","16%");
	}
	//브라우저 사이즈가 바뀌면 실행될 것
	$(window).resize(function(){
		var windowWidth = window.innerWidth;
		var width = 1920 - windowWidth;
		var csswidth =$(".status-bar").css("width");
		$(".status-bar").css("width",csswidth-width);
		if(windowWidth<660){
			$("li.section").css("left",-15);
		}else if(windowWidth<750){
			$(".section").css("width","15.2%");
			$("li.section").css("left",-10);
		}else{
			$("li.section").css("left",-10);
			$(".section").css("width","16%");
		}
	}); 
	
	$(".next").click(function(){
		//이전 폼 숨기기 다음 폼 출력
		$(".top .form-group").eq(cnt).hide();
		cnt++;
		$(".top .form-group").eq(cnt).fadeIn("fast");
		
		/*$(".progress-bar").attr("aria-valuenow",cnt*20);
		$(".progress-bar").css("width",""+cnt*2+"0%");*/
		
		//프로그레스 바 이벤트
		var timeout = setTimeout(function(){
			$(".section").eq(cnt-1).addClass("visited current");
			$(".section").eq(cnt-2).removeClass("current");
		},300);
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
			$(".next").hide();
		}else if(cnt==0){
			$(".prev").hide();
		}else{
			$(".bottom").show();
			$(".prev").show();
		}
	});
	$(".prev").click(function(){
		$(".top .form-group").eq(cnt).hide();
		cnt--;
		$(".top .form-group").eq(cnt).fadeIn("fast");
		/*$(".progress-bar").attr("aria-valuenow",cnt*20);
		$(".progress-bar").css("width",""+cnt*2+"0%");*/
		
		//프로그레스 바 이벤트
		if(cnt==1){
			$(".section").eq(cnt-1).addClass("visited current");
			$(".section").eq(cnt).removeClass("visited current");
			$(".current-status").css("width",(cnt-1)*20+"%");
		}
		else if(cnt==0){
			$(".section").eq(cnt).removeClass("visited current");
			$(".current-status").css("width",(cnt-1)*20+"%");
		}
		else{
			$(".section").eq(cnt-1).addClass("visited current");
			$(".section").eq(cnt).removeClass("visited current");
			$(".current-status").css("width",(cnt-1)*20+"%");
		}
		
		if(cnt==6){
			$(".next").hide();
		}else if(cnt==0){
			$(".prev").hide();
		}else{
			$(".bottom").show();
			$(".prev").show();
			$(".next").show();
		}
	});
	
	$('button[type="reset"]').click(function(){
		location.reload();
	});
	
});