$(function(){
	list();
	var rankArry = ["일반회원","우수회원","관리자"];
	
	$(document).on("click",".up",function(e){
		var id=$(this).attr("id");
		var type=$(this).attr("member");
		
		if(type=="관리자"){
			alert("관리자 이상은 올라갈 수 없습니다.");
			return false;
		}else if(type=="우수회원"){
			type=rankArry[2];
		}else{
			type = rankArry[1];
		}
		
		rank(id,type);
	});	

	$(document).on("click",".down",function(){
		var id=$(this).attr("id");
		var type=$(this).attr("member");
		if(type=="일반회원"){
			alert("일반회원 이하는 없습니다.");
			return false;
		}else if(type=="우수회원"){
			type = rankArry[0];
		}else{
			type = rankArry[1];
		}
		
		rank(id,type);
	});

	$(document).on("click",".del",function(){
		var id=$(this).attr("id");
		var type=$(this).attr("member");

		if(type=="관리자"){
			alert("관리자는 삭제할 수 없습니다.");
			return false;
		}else{
			deleteMember(id);
		}
	});
	$("#searchId").keyup(function(){
		var text = $(this).val();
		searchList(text);
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

function searchList(text){
	$.ajax({
		type:"post",
		dataType:"html",
		url:"member/admin_page.jsp",
		data:{
			"id":text
		},
		success:function(data){
			$(".admin_content").html(data);
		}
	});
}

function rank(id,type){
	var search = $("#searchId").val();
	$.ajax({
		type:"post", 
		url:"member/admin_rank.jsp", 
		dataType:"html",
		data:{
			"id":id,
			"type":type
		},
		success:function(data){
			if(search==null||search==""){
				list();
			}else{
				searchList(id);
			}
		}
	});
}

function deleteMember(id){
	var search = $("#searchId").val();
	$.ajax({
		type:"post", 
		url:"member/admin_del.jsp", 
		dataType:"html",
		data:{
			"id":id,
		},
		success:function(data){
			if(search==null||search==""){
				list();
			}else{
				searchList(id);
			}
		}
	});
}