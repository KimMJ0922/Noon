
$(function(){
	list();
	
		$(document).on("click",".up",function(){
			var id=$(this).attr("id");
			var type=$(this).attr("memeber");
			
			
			$.ajax({
		        type:"post", 
		        url:"member/admin_up.jsp", 
		        dataType:"html",
		        data:{
		        	"id":id,
		        	"type":type
		        },
		        async: false,
		        success:function(data){
		        	list();
				}
			});
			
		});	
		
		$(document).on("click",".down",function(){
			
			
		});
		
		$(document).on("click",".del",function(){
			
			
		});

});

function list(){
	$.ajax({
		type:"post",
		dataType:"html",
		url:"member/admin_page.jsp",
		success:function(data){
			$(".admin_content").html(data);
		}
	});
}
