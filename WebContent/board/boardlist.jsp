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
		
<!-- 		<button type="button" id="writebtn">글쓰기</button> -->
<!-- 		<button type="button" id="hsbtn">알림</button> -->
	</div>
	
	<div id="history">
	
	</div>
	<div id="list">
	
		
		
	</div>
	<div class="remocon">
		<a><div class="showboard remoconlist"></div></a>
		<a><div class="favorite remoconlist" ></div></a>
		<a><div class="alam remoconlist" ></div></a>
		<a href="#"><div class="pagetopup remoconlist"></div></a>
		<a><div class="setting remoconlist"></div></a>
	</div>
</body>
</html>