
$(function(){
	list();

		$(document).on("click",".up",function(e){
			var id=$(this).attr("id");
			var type=$(this).attr("member");
			console.log("a");
			if(type=="관리자"){
				alert("관리자 이상은 올라갈 수 없습니다.");
			}else{
				$.ajax({
			        type:"post", 
			        url:"member/admin_up.jsp", 
			        dataType:"html",
			        data:{
			        	"id":id,
			        	"type":type
			        },
			        success:function(data){
			        	list();
					}
				});
			}
		});	
		
		$(document).on("click",".down",function(){
			var id=$(this).attr("id");
			var type=$(this).attr("member");
			if(type=="일반회원"){
				alert("일반회원 이하는 없습니다.");
			}else if(type=="우수회원"||type=="관리자"){
				$.ajax({
			        type:"post", 
			        url:"member/admin_down.jsp", 
			        dataType:"html",
			        data:{
			        	"id":id,
			        	"type":type
			        },
			        success:function(data){
			        	list();
					}
				});
			}
			
		});
		
		$(document).on("click",".del",function(){
			var id=$(this).attr("id");
			var type=$(this).attr("member");
			
			if(type=="관리자"){
				alert("관리자는 삭제할 수 없습니다.");
				return;
			}
			$.ajax({
		        type:"post", 
		        url:"member/admin_del.jsp", 
		        dataType:"html",
		        data:{
		        	"id":id,
		        },
		        success:function(data){
		        	list();
				}
			});
			
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
