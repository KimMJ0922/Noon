<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>Insert title here</title>
<script src='https://code.jquery.com/jquery-1.10.2.js'></script>
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'>
<link rel='stylesheet' href='style.css'>
<script	src='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js'></script>
</head>
<body>
	<!-- Trigger the modal with a button -->
	<a data-toggle='modal' data-target='#profile'>Open Modal</a>

	<!-- Modal -->
	<div id='profile' class='modal fade' role='dialog'>
		<div class='modal-dialog'>

			<!-- Modal content-->
			<div class='modal-content' style='width: 402px; margin: auto;'>
				<div class='modal-body profile-body'>
					<div class='pro-box'>
						<div class='pro-container'>
							<div class='pro-left'>
								<a href='#' class='pro-image'> 
									<img src='http://100dayscss.com/codepen/jessica-potter.jpg' alt=''>
								</a>
								<div class='pro-profile'>
									<p>Jessica Potter</p>
								</div>
								<div class='pro-actions'>
									<a href='#' class='pro-btn'>Follow</a><a href='#' class='pro-btn'>Message</a>
								</div>
							</div>
							<div class='pro-right'>
								<a href='#' class='pro-right-box'>
									<p>523</p> <span>Posts</span>
								</a> <a href='#' class='pro-right-box'>
									<p>1387</p> <span>Likes</span>
								</a> <a href='#' class='pro-right-box'>
									<p>146</p> <span>Followers</span>
								</a>
							</div>
						</div>
					</div>
				</div>
				<div class='modal-footer'>
					<button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>