<%@page import="member.MemberFollowDao"%>
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
  <script type="text/javascript" src="js/board/board_detail.js"></script>
  <script type="text/javascript" src="js/member/followList.js"></script>
  <link rel="stylesheet" href="css/board/board_detail.css"/>
 <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet"> 
  <%
  	String dark="";
  	dark=(String)session.getAttribute("dark_check");
  	MemberDto mdto = (MemberDto)session.getAttribute("dto");
  	
  	if(dark.equals("0")){
  		
  	}else if(dark.equals("1")){
  	%>
  	  <link rel="stylesheet" href="css/dark/dark_detail.css" />
  	<%	
  	}
  	%>
<meta charset="UTF-8">

<title>상세 페이지</title>
<style type="text/css">
.searchtag{
	border-color: white;
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
	MemberFollowDao fdb = new MemberFollowDao();
  	boolean followed = fdb.followed(mdto.getId(), dto.getId());
	if(dto.getNum()==null||dto.getNum()==""){
%>
		<script>
			alert("삭제된 게시글입니다.");
			history.back();
		</script>
<%
	}else{
	//해시태그 불러오기
	BoardHashTagDAO Hdb= new BoardHashTagDAO();
	List<String> Hlist= Hdb.getNumHashTag(num);
	DateFormat df = new DateFormat();
	String day = df.dateFormat(dto.getWriteday());
	//이미지 url
	String url=request.getContextPath();
	String profileimg = "profile/default.png";
	String id = mdto.getId();
	
	if(dto.getProfilepic()!=null&&dto.getProfilepic()!=""){
		profileimg = "profile/"+dto.getId()+"/"+dto.getProfilepic();
	}
%>
<body>
<%	
	String imgs="";
	String thumbnail="";
	String hash="";
	//게시글에 사진이 1장이라도 있을 때
	
	
%>
	<!-- 권한 구분 -->
	<input type="hidden" id="types" value="<%=mdto.getType()%>"> 
	<div class="container detail_box">
		<div class="row">
			<div class="col-md-7 col-sm-7 col-xs-12"  style="padding:0;">
<%				//이미지가 하나라도 있을때
				if(Ilist.size()!=0){
					thumbnail=Ilist.get(0);
%>
					<div id="myCarousel" class="carousel slide" data-ride="carousel">
						<!-- Indicators -->
						<%if(Ilist.size()==1){ %>
						
						<%}else{ %>
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
								}// 케러샐 여러개 액티브 다음것들
							}// 케러샐 개수 여러개일때 첫번째 액티브
						}//케러셀 개수 표기 이미지가 1개일때
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
<%
						for(int i=0;i<Ilist.size();i++){
								if(i!=0){
%>
					<a class="left carousel-control" id="dark_np" href="#myCarousel" data-slide="prev" style="background-image: none;">
						<span class="glyphicon glyphicon-chevron-left"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="right carousel-control" id="dark_np" href="#myCarousel" data-slide="next" style="background-image: none;">
						<span class="glyphicon glyphicon-chevron-right"></span>
						<span class="sr-only">Next</span>
					</a>
<%
					}
						}

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
					<span style="margin-top:10px;" class="writernik"><b style="color:skyblue"><%=dto.getNickname() %></b>
					<%if(!mdto.getId().equals(dto.getId())){
						if(followed==true){ %>
							<a fromid='<%=mdto.getId() %>' toid='<%=dto.getId() %>' class='pro-btn following' id="fbtn">언팔로우</a>
						<%}else{ %>
							<a fromid='<%=mdto.getId() %>' toid='<%=dto.getId() %>' class='pro-btn follow' id="fbtn">팔로우</a>
						<%}
					}%>
					<%if(dto.getNickname().equals(id) || mdto.getType().equals("관리자")){ %>
						<div class="btns">
							<form class="updatefrm" method="post" action="main.jsp?view=board/updateboard.jsp">
								<button type="submit" class="updatebtn myboardbtn">글수정</button>
								<input type="hidden" name="num" value="<%=dto.getNum()%>">
							</form>
							<button type="button" style="margin-left:5px; "class="delbtn myboardbtn" num="<%=dto.getNum()%>">삭제</button>
						</div>
					<%}else{%>
					
					<%} %>
					</span>
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
<%
						String imgSrc = "img/like/like01.png";
						if(dark.equals("1")){
							imgSrc = "img/like/like01_dark.png";
						}
%>
					<p><img class="likeyimg" src="<%=imgSrc%>"></p><!--  아이콘 자리 -->
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
<%
	}
%>
<input type="hidden" id="darkCheck" value="<%=dark %>">
</body>
</html>