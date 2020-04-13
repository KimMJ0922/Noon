$(function(){
	$("a.showProfile").click(function(){
		getProfile($(this).text());
	});
	
	$(document).on("click",".follow,.following",function(){
		if($(this).attr("class")=="follow"){
			$.ajax({
				success:function(data){
					$(this).attr("class","pro-btn following");
				}
			});
		}else{
			$.ajax({
				success:function(data){
					$(this).attr("class","pro-btn follow");
				}
			});
		}
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
			var imgsrc = "";
			var loginid = $.trim($("#loginid").text());
			var followchk = $.trim(followed(loginid,data.id));
			console.log(followchk);
			if(data.pic == null)
				imgsrc = "profile/default.png";
			else
				imgsrc = "profile/"+data.id+"/"+data.pic;
			
			$(".userId").attr("data-toggle","modal");
			$(".userId").attr("data-target","#profile");
			str+="<div id='profile' class='modal fade' role='dialog'>";
			str+="<div class='modal-dialog'>";
			str+="<div class='modal-content' style='width: 402px; margin: auto;'>";
			str+="<div class='modal-body profile-body'>";
			str+="<div class='pro-box'>";
			str+="<div class='pro-container'>";
			str+="<div class='pro-left'>";
			str+="<a href='#' class='pro-image'>";
			str+="<img src='"+imgsrc+"' alt=''>";
			str+="</a>";
			str+="<div class='pro-profile'>";
			str+="<p>"+data.name+"</p>";
			str+="</div>";
			str+="<div class='pro-actions'>";
			if(loginid==data.id){
				str+="<a href='main.jsp?view=member/MyProfile.jsp&content=profile.jsp' class='pro-btn'>프로필 수정</a>";
			}else if(followchk=="true"){
				str+="<a href='member/followAction.jsp?fromid="+loginid+"&toid="+data.id+"' class='pro-btn following' id='followbtn'>언팔로우</a>";
			}else{
				str+="<a href='member/followAction.jsp?fromid="+loginid+"&toid="+data.id+"' class='pro-btn follow' id='followbtn'>팔로우</a>";
			}
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

function followed(fromid, toid){
	var bool = "";
	$.ajax({
		type:"get",
		url:"member/followchk.jsp",
		dataType:"html",
		data:{
			"fromid":fromid,
			"toid":toid
		},
		async:false,
		success:function(data){
			console.log(data);
			bool = data;
		}
	});
	return bool;
}
