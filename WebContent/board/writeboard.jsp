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
<script type="text/javascript">
$(function(){
	$(".choicepicture").click(function(){
		$("#imglist").css("display","inline-block");
	});
});
</script>
</head>
<body>
<div class=" writeboardform" style="padding: 0;">
	<form name="fileform" id="fileform" method="post"
		  action="board/writeboardaction.jsp" enctype="multipart/form-data">
		<div id="imglist" style="display: none;">
		</div>
		<div>
			<textarea id="content" name="content" placeholder="id 님, 오늘 하루 어떤가요?" cols="50" rows="10" required="required"></textarea>
		</div>
<!-- 		<label for="hashtag"><h5>#입력해주세요</h5></label> -->
		<div id="hashtag">
			<div>
				<input type="text" placeholder="이곳에 #태그를 입력하세요." id="hashtagtext" name="hashtagtext">
				<input type="hidden" id="taghidden" name="taghidden">
			</div>
			<div id="taglist"></div>
			
		</div>
		<div class="writeboardbtn">
			<label id="write" name="write" style="margin: 0;font-weight: unset;">작성완료</label>
			
			<label for="photo" class="choicepicture" style="margin: 0;font-weight: unset;">사진선택</label>
		</div>
		<div class="filebox">
			<input type="file" name="photo"
				   id="photo" accept="image/gif, image/jpeg, image/png, image/jpg"
				   multiple="true">
		</div>	
	</form>
</div>
</body>
</html>