<%@page import="java.util.Calendar"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardLikesDTO"%>
<%@page import="board.BoardImgDTO"%>
<%@page import="board.BoardHashTagDTO"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDto"%>
<%@page import="board.BoardLikesDAO"%>
<%@page import="board.BoardHashTagDAO"%>
<%@page import="board.BoardImgDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String minrow = request.getParameter("minrow");
	String maxrow = request.getParameter("maxrow");
	String searchtext = request.getParameter("searchtext");
	searchtext = searchtext.substring(1,searchtext.length());
	
	BoardDAO dao = new BoardDAO();
	BoardImgDAO bidao = new BoardImgDAO();
	BoardHashTagDAO bhtdao = new BoardHashTagDAO();
	BoardLikesDAO bldao = new BoardLikesDAO();
	
	MemberDto mdto = (MemberDto)session.getAttribute("dto");
	List<BoardDTO> list = dao.getSearchBoardList(minrow,maxrow,searchtext);
	List<BoardHashTagDTO> hashlist = bhtdao.getSearchHashTags(minrow, maxrow, searchtext);
	List<BoardImgDTO> bilist = bidao.getSearchImglist(minrow, maxrow, searchtext);
	List<String> bllist = bldao.getSearchLikeList(minrow, maxrow, mdto.getId(), searchtext);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm",Locale.KOREA);
	
	for(int i=0;i<list.size();i++){
		BoardDTO dto = list.get(i);
%>
		<div id="<%=dto.getNum() %>" class="container bordercontainer">
			<div class="row board">
				<div <%if(dto.getId().equals(mdto.getId())){%>
						class="col-md-6 col-sm-6 col-xs-6 boardwriter"
					<%}else{%>
						class="col-md-8 col-sm-8 col-xs-8 boardwriter"
					<%} %>
				>
<%
				if(dto.getProfilepic()==null||dto.getProfilepic().equals("")){
%>
					<img src="profile/default.png" alt="프로필사진" class="boardprofile">
<%
				
				}else{
%>
					<img src="profile/<%=dto.getId() %>/<%=dto.getProfilepic() %>" alt="프로필사진" class="boardprofile">
<%
				}
%>
					<%=dto.getId() %>
				</div><!-- boardwriter끝 -->
				
				<div class="col-md-4 col-sm-4 col-xs-4 boardwriter">
					<span class="boardwriteday" style="float:right; margin:0 10px 0 0;">
<%
					Calendar c = Calendar.getInstance();
					long now = c.getTimeInMillis();
					
					String day = sdf.format(dto.getWriteday());
					
					long dateM = dto.getWriteday().getTime();
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
				</div><!-- boardwriter 시간 끝 -->
<%
				if(dto.getId().equals(mdto.getId())){
%>
				<div class="col-md-2 col-sm-2 col-xs-2 menu" style="text-align:center;">
					<button type="button" class="menubtn" style="border:none; background:none;">
						<img src="img/icon/menu_icon.png" id="menubtn" style="width:25px; height:25px;">
					</button>

					<div class="btns">
						<form class="updatefrm" method="post" action="main.jsp?view=board/updateboard.jsp">
							<button type="submit" class="updatebtn myboardbtn">수정</button>
							<input type="hidden" name="num" value="<%=dto.getNum()%>">
						</form>
						<button type="button" class="delbtn myboardbtn" num="<%=dto.getNum()%>">삭제</button>
					</div><!-- btns 끝 -->
				</div><!-- menu 끝 -->
<%
				}
				int cnt = 0; 
				for(int x=0;x<bilist.size();x++){
					BoardImgDTO bidto = bilist.get(x);
					if(bidto.getNum().equals(dto.getNum())){
						cnt++;
					}
				}
				if(cnt==0){
%>
				<div class='col-md-12 col-sm-12 col-xs-12 noimglist'>
<%
				}else{
%>
				<div class='col-md-12 col-sm-12 col-xs-12 imglist'>
<%
				}
%>
				
					<div class="imgs">
						<span class="boarddetail go" num="<%=dto.getNum()%>">
<%
						cnt = 0;
						int imgcnt = 0;
						String str = "";
						for(int j=0;j<bilist.size();j++){
							BoardImgDTO bidto = bilist.get(j);
							if(dto.getNum().equals(bidto.getNum())){							
								if(j>=3){
									cnt++;
								}else{
									str += "<img src='save/"+bidto.getImgfile()+"' id=boardimg class>";
								}
								imgcnt++;
							}
						}
						
						if(imgcnt==1){
							str.replace("class", "class='imgone'");
						}else if(imgcnt==2){
							str.replace("class", "class='imgtwo'");
						}else{
							str.replace("class", "");
						}
%>
						<%=str %>
<%
						if(cnt>=1){
%>
							<div class="moreimg">+<%=cnt %></div>
<%
						}
%>
						</span><!-- boarddetail 끝 -->
					</div><!-- imgs 끝 -->
				</div><!-- imglist -->
					
				<div class="col-md-12 col-sm-12 col-xs-12 boardcontent">
<%
					//본문의 길이가 10 초과
					if(dto.getContent().trim().length()>10){
						String con = dto.getContent().trim().substring(0,10)+"...";
						if(dto.getContent().substring(0,1).equals("")){
%>
							<span class="conpre">...<button class="conmorebtn" idx="<%=dto.getNum()%>">더보기</button></span>
<%
						}else{
%>
							<span class="conpre"><%=con %><button class="conmorebtn" idx="<%=dto.getNum()%>">더보기</button></span>
<%
						}
					}else{
%>
							<span class="boarddetail move" num="<%=dto.getNum()%>">
								<pre class="content"><%=dto.getContent() %></pre>
							</span>
<%
					}
%>
				</div><!-- boardcontent 끝 -->
			<div class="col-md-12 col-sm-12 col-xs-12 boardlike_reply">
<%
				str = "<img class='likey' src='img/like/like01.png' num="+dto.getNum()+">";
				str += "<span id='likecnt'>"+dto.getLikes()+"</span>";
				for(int q=0;q<bllist.size();q++){
					String num = bllist.get(q);
					if(num.equals(dto.getNum())){
						str = "<img class='likey' src='img/like/like02.png' num="+dto.getNum()+">";
						str += "<span id='likecnt'>"+dto.getLikes()+"</span>";
						break;
					}
				}
%>
					<%=str %>
					<span>댓글 : <%=dto.getReply() %></span>
				</div><!-- boardlike_reply 끝 -->
				
				<div class="col-md-12 col-sm-12 col-xs-12 hashtags">
					<span class="hashtagspan">
<%
					cnt=0;
					for(int k=0;k<hashlist.size();k++){
						BoardHashTagDTO bhdto = hashlist.get(k);
						if(dto.getNum().equals(bhdto.getNum())){
							if(cnt>=4){
%>
								...<button class="hashtagmore" idx="<%=dto.getNum()%>">더보기</button>
<%
								break;
							}else{
								cnt++;
%>
								<a href="#" class="hashtag">#<%=bhdto.getHashtag().trim() %></a>
<%
							}
						}
					}
%>
					
					</span>
				</div><!-- hashtags 끝 -->
			</div><!-- board끝 -->
		</div><!-- bordercontainer끝 -->
<%
	}
%>