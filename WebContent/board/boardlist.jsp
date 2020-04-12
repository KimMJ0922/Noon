<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel= "stylesheet" type="text/css" href="css/board/boardlist.css">
<script type="text/javascript" src="js/board/onhashchange.js"></script>
<script type="text/javascript" src="js/board/boardlist.js"></script>
<script type="text/javascript">
$(function(){
	$(".alam").click(function(){
		$(".alambox").toggle("fast");
	});
});

</script>
</head>
<body>
<%
	String[] comment = {"오늘 하루는 어땠나요?",
						"오늘 기분 어떠신가요?",
						"자랑 할 일이 있나요?",
						"알리고 싶은 소식이 있나요?"
					   };
	double ran = Math.random()*4;
	int ranf = (int)ran;
	System.out.println(ranf);
%>
	<div style="margin: 1px auto; width: 500px;">
		<textarea class="addwrite" id="writebtn" placeholder="<%=comment[ranf]%>"></textarea>
	</div>
	
	<div id="history">
	
	</div>
	<div id="list">
	
	</div>
	<div class="remocon">
		<a><div class="showboard remoconlist" idx="0"></div></a>
		<div class="remoconcomment">최신순</div>
		<a><div class="favorite remoconlist" idx="1"></div></a>
		<div class="remoconcomment" >좋아요순</div>
		<a><div class="alam remoconlist" idx="2"></div></a>
		<div class="remoconcomment">알림</div>
		<div class="alambox">
			<div  class="alamul">
				<span class="alamli">
				<!--이부분 반복  시작-->
					<a href="#">
						<!-- 게시물첫번째그림 표시 -->
						<img src="profile/default.png" alt="d" class="alamprofilelist">
						 ming__go_'v'_ 님이 게시물에 댓글을 남겼습니다.(텍스트 넘어가ㅏ면...보이게하는거 보여주는용)
					</a>
				</span>
				<br>
				<!--이부분 반복 끝 -->
			</div>
		</div>
		<a href="#"><div class="pagetopup remoconlist" idx="3"></div></a>
		<div class="remoconcomment">맨위로</div>
		<a><div class="setting remoconlist" idx="4"></div></a>
		<div class="remoconcomment" >설정</div>
	</div>
</body>
</html>