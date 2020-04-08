<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8 no-cache">

<script type="text/javascript" src="js/board/writeboard.js"></script>
<script src="js/board/jquery.form.js"></script>

<link rel= "stylesheet" type="text/css" href="css/board/writeboard.css">
<title>Insert title here</title>
</head>
<body>
	<form name="fileform" id="fileform" method="post"
		  action="board/writeboardaction.jsp" enctype="multipart/form-data">
		<div>
			<textarea id="content" name="content" cols="50" rows="10" required="required"></textarea>
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