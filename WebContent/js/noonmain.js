$(function(){
	$(".main_submit").click(function(){
		var id=$("#id").val();
		$.ajax({
			type: "post", 
			url: "loginaction.jsp", 
			dataType: "html",
			async: false,
			data:{
				"id":id
			},
			success:function(data){
				
				location.replace("../board/boardlist.jsp");
			}
		});
	});
});//$(function)끝