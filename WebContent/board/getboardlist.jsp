<%@page import="format.DateFormat"%>
<%@page import="board.*"%>
<%@page import="member.MemberDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	MemberDto mdto = (MemberDto)session.getAttribute("dto");
	String darkmode = (String)session.getAttribute("dark_check");
	String dark = "";
	if(darkmode.equals("1")){
		dark="dark-mode";
	}
	String minrow = request.getParameter("minrow");
	String maxrow = request.getParameter("maxrow");
	String sort = request.getParameter("sort");
	String search = request.getParameter("search");
	String id = request.getParameter("id");
	if(search==null){
		search="";
	}
	
	if(id==null){
		id = "";
	}
	
	if(!search.equals("")){
		search = search.substring(1,search.length());
		sort="";
	}else if(!id.equals("")){
		sort="";
	}
	//자바 생성자
	DateFormat df = new DateFormat();
	BoardDAO dao = new BoardDAO();
	BoardImgDAO bidao = new BoardImgDAO();
	BoardHashTagDAO bhtdao = new BoardHashTagDAO();
	BoardLikesDAO bldao = new BoardLikesDAO();
	
	//현재 로그인 된 세션의 아이디
	
	//각 게시글 요소
	List<BoardDTO> list = dao.getBoardList(minrow,maxrow,sort,search,id);
	List<BoardHashTagDTO> hashlist = bhtdao.getHashTags(minrow, maxrow, sort,search,id);
	List<BoardImgDTO> bilist = bidao.getImglist(minrow, maxrow, sort,search,id);
	List<String> bllist = bldao.getLikeList(minrow, maxrow, mdto.getId(), sort,search,id);
	
	if(maxrow.equals("10")&&list.size()==0){
%>
	<div class="nolist">
		작성한 게시물이 없습니다.
	</div>
<%
	}else{
%>
	<div class="profileModal"></div> 
<%
	for(BoardDTO bdto : list){
		//작성일 포맷
		String writeday = df.dateFormat(bdto.getWriteday());
		
		//프로필 이미지
		String profileImg = "profile/default.png";
		if(bdto.getProfilepic()!=null&&!bdto.getProfilepic().equals("")){
			profileImg = "profile/"+bdto.getId()+"/"+bdto.getProfilepic();
		}
%>
		<div id="<%=bdto.getNum() %>" class="container bordercontainer">
<%
			String board = "board";
			if(darkmode.equals("1")){
				board = "boarddark";
			}   
%>
			<div class="row boardform <%=board%>">
				<!-- 프로필, 아이디, 작성일, 메뉴 -->
<%
				String classText = "col-md-8 col-sm-8 col-xs-8 boardwriter transform "+dark;
				if(bdto.getId().equals(mdto.getId())){
					classText = "col-md-6 col-sm-6 col-xs-6 boardwriter transform "+dark;
				}
%>
				<div class="<%=classText%>">
					<img src="<%=profileImg %>" class="boardprofile">
					<a class="showProfile" style="cursor: pointer;"><%=bdto.getId() %></a>
				</div><!-- boardwriter 아이디, 프로필 끝-->
				
				<div class="col-md-4 col-sm-4 col-xs-4 boardwriter <%=dark%>">
					<span class="boardwriteday">
						<%=writeday %>
					</span><!-- boardwriteday 끝 -->
				</div><!-- boardwriter 작성일 끝 -->
<%
				if(classText.indexOf("6")!=-1){
					String menuImg="img/icon/menu_icon.png";
					if(darkmode.equals("1")){
						menuImg="img/icon/menu_icon_dark.png";
					}
%>
				<div class="col-md-2 col-sm-2 col-xs-2 menu <%=dark%>" >
					<button type="button" class="menubtn" id="menubtn"
					 		style="background:url('<%=menuImg%>');
								   background-repeat: no-repeat;
								   background-position: center center;
					 			  "
					></button>

					<div class="btns">
						<form class="updatefrm" method="post" action="main.jsp?view=board/updateboard.jsp">
							<button type="submit" class="updatebtn myboardbtn">수정</button>
							<input type="hidden" name="num" value="<%=bdto.getNum()%>">
						</form>
						<button type="button" class="delbtn myboardbtn" num="<%=bdto.getNum()%>">삭제</button>
					</div><!-- btns 끝 -->
				</div><!-- menu 끝 -->
<%
				}

				int cnt = 0;
				classText = "col-md-12 col-sm-12 col-xs-12 imglist "+dark;
				for(int i=0;i<bilist.size();i++){
					BoardImgDTO bidto = bilist.get(i);
					if(bdto.getNum().equals(bidto.getNum())){
						cnt++;
					}
				}
				
				String imgClass = "";
				if(cnt==0){
					classText = "col-md-12 col-sm-12 col-xs-12 noimglist "+dark;
				}
				
				if(cnt==1){
					imgClass = "imgone";
				}else if(cnt==2){
					imgClass = "imgtwo";
				}
%>
				<div class="<%=classText%>">
					<div class="imgs">
						<span class="boarddetail go" num="<%=bdto.getNum()%>">
<%
							cnt = 0;
							int ch = 0;
							for(int j=0;j<bilist.size();j++){
								BoardImgDTO bidto = bilist.get(j);
								if(bdto.getNum().equals(bidto.getNum())){
									ch++;
									if(ch>=4){
										cnt++;
									}else{
%>
										<img src="save/<%=bidto.getImgfile() %>" id="boardimg" class="<%=imgClass%>">

<%
									}													
								}
							}
							if(cnt>0){
%>
								<div class="moreimg">+<%=cnt %></div>
<%
							}
%>
						</span><!-- go 끝 -->
					</div><!-- imgs 끝 -->
				</div><!-- imglist 끝 -->
				<div class="col-md-12 col-sm-12 col-xs-12 boardcontent <%=dark%>">
					<span class="conpre">
<%
					String nullch = bdto.getContent().substring(0,1);
					if(nullch==null||nullch.equals("")){
%>
							...
							<button class="conmorebtn" idx="<%=bdto.getNum()%>">
								더보기
							</button>
<%
					}else{
						String content = bdto.getContent().trim();
						if(content.length()>=20){
							content = content.substring(0,20);
%>
							<%=content %>...
							<button class="conmorebtn" idx="<%=bdto.getNum()%>">
								더보기
							</button>
<%
						}else{
							String href = "main.jsp?view=board/board_Detail/board_Detail_form.jsp?num="+bdto.getNum();
%>
							<pre>
								<a href="<%=href%>">
									<%=content %>
								</a>
							</pre>
<%
						}
					}
%>
					</span><!-- conpre 끝 -->
				</div><!-- boardcontent 끝 -->
				<div class="col-md-12 col-sm-12 col-xs-12 boardlike_reply <%=dark%>">
<%					
					String defaultLikeIcon = "img/like/like01.png";
					String likying = "";
					if(darkmode.equals("1")){
						defaultLikeIcon = "img/like/like01_dark.png";
					}
					for(int k=0;k<bllist.size();k++){
						String num = bllist.get(k);
						if(num.equals(bdto.getNum())){
							defaultLikeIcon = "img/like/like02.png";
							likying = "likying";
							break;
						}
					}
%>
					<img class="likey <%=likying %>" src="<%=defaultLikeIcon%>" num="<%=bdto.getNum()%>">
					<span id="likecnt"><%=bdto.getLikes() %></span>
					<span>댓글 : <%=bdto.getReply() %></span>
				</div><!-- boardlike_reply 끝 -->
				
				<div class="col-md-12 col-sm-12 col-xs-12 hashtags <%=dark%>">
					<span class="hashtagspan">
<%
					cnt = 0;
					for(int l=0;l<hashlist.size();l++){
						BoardHashTagDTO bhdto = hashlist.get(l);
						if(bdto.getNum().equals(bhdto.getNum())){
							if(cnt>=10){
%>
								...
								<button class="hashtagmore" idx="<%=bdto.getNum()%>">
									더보기
								</button>
<%
								break;
							}else{
								cnt++;
%>
								<a class="hashtag">
									#<%=bhdto.getHashtag().trim() %>
								</a>
<%
							}
						}
					}
%>
					</span>
				</div><!-- hashtag 끝 -->
			</div><!-- row 끝 -->
		</div><!-- bordercontainer 끝 -->
<%
		}
	}
%>