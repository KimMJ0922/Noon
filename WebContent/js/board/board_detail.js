$(function(){
	var boardnum = $("#re_board_text").attr("num");
	//댓글 불러오기
	getReply();
	getReplyNum(boardnum);
	getLikeNum(boardnum);
	getLikeStatus(boardnum);
	$("#re_send").click(function(){
		var content = $("#re_board_text").val();
		
		if($.trim(content).length==0){
			alert("댓글을 입력해주세요.");
			return false;
		}else{
			$.ajax({
				type:"post",
				dataType:"html",
				url:"board/board_Detail/board_Detail_reply_add.jsp",
				data:{
					"boardnum":boardnum,
					"content":content
				},
				async: false,
				success:function(data){
					 $("#re_board_text").val("");
					getReply(); 
					getReplyNum(boardnum);
				}
			});
		}
	});
	//삭제 버튼 눌렀을 때
	$(document).on("click","#del_btn",function(){
		var replynum=$(this).parent("div").attr("replynum");
		var pclass = $(this).siblings("p:eq(0)").attr("class");
		var content=$(this).siblings("."+pclass).children(".re_reply_textarea").val();
		
		var str=$(this).val();
		if(str=="수정"){
			if($.trim(content).length==0){
				alert("댓글을 입력해주세요");
				return false;
			}else{
				$.ajax({
			        type:"post", 
			        url:"board/board_Detail/board_Detail_reply_update.jsp", 
			        dataType:"html",
			        data:{
			        	"replynum":replynum,
			        	"content":content
			        },
			        async: false,
			        success:function(data){
			        	getReply();
			        	getReplyNum(boardnum);
					}
				});
			}
		}else{
			var replynum=$(this).parent("div").attr("replynum");
			var ch = confirm("해당 댓글을 삭제하시겠습니까?");
			if(ch==true){
				deleteReply(replynum,boardnum);	
				getReplyNum(boardnum);
			}else{
				return false;
			}
			
		}
		
	}); 
	
	//수정버튼 눌렀을때
	$(document).on("click","#up_btn",function(){
		var replynum=$(this).parent("div").attr("replynum");
		var pclass = $(this).siblings("p:eq(0)").attr("class");
		var content=$(this).siblings("."+pclass).text();
			
		if($(this).val()=="수정취소"){
			getReply();
			getReplyNum(boardnum);
		}else{
			$(this).siblings("."+pclass).html("<textarea class='re_reply_textarea'>"+content+"</textarea>");
			$(this).siblings("#del_btn").val("수정");
			$(this).val("수정취소");
		}
	}); 
	
	
	//답글 버튼 눌렀을때
	$(document).on("click","#re_btn",function(){
		var prtname=$(this).parent("p").siblings("a").attr("prtname");
	
		var a =$(this).parent("p").siblings("div");
		a.html("<textarea class='re_re'>@"+prtname+"  </textarea>");
		a.append("<input type='button' id='re_re_cc' style='border:none;background:none;font-size:12px;' value='취소'>");
		a.append("<input type='button' id='re_re_add' style='border:none;background:none;font-size:12px;' value='답글 달기'>");
	});
	//답글-> 취소
	$(document).on("click","#re_re_cc",function(){
		var a =$(this).parent("div");
		a.html("");
	});
	
	$(document).on("click","#re_re_add",function(){
		var content =$(this).siblings(".re_re").val();
		var replynum = $(this).parent("div").attr("replynum");
		var writer = $(this).parent("div").attr("writer");
			 $.ajax({
		        type:"post", 
		        url:"board/board_Detail/board_Detail_replay_re_add.jsp", 
		        dataType:"html",
		        data:{
		        	"content":content,
		        	"replynum":replynum,
		        	"boardnum":boardnum,
		        	"writer":writer
		        },
		        async: false,
		        success:function(data){
		        	getReply();
		        	getReplyNum(boardnum);
				}
			}); 
	});
	//모달 이미지 상세화면
	$(document).on("click","#modal_img",function(){
		var imgsrc=$(this).attr("src");
		
		$("#atfer_modal_img").attr("src",imgsrc);
		
		
	});
	//좋아요 아이콘 눌렀을 때
	$(".likeyimg").click(function(){
		var src = $(this).attr("src");
		var cnt = 0;
		var dark = $("#darkCheck").val();
		if(src.indexOf("like01")>=0){
			$(this).attr("src","img/like/like02.png");
			cnt++;
		}else{
			if(dark=="1"){
				$(this).attr("src","img/like/like01_dark.png");
			}else{
				$(this).attr("src","img/like/like01.png");
			}
			
			cnt--;
		}
		
		$.ajax({
	        type:"post", 
	        url:"board/likes/updatelike.jsp", 
	        dataType:"html",
	        data:{
	        	"num":boardnum,
	        	"likes":cnt
	        },
	        async: false,
	        success:function(data){
	        	$(".likycnt").html("좋아요 "+$.trim(data)+"개");
			}
		});
		
	});
	
	//글 삭제 버튼
	$(document).on("click",".delbtn",function(){
	      var num = $(this).attr("num");
	      var ch = confirm("해당 글을 삭제하시겠습니까?");
	      if(ch==true){
	         $.ajax({
	            type: "post", 
	            url: "board/deleteboard.jsp", 
	            dataType: "html",
	            async: false,
	            data:{
	               "num":num
	            },
	            success:function(data){
	            	location.replace("main.jsp");
	            }
	         });
	      }else{
	         return false;
	      }
	   }); 
});//window.function 끝

function deleteReply(replynum,boardnum){
	$.ajax({
        type:"post", 
        url:"board/board_Detail/board_Detail_reply_delete.jsp", 
        dataType:"html",
        data:{
        	"replynum":replynum,
        	"boardnum":boardnum
        },
        async: false,
        success:function(data){
        	getReply();
        	getReplyNum(boardnum);
		}
	});
} 
function getReply(){
	var boardnum = $("#re_board_text").attr("num");
	$.ajax({
        type:"post", 
        url:"board/board_Detail/board_Reply_get_data.jsp", 
        dataType:"json",
        data:{
        	"boardnum":boardnum
        },
        async: false,
        success:function(data){
          	var str="";
          	var id = $.trim($("#loginid").text());
			var types=$("#types").val();
        	var writernik = $(".writernik").children("b").text();
        
			$.each(data,function(i,item){
				if(item.name==writernik){
					str+="<div class='reply_content_re_writer' replynum='"+item.replynum+"'>"
					if(item.profilepic==null||item.profilepic==""){
						str+="<img src='profile/default.png'>";
					}else{
						str+="<img src='profile/"+item.name+"/"+item.profilepic+"'>";
					}
					
					str+="<a href='#' style='margin-left:10px;' prtname='"+item.name+"'>"+" "+item.writeday+" "+item.name+"</a>";
					if(item.name==id||types=="관리자"){
						str+="<input class='p_rebtn_s_writer' id='del_btn' type='button' value='삭제' >";
						str+="<input class='p_rebtn_s_writer' id='up_btn' type='button' value='수정'>";
					}
					if(item.sortnum>=1){
					str+="<p class='p_reply_writer' style='width:250px;'>"+item.content+"</p>";
					str+="<p style='float:right;margin-left:70px;'><input class='p_rebtn_writer' id='re_btn' type='button' value='답글'></p>";
					}else{
					str+="<p class='p_reply_writer'>"+item.content+"</p>"
					str+="<p ><input class='p_rebtn_writer' id='re_btn' type='button' value='답글'></p>";
					}
					
					str+="<div replynum='"+item.replynum+"' writer='"+item.name+"'></div>"
				str+="</div>";
				}else{
					str+="<div class='reply_content_re' id='"+item.replynum+"' replynum='"+item.replynum+"'>"
						if(item.profilepic==null||item.profilepic==""){
							str+="<img src='profile/default.png'>";
						}else{
							str+="<img src='profile/"+item.name+"/"+item.profilepic+"'>";
						}
						str+="<a href='#' style='margin-right:10px;' prtname='"+item.name+"'>"+" "+item.name+" "+item.writeday+"</a>";
						if(item.name==id||types=="관리자"){
							str+="<input class='p_rebtn_s' id='up_btn' type='button' value='수정'>";
							str+="<input class='p_rebtn_s' id='del_btn' type='button' value='삭제'>";
						}
						if(item.sortnum>=1){
							str+="<p class='p_reply' style='width:250px;'>"+item.content+"</p>";
							str+="<p style='float:left;margin-left:50px;'><input class='p_rebtn' id='re_btn' type='button' value='답글'></p>";
							}else{
							str+="<p class='p_reply'>"+item.content+"</p>"
							str+="<p><input class='p_rebtn' id='re_btn' type='button' value='답글'></p>";
							}
						
						str+="<div replynum='"+item.replynum+"' writer='"+item.name+"'></div>"
					str+="</div>";
				}
			});
			
			$("#reply_content").html(str);
        }
     });
}

function getReplyNum(boardnum){
	$.ajax({
        type:"post", 
        url:"board/board_Detail/board_Detail_get_replynum.jsp", 
        dataType:"json",
        data:{
        	"boardnum":boardnum
        },
        async: false,
        success:function(data){
        	$("#replycnt").html("댓글 "+data.replynum+"개");
		}
	});
}

function getLikeNum(boardnum){
	$.ajax({
        type:"post", 
        url:"board/likes/getlikenum.jsp", 
        dataType:"html",
        data:{
        	"num":boardnum
        },
        async: false,
        success:function(data){
        	$(".likycnt").html("좋아요 "+$.trim(data)+"개");
		}
	});
}

function getLikeStatus(boardnum){
	var darkCheck = $("#darkCheck").val();
	$.ajax({
        type:"post", 
        url:"board/likes/getlikestatus.jsp", 
        dataType:"html",
        data:{
        	"num":boardnum
        },
        async: false,
        success:function(data){
        	var id = $.trim(data);
        	var loginid = $.trim($("#loginid").text());
        	if(id == loginid){
        		$(".likeyimg").attr("src","img/like/like02.png");
        	}else{
        		if(darkCheck=="1"){
        			$(".likeyimg").attr("src","img/like/like01_dark.png");
        		}else{
        			$(".likeyimg").attr("src","img/like/like01.png");
        		}
        	}
		}
	});
}