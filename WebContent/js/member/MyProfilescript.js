/*active button class onclick*/
$(function(){
	
	$('#view').css({opacity: 0.0, visibility: "visible"}).animate({opacity: 1.0},600);
	
	$(".custom-nav a").click(function () {
		var url = $(this).attr("href");
		$("#view").animate({
			"opacity": "0",
			//"top": "10px"
		},600, function () {
			document.location.href = url;
		});
		
		return false;
	});
	
	var minrow = 0;
	var maxrow = 10;
	
	$(".update").click(function(){
		$(this).parent().addClass("hidden");
		$(this).parent().parent().next().removeClass("hidden");
	});
	
	$(".cancel").click(function(){
		$(this).parent().addClass("hidden");
		$(this).parent().prev().children().removeClass("hidden");
	});
	
	$(".submit").click(function(){
		var inputSelect = $(this).prev().prev()
		var data = inputSelect.val();
		var type = inputSelect.attr("name");
		
		console.log(data,type);
		
		var hpCheck = RegExp(/^01[0179]-[0-9]{3,4}-[0-9]{4}$/);
		var emailCheck = RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
		var passwdCheck = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/);
		if(type=="hp" && !hpCheck.test(data)){
			alert("휴대폰 형식에 맞지 않습니다.");
			return;
		}
		else if(type=="email" && !emailCheck.test(data)){
			alert("이메일 형식에 맞지 않습니다.");
			return;
		}
		else if(type=="addr" && data.indexOf("/")==-1){
			alert("주소 형식에 맞지 않습니다. 세부 주소는 / 뒤에 적어주세요");
			return;
		}
		else if(type=="pass" && !passwdCheck.test(data)){
			alert("비밀번호 형식에 맞지 않습니다.");
			return;
		}
		update(data,type);
		$(this).parent().addClass("hidden");
		$(this).parent().prev().children().removeClass("hidden");
	});
});

function update(data,type){
	$.ajax({
		type:"post",
		url:"member/updateAction.jsp",
		dataType:"html",
		data:{
			"data":data,
			"type":type
		},
		success:function(data){
			getData();
			alert("수정완료");
			location.reload();
		}
	});
}

function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function (e) {
			$('#preview').attr('src', e.target.result);
		};

		reader.readAsDataURL(input.files[0]);
	}
}

//회원이 작성한 글
function memberBoardList(minrow, maxrow){
	var text = $.trim($(".searchtag").val());
	var id = $("#getId").val();
	$.ajax({
		type: "post", 
		url: "board/memberboard/getmemberboardlist.jsp", 
		dataType: "html",
		async: false,
		data:{
		   "id":id,
		   "minrow":minrow,
		   "maxrow":maxrow
		},
		success:function(data){
		}
	 });
}

function deleteMember(){
	var pass = $("#deletePass").val();
	var ans = confirm("탈퇴 하시겠습니까?");
	if(ans==false)
		return;
	$.ajax({
		type:"post",
		url:"member/deleteMember.jsp",
		dataType:"html",
		data:{
			"pass":pass
		},
		success:function(data){
			console.log(data.trim());
			if(data.trim()=="false"){
				alert("비밀번호를 확인해주세요");
				$("#deletePass").val("");
				$("#deletePass").focus();
			}else{
				alert("정상적으로 탈퇴 되었습니다.");
				location.replace("login/noonlogin.jsp");
			}
		}
	});
}