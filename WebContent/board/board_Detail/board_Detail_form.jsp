<%@page import="format.DateFormat"%>
<%@page import="member.MemberDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardHashTagDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardImgDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <%
  	String dark="";
  	dark=(String)session.getAttribute("dark_check");
  	
  	if(dark.equals("0")){
  		
  	}else if(dark.equals("1")){
  	%>
  	  <link rel="stylesheet" href="board/board_Detail/dark_detail.css" />
  	<%	
  	}
  	%>
<meta charset="UTF-8">

<title>상세 페이지</title>

<style>

  .carousel {
 	width:680px;
 	max-height:638px;
 	background: gary;
	}
	
.reboard{
height:600px;
}
.detail_content{
	margin-top:10px;
	padding-top:10px;
	border-top:1px solid gray;
}
#myCarousel>ol>li{
	border:1px solid black;
}
#myCarousel>ol>li.active{
	background: black;
}
.img_none_box{
width: 475px;
height:600px;
/* background:rgba(128,128,128,0.2); */
}

.img_none{
width: 475px;
height:70px;
color:white;
padding-top:10px;
line-height: 3;
}
.img_none span{
margin-left:10px;
}
.img_none>img{
width: 50px;
height:50px;
border-radius: 30px;
margin-left:10px;
}

.img_on{
width:475px;
height:50px;
color:white;
padding-top:10px;
line-height: 3;
}
.img_on span{
margin-left:10px;
}
.img_on>img{
width: 50px;
height:50px;
border-radius: 30px;
margin-left:10px;
}
#reply_content{
	width:470px;
	height:420px;
	margin-left:10px;
	overflow: auto;
	border-bottom: 1px solid rgba(128,128,128,0.5);
}
.reply_content_re{
	width:410px;
	margin-left:10px;
	margin-top:20px;
	margin-bottom:20px;	
	float:left;
}
.reply_content_re:after{
	clear: both;
	display:block;
	margin:0;
	padding:0;
	
}

.reply_content_re>img{
	width:40px;
	height:40px;
	border-radius: 30px;
}
.reply_content_re>a{
	color:black;
}

.reply_content_re_writer{
	width:410px;
	margin-right:10px;
	margin-top:20px;
	float:right;
	margin-bottom:20px;	
}
.reply_content_re_writer>img{
	width:40px;
	height:40px;
	border-radius: 30px;
	float:right;
}
.reply_content_re_writer>a{
	color:black;
	float:right;
}

.reply_content_re_writer:after{
	clear: both;
	display:block;
	margin:0;
	padding:0;
}
#re_board_text{
	width:390px;
	border:none;
	border:1px solid rgba(128,128,128,0.5);
	right:85px;
	bottom:0px;
	position: absolute;
	height: 70px;
	resize: none;
}
#re_send{
	right:7px;
	bottom:0px;
	position: absolute;
	width:80px;
	height: 70px;
}
.p_reply{
	border-radius:5px;
	width:350px;
	margin-left:50px;
	padding-left:5px;
	min-height:45px;
	background: #f7f7f7;
}
.p_reply_writer{
	border-radius:5px;
	width:350px;
	margin-right:15px;
	margin-top:10px;
	min-height:45px;
	background: #f7f7f7;
	float:right;
}
.p_rebtn{
border:none;
background:none;
float:right;
font-size:12px;
}
.p_rebtn_writer{
border:none;
background:none;
float:left;
font-size:12px;

}
.p_rebtn_s{
border:none;
background:none;
font-size:12px;
}
.p_rebtn_s_writer{
border:none;
background:none;
font-size:12px;
float:right;
}
.re_reply_textarea{
	width:360px;
	height:50px;
	resize:none;
	background: #f7f7f7;
	border-radius: 5px;
}

.bar{
background-image:none;
background:none;
}
.re_re{
	width:360px;
	height:100px;
	resize:none;
	background: #f7f7f7;
	border-radius: 5px;
	display: block;
}
.likeyimg{
	width: 30px;
    height: 30px;
    cursor: pointer;
    margin-right: 10px;
}
  </style>
<script type="text/javascript">
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
		if(src == "img/like/like01.png"){
			$(this).attr("src","img/like/like02.png");
			cnt++;
		}else{
			$(this).attr("src","img/like/like01.png");
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
					if(item.name==id){
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
						if(item.name==id){
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
        		$(".likeyimg").attr("src","img/like/like01.png");
        	}
		}
	});
}
  </script>
</head>
<%	
	String num=request.getParameter("num");
	//이미지 불러오기
	BoardImgDAO Idb=new BoardImgDAO();
	List<String> Ilist= Idb.getNumImglist(num);
	
	//회원 글 불러오기
	BoardDAO Bdb=new BoardDAO();
	BoardDTO dto=Bdb.getBoard(num);
	
	if(dto.getNum()==null||dto.getNum()==""){
%>
		<script>
			alert("삭제된 게시글입니다.");
			history.back();
		</script>
<%
	}
	//해시태그 불러오기
	BoardHashTagDAO Hdb= new BoardHashTagDAO();
	List<String> Hlist= Hdb.getNumHashTag(num);
	DateFormat df = new DateFormat();
	String day = df.dateFormat(dto.getWriteday());
	//이미지 url
	String url=request.getContextPath();

	String profileimg = "profile/default.png";
	MemberDto mdto = (MemberDto)session.getAttribute("dto");
	String id = mdto.getId();
	if(dto.getProfilepic()!=null&&dto.getProfilepic()!=""){
		profileimg = "profile/"+id+"/"+dto.getProfilepic();
	}
%>
<body>
<%	
	String imgs="";
	String thumbnail="";
	String hash="";
	//게시글에 사진이 1장이라도 있을 때
	
	
%>
	<div class="container detail_box">
		<div class="row">
			<div class="col-md-7 col-sm-7 col-xs-12"  style="padding:0;">
<%
				if(Ilist.size()!=0){
					thumbnail=Ilist.get(0);
%>
					<div id="myCarousel" class="carousel slide" data-ride="carousel">
						<!-- Indicators -->
	    				<ol class="carousel-indicators">
<%
							for(int i=0;i<Ilist.size();i++){
								if(i==0){
%>
									<li data-target="#myCarousel" data-slide-to="<%=i %>" class="active" ></li>
<%
								}else{
%>
									<li data-target="#myCarousel" data-slide-to="<%=i%>"></li>
<%
								}
							}
%>
		   				</ol>
		   				<div class="carousel-inner">
		   					<div class="item active">
		   						<img id="modal_img" src="<%=url %>/save/<%=thumbnail %>" alt="Los Angeles" style="width:680px;min-height:638px;max-height:638px;" data-toggle="modal" data-target="#modal">
							
		   					</div><!-- class="item active" 끝 -->
<%
							for(int i=1;i<Ilist.size();i++){
								imgs=Ilist.get(i);
%>
								<div class="item">
									<img id="modal_img" src="<%=url %>/save/<%=imgs %>" alt="Chicago" style="width:680px;min-height:638px;max-height:638px;" data-toggle="modal" data-target="#modal">
								
								</div><!-- class="item"끝  -->	
<%
							}
%>		   					
		   				</div><!-- class="carousel-inner" 끝 -->
					</div><!-- class="carousel slide" 끝 -->
					
					<!-- Left and right controls -->
					<a class="left carousel-control" id="dark_np" href="#myCarousel" data-slide="prev" style="background-image: none;">
						<span class="glyphicon glyphicon-chevron-left"></span>
						<span class="sr-only">Previous</span>
					</a>
					
					<a class="right carousel-control" id="dark_np" href="#myCarousel" data-slide="next" style="background-image: none;">
						<span class="glyphicon glyphicon-chevron-right"></span>
						<span class="sr-only">Next</span>
					</a>
<%
				//해당 게시글에 사진이 없을 때
				}else{
%>					
				<div class="img_none_box">
					<div class="img_none">

					<img src="<%=profileimg %>" style="float:left">
					<span><b style="color:skyblue"><%=dto.getNickname() %></b></span>
					<span style="display:inline;margin-left:70px; color:gray;"><%=day %></span>
					</div>
					
					<pre style="border:none; background: none;white-space: pre-wrap;
  					word-break: break-all;word-wrap:break-word;text-align: left;"><%=dto.getContent() %></pre>
					
					</div>
<%
				}
%>
			</div><!-- class="col-md-7 col-sm-7" 끝 -->
			<div class="col-md-5 col-sm-5 col-xs-12" style="padding:0;"><!-- 댓글창 -->
				<div class="reboard">
					<div class="img_on">
					<img src="<%=profileimg %>" style="float:left">
					<span style="margin-top:10px;" class="writernik"><b style="color:skyblue"><%=dto.getNickname() %></b><a href=""> 팔로우</a></span>
					<%if(dto.getNickname().equals(id)){ %>
					<b style="color:blue;float:right"><a href="#">글수정</a> / <a a href="#">글삭제</a></b>
					<%}else{%>
					
					<%} %>
					</div>
					<hr>
					<div id="reply_content">
					
					
					</div>
					<textarea name="re_board_text" id="re_board_text" num="<%=num %>"
					 style="" placeholder="  댓글을 입력하세요"></textarea>
					 <input type="button" name="re_send" id="re_send" class="btn btn-defualt" value="전송">
					 
				</div>
			</div><!-- class="col-md-5 col-sm-5"끝 -->
		</div><!-- class="row" 끝 -->
	</div><!-- class="container" 끝 -->
	
	<!-- 본문 -->
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12" style="padding:0;">
				<div class="detail_content">
					<p><img class="likeyimg" src="img/like/like01.png"></p><!--  아이콘 자리 -->
					<p><b class="likycnt">좋아요 0개</b></p>
					<p><b id="replycnt">댓글 0개</b></p>
					<!-- 글 내용 -->
					<%
						if(Ilist.size()==0){
					%>		
					<%
						}else{
					%>
					<b><%=dto.getContent()%></b>
					<%
						}
					%>
					<p style="margin-top:10px;"><b>
						<%
							for(int i=0;i<Hlist.size();i++){
								hash=Hlist.get(i);
						%>
								<a href="" >#<%=hash %></a>
						<%
							}
						%>
					</b></p>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="modal" id="modal">
			<div class="modal-dialog" >
				<img id="atfer_modal_img" src="" style="border:none; width:800px;height:700px; margin-top:150px; margin-left:-150px;">
			</div>
		 </div>
	</div>
</body>
</html>