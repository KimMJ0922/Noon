$(function(){
	
	//눈배경 이펙트
	var canvas = document.querySelector('.snow'),
    	ctx = canvas.getContext('2d'),
    	windowW = window.innerWidth,
    	windowH = window.innerHeight,
    	numFlakes = 200,
    	flakes = [];

	function Flake(x, y) {
	  var maxWeight = 5,
	      maxSpeed = 3;
	  
	  this.x = x;
	  this.y = y;
	  this.r = randomBetween(0, 1);
	  this.a = randomBetween(0, Math.PI);
	  this.aStep = 0.01;
	
	  
	  this.weight = randomBetween(2, maxWeight);
	  this.alpha = (this.weight / maxWeight);
	  this.speed = (this.weight / maxWeight) * maxSpeed;
	  
	  this.update = function() {
	    this.x += Math.cos(this.a) * this.r;
	    this.a += this.aStep;
	    
	    this.y += this.speed;
	  }
	  
	}
	
	function init() {
	  var i = numFlakes,
	      flake,
	      x,
	      y;
	  
	  while (i--) {
	    x = randomBetween(0, windowW, true);
	    y = randomBetween(0, windowH, true);
	    
	    
	    flake = new Flake(x, y);
	    flakes.push(flake);
	  }
	  
	  scaleCanvas();
	  loop();  
	}
	
	function scaleCanvas() {
	  canvas.width = windowW;
	  canvas.height = windowH;
	}
	
	function loop() {
	  var i = flakes.length,
	      z,
	      dist,
	      flakeA,
	      flakeB;
	  
	  // clear canvas
	  ctx.save();
	  ctx.setTransform(1, 0, 0, 1, 0, 0);
	  ctx.clearRect(0, 0, windowW, windowH);
	  ctx.restore();
	  
	  // loop of hell
	  while (i--) {
	    
	    flakeA = flakes[i];
	    flakeA.update();
	    
	
	    /*for (z = 0; z < flakes.length; z++) {
	      flakeB = flakes[z];
	      if (flakeA !== flakeB && distanceBetween(flakeA, flakeB) < 150) {          
	        ctx.beginPath();
	        ctx.moveTo(flakeA.x, flakeA.y);
	        ctx.lineTo(flakeB.x, flakeB.y);
	        ctx.strokeStyle = '#444444';
	        ctx.stroke();
	        ctx.closePath();
	      }
	    }*/
	
	    
	    ctx.beginPath();
	    ctx.arc(flakeA.x, flakeA.y, flakeA.weight, 0, 2 * Math.PI, false);
	    ctx.fillStyle = 'rgba(255, 255, 255, ' + flakeA.alpha + ')';
	    ctx.fill();
	    
	    if (flakeA.y >= windowH) {
	      flakeA.y = -flakeA.weight;
	    }  
	  }
	  
	  requestAnimationFrame(loop);
	}
	
	function randomBetween(min, max, round) {
	  var num = Math.random() * (max - min + 1) + min;
	
	  if (round) {
	    return Math.floor(num);
	  } else {
	    return num;
	  }
	}
	
	function distanceBetween(vector1, vector2) {
	  var dx = vector2.x - vector1.x,
	      dy = vector2.y - vector1.y;
	
	  return Math.sqrt(dx*dx + dy*dy);
	}
	
	init();
	
	var cnt = 0;
	
	//첫번째 폼에서 이전버튼 숨김
	$(".prev").hide();
	
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
	
	$(".next").click(function(e){
		if($(this).attr("bool")=="false"){
			return;
		}
		
		//이전 폼 숨기기 다음 폼 출력
		$(".top .form-group").eq(cnt).hide();
		cnt++;
		$(".top .form-group").eq(cnt).fadeIn("fast");
		$(this).attr("cnt",cnt);
		
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
		$(".top .form-group input").eq(cnt-1).removeClass("has-error");
		$(".top .form-group").eq(cnt).hide();
		cnt--;
		$(".top .form-group").eq(cnt).fadeIn("fast");
		$(".next").attr("cnt",cnt);
		
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
	
	$("#checkid").keyup(function(e){
		idchk();
		
	});
	$(".com").click(function(){
		var chk = $(this).attr("chk");
		if(chk=="no"){
			return false;
		}else{
			$("#id").val($("#checkid").val());
		}
	});
	
	//포커스 자동 넘김
	$("#email3").change(function(){
		$("#email2").val($(this).val());
	});
	
	$("#hp2").keyup(function(){
		if($(this).val().length==4)
			$("#hp3").focus();
	});
	
	$("#confirmPass").keyup(function(){
		if($("#pass").val()!=$(this).val()){
			$(this).addClass("has-error");
			$("label").eq(3).text("현재 비밀번호와 일치시켜주세요");
			$(".next").attr("bool",false);
		}
		else{
			$(this).removeClass("has-error");
			$("label").eq(3).text("현재 비밀번호와 일치합니다.");
			$(".next").attr("chk",true);
		}
	});
});

function idchk(){
	var id = $("#checkid").val();
	var userIdCheck = RegExp(/^[A-Za-z0-9_\-]{5,20}$/);
	$.ajax({
		type: "post",
		dataType: "html",
		data: {
			"id":id
		},
		url: "idcheck.jsp",
		success: function(data){
			if(!userIdCheck.test($('#checkid').val())){
				$("#idchkResult").html("아이디 양식에 맞춰 주세요<br>영문 대.소문자, 숫자 _,-만 입력 가능하고 5에서 20자리를 입력가능 합니다.");
				$(".com").attr("chk","no");
			}else{
				$("#idchkResult").text(data);
				console.log(data);
				var tt = $.trim(data);
				if(tt=="사용 가능한 아이디 입니다." && userIdCheck.test($('#checkid').val()))
					$(".com").attr("chk","yes");
				else
					$(".com").attr("chk","no");
			}
		}
	});
}

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
