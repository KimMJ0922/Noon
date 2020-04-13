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
<%
	String aa=(String)session.getAttribute("dark_check");
	if(aa==null){
		aa="0";
	}
	if(aa.equals("1")||aa==null){
		System.out.println(" 다크모드");
	}else{
		System.out.println("일반모드");
	}
%>
<script>
$(function(){
	
var a=$("#darkmodes").val();

		
// 			$("#darkmode").toggle(function () {
// 				$(this).css({"background-image":"url('img/icon/moon_dark.png')"});
// 			}, function () {
// 				$(this).css({"background-image":"url('img/icon/moon.png')"});
// 			});
			$("#darkmode").click(function(){
				if($(this).hasClass('darkmode'))
					{
						$(this).removeClass('darkmode');
						$(this).addClass('lightmode'); 
					}
					else if($("#darkmode").hasClass('lightmode'))
					{
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
				$(".likey").attr("src","img/like/like01.png").addClass("transform");
				$("#menubtn").attr("src","img/icon/menu_icon.png");
				
				
				
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
			}else{
				//dark 모드
				$("#darkmodes").val("1");
				
				$("body").addClass("backdark transform");
				$(".addwrite").addClass("dark-mode transform");
				$(".board>div").addClass("dark-mode transform");
				$(".boarddetail>pre").addClass("dark-mode transform");
				$(".howtotopdark").addClass("topdark transform");
				$(".likey").attr("src","img/like/like01_dark.png");
				$("#menubtn").attr("src","img/icon/menu_icon_dark.png");
				
				
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
			$.ajax({
				type:"post",
				url:"css/dark/dark_mode_session.jsp",
				dataType:"html",
				data:{"dark":dark},
				success:function(data){
					}
			});
		});
});		
</script>
<style>
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
	if(loginok==null){
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
	System.out.println(view);
%>
<body>

	<div class="container topmain" style="padding:0; margin:0;">
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