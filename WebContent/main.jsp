<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Noon</title>
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- jQuery library -->
 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- css폴더 안에 있는 파일 목록 -->
<link rel= "stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel= "stylesheet" type="text/css" href="css/dark/darkmode.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<%
	String dark_se="";
	dark_se=(String)session.getAttribute("dark_check");
	if(dark_se==null){
		dark_se="0";
	}
	if(dark_se.equals("1")||dark_se==null){
		%>
		<link rel= "stylesheet" type="text/css" href="css/dark/darkmode.css">
		<%
	}else{
	}
%>
<script>
$(function(){
	var darkmodes=$("#darkmodes").val();
		if(darkmodes=="1"){
			$("body").addClass("backdark");
			$(".addwrite").addClass("dark-mode");
			$(".board>div").addClass("dark-mode transform");
			$(".boarddetail>pre").addClass("dark-mode transform");
			$(".howtotopdark").addClass("topdark");
			$(".likey").attr("src","img/like/like01_dark.png");
			
			$(".topcontent>button").addClass("searchbtndark searchtransform");
			$(".topcontent>button").removeClass("searchbtn");
			
			
			$(".showboard").addClass("showboardDark");
			$("#showboard").removeClass("showboard");
			
			$(".favorite").addClass("favoriteDark");
			$("#favorite").removeClass("favorite");
			
			$(".alam").addClass("alamDark");
			$("#alam").removeClass("alam");
			
			$(".pagetopup").addClass("pagetopupDark");
			$("#pagetopup").removeClass("pagetopup");
			
			$(".setting").addClass("settingDark");
			$("#setting").removeClass("setting");
			
			$("#darkmode").addClass("darkmode");
			$("#darkmode").removeClass("lightmode");
		}

		$("#darkmode").click(function(){
			if($(this).hasClass('darkmode')){
				$(this).removeClass('darkmode');
				$(this).addClass('lightmode'); 
			}else if($("#darkmode").hasClass('lightmode')){
				$(this).removeClass('lightmode');
				$(this).addClass('darkmode'); 
			} 
		});
			
		$("#darkmode").click(function(){
			var dark=$("#darkmodes").val();
			if(dark=="1"){
				//light 모드
				$("#darkmodes").val("0");
				$("body").removeClass("backdark ");
				$(".addwrite").removeClass("dark-mode ");
				$(".board>div").removeClass("dark-mode ");
				$(".boarddetail>pre").removeClass("dark-mode ");
				$(".howtotopdark").removeClass("topdark ");
				$(".searchtag").css({"border-color":"#000"});
				
				$(".likey").attr("src","img/like/like01.png").addClass("transform");
				$(".likying").attr("src","img/like/like02.png");
				$(".boardform").removeClass("boarddark");
				$(".boardform>div").removeClass("dark-mode");
				$(".boardform").addClass("board transform");
				$(".conpre>pre>a").css("color","#000");
				$(".remoconcomment").removeClass("recomentdark");
				
				$(".topcontent>button").removeClass("searchbtndark ");
				$(".topcontent>button").addClass("searchbtn");
				
				$("#showboard").removeClass("showboardDark");
				$("#showboard").addClass("showboard");
				
				$("#favorite").removeClass("favoriteDark");
				$("#favorite").addClass("favorite");
				
				$("#alam").removeClass("alamDark");
				$("#alam").addClass("alam");
				
				$("#pagetopup").removeClass("pagetopupDark");
				$("#pagetopup").addClass("pagetopup");
				
				$("#setting").removeClass("settingDark");
				$("#setting").addClass("setting");
				
				$("#darkmode").removeClass("darkmode");
				$("#darkmode").addClass("lightmode");
				$(".menubtn").css({
					"background":"url('img/icon/menu_icon.png')",
					"background-repeat": "no-repeat",
					"background-position": "center center"
				});
				
				$(".btns").css("color","black");
				
				$(".status").html("라이트 모드");	
			}else{
				//dark 모드
				$("#darkmodes").val("1");
				
				$("body").addClass("backdark transform");
				$(".addwrite").addClass("dark-mode transform");
				$(".board>div").addClass("dark-mode transform");
				$(".boarddetail>pre").addClass("dark-mode transform");
				$(".howtotopdark").addClass("topdark transform");
				$(".searchtag").css({"border-color":"#fff"});
				
				$(".remoconcomment").addClass("recomentdark");
				$(".status").html("다크 모드");
				
				$(".likey").attr("src","img/like/like01_dark.png");
				$(".likying").attr("src","img/like/like02.png");
				$(".boardform").addClass("boarddark transform");
				$(".boardform").removeClass("board");
				$(".conpre>pre>a").css("color","#fff");
				$(".topcontent>button").addClass("searchbtndark searchtransform");
				$(".topcontent>button").removeClass("searchbtn");
				
				$(".showboard").addClass("showboardDark");
				$("#showboard").removeClass("showboard");
				
				$(".favorite").addClass("favoriteDark");
				$("#favorite").removeClass("favorite");
				
				$(".alam").addClass("alamDark");
				$("#alam").removeClass("alam");
				
				$(".pagetopup").addClass("pagetopupDark");
				$("#pagetopup").removeClass("pagetopup");
				
				$(".setting").addClass("settingDark");
				$("#setting").removeClass("setting");
				
				$("#darkmode").addClass("darkmode");
				$("#darkmode").removeClass("lightmode");
				
				$(".menubtn").css({
					"background":"url('img/icon/menu_icon_dark.png')",
					"background-repeat": "no-repeat",
					"background-position": "center center"
				});
				$(".btns").css("color","black");
				
			}
			$.ajax({
				type:"post",
				url:"css/dark/dark_mode_session.jsp",
				dataType:"html",
				data:{"dark":dark},
				success:function(data){}
			});
		});
});		
</script>
<style>
*{
font-family: 'Noto Sans KR', sans-serif;
}
.row>.boardlist {
	background: #DBDBDB;
	border: 1px solid #000;
}
.topmain{
	width:100%;
	background-color: #FAFAFA;
	max-height: 120px;
	border-bottom: 1px solid #DBDBDB;
}
</style>
</head>
<%
	String id = (String)session.getAttribute("id");
	String loginok = (String)session.getAttribute("loginok");
	if(loginok==null||loginok==""){
%>
	<script>
		alert("로그인해주세요");
		location.replace("login/noonlogin.jsp");
	</script>
<%
	}
	String view = request.getParameter("view");
	if(view==null)
		view="board/boardlist.jsp";
	
	//룰루
%>
<body>

	<div class="container topmain" style="padding:0; margin:0; overflow: hidden;">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12 ">
				<jsp:include page="top/topmenu.jsp"/>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
<%
			if(view.indexOf("board_Detail_form.jsp")!=0){
%>
				<jsp:include page="<%=view %>" />
<%
			}else{
%>
				<div class="col-md-12 col-sm-12 col-xs-12 boardlist">
					<jsp:include page="<%=view %>" />
				</div>
<%
			}
%>
		</div>
	</div>
	<div>
		<jsp:include page="footer/footer.jsp" />
	</div>
</body>
</html>