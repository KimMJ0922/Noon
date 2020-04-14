$(function(){
	followedList();
	
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
					followedList();
				}
			});
		}
	});
});

function followedList(){
	$.ajax({
		type:"get",
		url:"member/followedList.jsp",
		dataType:"html",
		success:function(data){
			$(".followed").html(data);
		}
	});
}