$(function(){
	var id = $("#searchId").val();
	followedList(id);
	followingList(id);
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
					followingList(id);
					followedList(id);
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
					followedList(id);
					followingList(id);
				}
			});
		}
	});
});

function followedList(id){
	$.ajax({
		type:"get",
		url:"member/followedList.jsp",
		dataType:"html",
		data:{
			"id":id
		},
		success:function(data){
			$(".followed").html(data).trigger("create");;
		}
	});
}
function followingList(id){
	$.ajax({
		type:"get",
		url:"member/followingList.jsp",
		dataType:"html",
		data:{
			"id":id
		},
		success:function(data){
			$(".follower").html(data).trigger("create");;
		}
	});
}