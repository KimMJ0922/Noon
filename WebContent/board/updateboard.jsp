<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="../js/jquery.form.js"></script>
<script src="../js/updateboard.js"></script>
<link rel= "stylesheet" type="text/css" href="../css/writeboard.css">
<script type="text/javascript">

</script>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
%>
<body>
	
	<form name="fileform" id="fileform" method="post"
		  action="updateboardaciton.jsp" enctype="multipart/form-data">
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