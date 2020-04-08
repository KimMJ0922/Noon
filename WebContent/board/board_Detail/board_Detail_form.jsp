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
 <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>상세 페이지</title>

<style>
  .carousel {
 	width:680px;
 	height:600px;
 	background: gary;
	}
	
.reboard{
background:red;
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
width: 670px;
height:600px;
/* background:rgba(128,128,128,0.2); */
}
.img_none{

width: 670px;
height:70px;
color:white;
padding-top:10px;
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
  </style>
</head>
<%	
	String num=request.getParameter("num");
	//이미지 불러오기
	BoardImgDAO Idb=new BoardImgDAO();
	List<String> Ilist= Idb.getNumImglist(num);
	
	//회원 글 불러오기
	BoardDAO Bdb=new BoardDAO();
	BoardDTO dto=Bdb.getBoard(num);
	
	//해시태그 불러오기
	BoardHashTagDAO Hdb= new BoardHashTagDAO();
	List<String> Hlist= Hdb.getNumHashTag(num);
	//이미지 url
	String url=request.getContextPath();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>
<body>
<%	
	String imgs="";
	String thumbnail="";
	String hash="";
	//게시글에 사진이 1장이라도 있을 때
	
	
%>
	<div class="container">
		<div class="row">
			<div class="col-md-7 col-sm-7" style="padding:0;">
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
									<li data-target="#myCarousel" data-slide-to="<%=i %>" class="active"></li>
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
		   						<img src="<%=url %>/save/<%=thumbnail %>" alt="Los Angeles" style="width:680px;height:520px;">
							
		   					</div><!-- class="item active" 끝 -->
<%
							for(int i=1;i<Ilist.size();i++){
								imgs=Ilist.get(i);
%>
								<div class="item">
									<img src="<%=url %>/save/<%=imgs %>" alt="Chicago" style="width:680px;height:520px;">
								
								</div><!-- class="item"끝  -->	
<%
							}
%>		   					
		   				</div><!-- class="carousel-inner" 끝 -->
					</div><!-- class="carousel slide" 끝 -->
					
					<!-- Left and right controls -->
					<a class="left carousel-control" href="#myCarousel" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left"></span>
						<span class="sr-only">Previous</span>
					</a>
					
					<a class="right carousel-control" href="#myCarousel" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right"></span>
						<span class="sr-only">Next</span>
					</a>
<%
				//해당 게시글에 사진이 없을 때
				}else{
%>					
				<div class="img_none_box">
					<div class="img_none">
					<img src="<%=url %>/save/ddd/iu.jpg" style="float:left">
					<span><b style="color:skyblue"><%=dto.getNickname() %></b></span>
					<span style="display:block;margin-left:70px; color:gray;"><%=sdf.format(dto.getWriteday()) %></span>
					</div>
					
					<pre style="border:none; background: none;white-space: pre-wrap;
   word-break: break-all;
   word-wrap:break-word;"><%=dto.getContent() %></pre>
					
					</div>
<%
				}
%>
			</div><!-- class="col-md-7 col-sm-7" 끝 -->
			<div class="col-md-5 col-sm-5" style="padding:0;"><!-- 댓글창 -->
				<div class="reboard">
				
				</div>
			</div><!-- class="col-md-5 col-sm-5"끝 -->
		</div><!-- class="row" 끝 -->
	</div><!-- class="container" 끝 -->
	
	<!-- 본문 -->
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12" style="padding:0;">
				<div class="detail_content">
					<p>이미지 넣으면됨</p><!--  아이콘 자리 -->
					<p><b>좋아요 0개</b></p>
					<!-- 글 내용 -->
					<b><%=dto.getContent()%></b>
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
</body>
</html>