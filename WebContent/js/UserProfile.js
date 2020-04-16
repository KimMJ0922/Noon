$(function(){
	$(document).on("click","a.showProfile",function(){
		getProfile($(this).text());
	});
	$(document).on("click",".follow,.following",function(){
		var fromid = $(this).attr("fromid");
		var toid = $(this).attr("toid");
		if($(this).attr("class")=="pro-btn follow"){
			$(this).attr("class","pro-btn following");
			$(this).text("언팔로우");
			$.ajax({
				type:"get",
				url:"member/followAction.jsp",
				dataType:"html",
				data:{
					"fromid":fromid,
					"toid":toid
				},
				success:function(data){
				}
			});
		}else{
			$(this).attr("class","pro-btn follow");
			$(this).text("팔로우");
			$.ajax({
				type:"get",
				url:"member/unfollowAction.jsp",
				dataType:"html",
				data:{
					"fromid":fromid,
					"toid":toid
				},
				success:function(data){
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
				str+="<a fromid="+loginid+" toid="+data.id+" class='pro-btn following' style='cursor: pointer;'>언팔로우</a>";
			}else{
				str+="<a fromid="+loginid+" toid="+data.id+" class='pro-btn follow' style='cursor: pointer;'>팔로우</a>";
			}
			str+="</div>";
			str+="</div>";
			str+="<div class='pro-right'>";
			str+="<a href='#' class='pro-right-box'>";
			str+="<p>"+data.like+"</p> <span>좋아요</span></a>";
			str+="<a href='main.jsp?view=member/MyProfile.jsp&content=boardlist/memberboardlist.jsp&id="+data.id+"' class='pro-right-box'>";
			str+="<p>"+data.boardcnt+"</p> <span>게시글</span></a>";
			str+="<a href='main.jsp?view=member/MyProfile.jsp&content=follower.jsp&id="+data.id+"' class='pro-right-box'>";
			str+="<p>"+data.followCnt+"</p> <span>팔로워</span></a>";
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
