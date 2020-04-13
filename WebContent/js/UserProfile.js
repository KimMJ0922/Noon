$(function(){
	$("a.showProfile").click(function(){
		getProfile($(this).text());
	});
});

function getProfile(id){
	$.ajax({
		type:"get",
		url:"member/memberJson.jsp",
		dataType:"json",
		data:{
			"id":id
		},
		success:function(data){
			var str="";
			$(".userId").attr("data-toggle","modal");
			$(".userId").attr("data-target","#profile");
			console.log(data);
			str+="<div id='profile' class='modal fade' role='dialog'>";
			str+="<div class='modal-dialog'>";
			str+="<div class='modal-content' style='width: 402px; margin: auto;'>";
			str+="<div class='modal-body profile-body'>";
			str+="<div class='pro-box'>";
			str+="<div class='pro-container'>";
			str+="<div class='pro-left'>";
			str+="<a href='#' class='pro-image'>";
			str+="<img src='http://100dayscss.com/codepen/jessica-potter.jpg' alt=''>";
			str+="</a>";
			str+="<div class='pro-profile'>";
			str+="<p>"+data.name+"</p>";
			str+="</div>";
			str+="<div class='pro-actions'>";
			str+="<a href='#' class='pro-btn'>Follow</a><a href='#' class='pro-btn'>Message</a>";
			str+="</div>";
			str+="</div>";
			str+="<div class='pro-right'>";
			str+="<a href='#' class='pro-right-box'>";
			str+="<p>523</p> <span>Posts</span></a>";
			str+="<a href='#' class='pro-right-box'>";
			str+="<p>1387</p> <span>Likes</span></a>";
			str+="<a href='#' class='pro-right-box'>";
			str+="<p>146</p> <span>Followers</span></a>";
			str+="</div>";
			str+="</div>";
			str+="</div>";
			str+="</div>";
			str+="<div class='modal-footer'>";
			str+="<button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>";
			str+="</div>";
			str+="</div>";
			str+="</div>";
			str+="</div>";
			
			$(".profileModal").html(str);
			$("#profile").modal('show');
		}
	});
}