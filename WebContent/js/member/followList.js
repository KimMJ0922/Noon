$(function(){
	var id = $("#searchId").val();
	var cnt = 0;
	followedList(id, cnt);
	followingList(id, cnt);
	
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
					cnt=1;
					followingList(id, cnt);
					followedList(id, cnt);
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
					cnt=1;
					followedList(id, cnt);
					followingList(id, cnt);
				}
			});
		}
	});
});

function followedList(id, cnt){
	$.ajax({
		type:"get",
		url:"member/followedList.jsp",
		dataType:"html",
		data:{
			"id":id,
			"cnt":cnt
		},
		success:function(data){
			$(".followed").html(data);
		}
	});
}
function followingList(id, cnt){
	$.ajax({
		type:"get",
		url:"member/followingList.jsp",
		dataType:"html",
		data:{
			"id":id,
			"cnt":cnt
		},
		success:function(data){
			$(".follower").html(data);
		}
	});
}