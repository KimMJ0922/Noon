<%@page import="board.BoardLikesDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Calendar"%>
<%@page import="member.MemberDto"%>
<%@page import="board.BoardLikesDAO"%>
<%@page import="board.BoardHashTagDAO"%>
<%@page import="board.BoardImgDAO"%>
<%@page import="board.BoardImgDTO"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String minrow = request.getParameter("minrow");
	String maxrow = request.getParameter("maxrow");
	
	MemberDto mdto = (MemberDto)session.getAttribute("dto");
	String loginid = mdto.getId();
	BoardDAO bdao = new BoardDAO();
	BoardImgDAO bidao = new BoardImgDAO();
	BoardLikesDAO bldao = new BoardLikesDAO();
	BoardHashTagDAO bhtdao = new BoardHashTagDAO();
	
	List<BoardDTO> blist = bdao.getMemberBoardList(minrow,maxrow,id);
	if(blist.size()==0){
%>
	<div style="text-align:center; line-height:500px; font-size:30pt">
		작성한 게시글이 없습니다.
	</div>
<%
	}
	for(int i=0; i<blist.size();i++){
		BoardDTO bdto = blist.get(i);
%>
		<div class="board row" id="<%=bdto.getNum() %>">
			<!-- 로그인한 아이디와 글 작성 아이디가 일치하면 수정 버튼 나오기 -->	
			<div <%if(id.equals(loginid)){%>
					class="col-md-6 col-sm-6 col-xs-6 boardwriter sameid"
				 <%}else{%>
					class="col-md-8 col-sm-8 col-xs-8 boardwriter nosameid"
				 <%} %>
			>
				<!-- 프로필 이미지가 있을 경우 그 이미지, 없으면 기본 이미지 -->
				<img <%if(bdto.getProfilepic()==null){%>
						src="profile/default.png"
					 <%}else{%>
						 src="profile/<%=id %>/<%=bdto.getProfilepic() %>"
					 <%} %> alt="프로필사진" class="boardprofile">
					 
				<font style="text-align:left;"><%=bdto.getId() %></font>
			</div>
			<div class="col-md-4 col-sm-4 col-xs-4 boardwriter">
				<span class="boardwriteday" style="float:right; margin:0 10px 0 0;">
<%
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm",Locale.KOREA);
					Calendar c = Calendar.getInstance();
					long now = c.getTimeInMillis();
					
					String day = sdf.format(bdto.getWriteday());
					
					long dateM = bdto.getWriteday().getTime();
					long gap = now - dateM;

			        String ret = "";
			        gap = (long)(gap/1000);
			        long hour = gap/3600;
			        gap = gap%3600;
			        long min = gap/60;
			        long sec = gap%60;

			        if(hour > 24){
			            ret = day;
			        }
			        else if(hour > 0){
			            ret = hour+"시간 전";
			        }
			        else if(min > 0){
			            ret = min+"분 전";
			        }
			        else if(sec >= 0){
			            ret = sec+"초 전";
			        }
			        else{
			            ret = day;
			        }
%>
						<%=ret %>
					</span>
			</div>
<%
			if(id.equals(loginid)){
%>
			<div class="col-md-2 col-sm-2 col-xs-2 menu" style="text-align:center;">
				<button type="button" class="menubtn" style="border:none; background:none;">
					<img src="img/icon/menu_icon.png" id="menubtn" style="width:25px; height:25px;">
				</button>
			
		    	<div class="btns">
					<form class="updatefrm" method="post" action="main.jsp?view=board/updateboard.jsp">
						<button type="submit" class="updatebtn myboardbtn">수정</button>
						<input type="hidden" name="num" value="<%=bdto.getNum()%>">
					</form>
					<button type="button" class="delbtn myboardbtn" num="<%=bdto.getNum()%>">삭제</button>
		    	</div>
			</div>
<%
			}

			List<String> bilist = bidao.getNumImglist(bdto.getNum());
			if(bilist.size()!=0){
%>
				
				<div class='col-md-12 col-sm-12 col-xs-12 imglist'>
					<div class="imgs">
<%
					
					int cnt = 0;
					String imgclass= "";
					for(int j=0;j<bilist.size();j++){
						String filename = bilist.get(j);
						if(bilist.size()==1){
							imgclass = "imgone";
						}else if(bilist.size()==2){
							imgclass = "imgtwo";
						}
						if(j<=3){
%>
							<a href="main.jsp?view=board/board_Detail/board_Detail_form.jsp?num=<%=bdto.getNum()%>"><img src="save/<%=filename %>" id="boardimg" class="<%=imgclass%>"></a>
<%
					
						}else{
							cnt++;
						}
					}
					
					if(cnt>=1){
%>
						<div class="moreimg">+<%=cnt %></div>
<%
					}
%>
					
					</div><!-- imgs 끝 -->
				</div><!-- imglist 끝 -->
<%
			}
%>
			<div class="col-md-12 col-sm-12 col-xs-12 boardcontent">
<%
				//본문의 길이가 10 초과
				if(bdto.getContent().trim().length()>10){
					String con = bdto.getContent().trim().substring(0,10)+"...";
					if(bdto.getContent().substring(0,1).equals("")){
%>
						<span class="conpre">...<button class="conmorebtn" idx="<%=bdto.getNum()%>">더보기</button></span>
<%
					}else{
%>
						<span class="conpre"><%=con %><button class="conmorebtn" idx="<%=bdto.getNum()%>">더보기</button></span>
<%
					}
				}else{
%>
					<a href="main.jsp?view=board/board_Detail/board_Detail_form.jsp?num=<%=bdto.getNum()%>">
						<pre class="content"><%=bdto.getContent() %></pre>
					</a>
<%
				}
%>
			</div><!-- boardcontent 끝 -->
			<div class="col-md-12 col-sm-12 col-xs-12 boardlike_reply">
<%
				String sort="";
				List<String> bllist = bldao.getLikeList(minrow, maxrow, id, sort);
				String str = "<img class='likey' src='img/like/like01.png' num="+bdto.getNum()+">";
				str += "<span id='likecnt'>"+bdto.getLikes()+"</span>";
				for(int q=0;q<bllist.size();q++){
					String num = bllist.get(q);
					if(num.equals(bdto.getNum())){
						str = "<img class='likey' src='img/like/like02.png' num="+bdto.getNum()+">";
						str += "<span id='likecnt'>"+bdto.getLikes()+"</span>";
						break;
					}
				}
%>
					<%=str %>
				<span>댓글 : <%=bdto.getReply() %></span>
			</div><!-- boardlike_reply 끝 -->
			<div class="col-md-12 col-sm-12 col-xs-12 hashtags">
<%
				List<String> hashlist = bhtdao.getNumHashTag(bdto.getNum());
				str = "";
				for(int k=0;k<hashlist.size();k++){
					String hashtag = hashlist.get(k);
					if(k>=4){
						str += "...<button class='hashtagmore' idx='"+bdto.getNum()+"'>더보기</button>";
						break;
					}else{
						str +=	"<a href='#' class='hashtag'>#"+hashtag.trim()+"</a>";
					}
				}
%>
<span class="hashtagspan">
<%=str.trim() %>
</span>
			</div><!-- hashtags 끝 -->
		</div><!-- board 끝 -->
<%
	}
%>