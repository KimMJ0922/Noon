<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="js/board/jquery.form.js"></script>
<script src="js/board/updateboard.js"></script>

<link rel= "stylesheet" type="text/css" href="css/board/writeboard.css">

</head>
<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
%>
<body>
	
	<form name="fileform" id="fileform" method="post"
		  action="board/updateboardaciton.jsp" enctype="multipart/form-data">
		<input type="hidden" name="num" id="num" value="<%=num%>">
		<div>
			<textarea id="content" name="content" cols="50" rows="10"></textarea>
		</div>
		<div class="filebox">
			<label for="photo">업로드</label>
			<input type="file" name="photo"
				   id="photo" accept="image/gif, image/jpeg, image/png, image/jpg"
				   multiple="true">
		</div>
		<div id="imglist">
		
		</div>
		<label for="hashtag"><h2>해시태그</h2></label>
		<div id="hashtag">
			<div id="taglist"></div>
			<div>
				<input type="text" id="hashtagtext" name="hashtagtext">
				<input type="hidden" id="taghidden" name="taghidden">
			</div>
		</div>
		<input id="write" name="write" type="submit" value="전송">
	</form>
</body>
</html>