$(function(){
	var minrow = 0;
	var maxrow = 10;
	memberBoardList(minrow, maxrow);
});
//회원이 작성한 글
function memberBoardList(minrow, maxrow){
	var text = $.trim($(".searchtag").val());
	var loginid = $.trim($("#loginid").text());
	
	if(text.indexOf("#")==-1 && text.length==0){
		$("#getId").val(loginid);
	}else if(text.indexOf("#")==-1 && text.length>0){
		$("#getId").val(text);
	}else{
		$("#getId").val(loginid);
	}
	
	id = $("#getId").val();
	$.ajax({
        type: "post", 
        url: "board/memberboard/getmemberboardlist.jsp", 
        dataType: "html",
        async: false,
        data:{
           "id":id,
           "minrow":minrow,
           "maxrow":maxrow
        },
        success:function(data){
        	$("#memberboardlist").html(data);
        }
     });
}