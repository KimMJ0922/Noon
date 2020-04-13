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


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

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
	
	//
	System.out.println("blist 크기 : "+blist.size());
	for(int i=0; i<blist.size();i++){
		BoardDTO bdto = blist.get(i);
%>
		<div class="board">
			<div id="<%=bdto.getNum() %>" class="container bordercontainer">
				<!-- 로그인한 아이디와 글 작성 아이디가 일치하면 수정 버튼 나오기 -->	
				<div <%if(id.equals(loginid)){%>
						class="col-md-6 col-sm-6 col-xs-6 boardwriter"
					 <%}else{%>
						class="col-md-8 col-sm-8 col-xs-8 boardwriter"
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
<%
				//수정, 삭제 메뉴
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
%>
			
			</div><!-- 프로필,아이디,메뉴 div 끝 -->
			<div class="imgs">
<%
				List<String> bilist = bidao.getNumImglist(bdto.getNum());
				for(int j=0;j<bilist.size();j++){
					String filename = bilist.get(j);
%>
				<img src="" id="boardimg">
<%
				}
%>
			
			</div>
		</div>
<%
	}
%>
</body>
</html>


<!-- //해시태그 태그 만들기
function hashTag(num,hashtag){
   var str = "";
   var cnt = 0;
   $.each(hashtag,function(i,item){
      if(num==item.num){
         if(cnt==4){
            str+="...<button type='button' class='hashtagmore' idx='"+item.num+"'>더보기</button>";
         }else if(cnt<4){
            str+="<a href='#' class='hashtag'>#"+item.hashtag+"</a>";
         }
         cnt++;
      }
   });
   
   return str;
}

//리스트에 넣을 이미지 태그 만들기
function imgTag(num,img){
	var cnt = 0;
	var imgcnt = 0;
	var lastfile = "";
	var str = "<div class='imgs'>";
		str+= "<span class='boarddetail' num='"+num+"'>";
	$.each(img,function(i,item){
		if(num==item.num){
			if(cnt<=2){
				str += "<img src='"+item.file+"' id='boardimg'>";
			}else if(cnt==3){
				str += "<img src='"+item.file+"' id='boardimg'>";
			}else{
				imgcnt++;
			}
			cnt++;
		}
	});
	if(cnt==1){
		str = str.replace("id='boardimg'","class='imgone'");
	}else if(cnt==2){
		str = str.replace("class='imgs'","class='imgtwo'");
	}
	if(cnt>4){
		str += "<div class='moreimg'>+"+imgcnt+"</div>";
	}
	str += "</span>"
	str += "</div>";
	//사진이 없으면 초기화
	if(cnt==0){
		str="";
	}
	return str;
}

//좋아요 초기 상태 태그 만들기
function likeTag(num,likes,likecnt){
	var str ="<img class='likey' src='img/like/like01.png' num='"+num+"'/><span>"+likecnt+"</span>";
	$.each(likes,function(i,item){
		if(item.num==num){
			str ="<img class='likey' src='img/like/like02.png' num='"+num+"'/><span>"+likecnt+"</span>";
		}
	});
	
	return str;
}

//로그인한 계정과 글을 쓴 계정이 일치하면 수정 삭제 버튼 보이기
function updateBtn(boardid,num){
	var str = "";
	var loginid = $.trim($("#loginid").text());
	if(boardid==loginid){
		str += "<div class='col-md-2 col-sm-2 col-xs-2 menu' style='text-align:center;'>";
			str +="<button type='button' class='menubtn' style='border:none; background:none;'>";
				str +="<img src='img/icon/menu_icon.png' id='menubtn' style='width:25px; height:25px;'>";
			str +="</button>";
			//수정 삭제 버튼
		    str += "<div class='btns'>";
		       str += "<form class='updatefrm' method='post' action='main.jsp?view=board/updateboard.jsp'>";
		          str += "<button type='submit' class='updatebtn myboardbtn'>수정</button>";
		          str += "<input type='hidden' name='num' value='"+num+"'>";
		       str += "</form>";
		       str += "<button type='button' class='delbtn myboardbtn' num='"+num+"'>삭제</button>";
		    str += "</div>";//수정 삭제 버튼 끝
		str += "</div>";
		
	}
 //btnlist 끝
 return str;
}


				str += "<div class='row board'>"
					var updateBtnStr = updateBtn(item.id, item.num);
					
					//로그인한 아이디와 글쓴 아이디가 다를 때
					if(updateBtnStr==""){
						str += "<div class='col-md-8 col-sm-8 col-xs-8 boardwriter'>";
							if(item.profilepic==""||item.profilepic==null){
								str +="<img src='profile/default.png' alt='프로필사진' class='boardprofile'>"
							}else{
								str +="<img src='profile/"+item.id+"/"+item.profilepic+"' alt='프로필사진' class='boardprofile'>"
							}
							str +="<font style='text-align:left;'>"+item.nickname+"</font>"
						str += "</div>";
							str += "<div class='col-md-4 col-sm-4 col-xs-4 boardwriter'>";
							str +="<span class='boardwriteday' style='float:right; margin-right:10px;'>"+item.writeday+"</span>"
						str += "</div>";//아이디 끝
					}else{
						str += "<div class='col-md-6 col-sm-6 col-xs-6 boardwriter'>";
							//프로필 사진이 없을 때
							if(item.profilepic==""||item.profilepic==null){
								str +="<img src='profile/default.png' alt='프로필사진' class='boardprofile'>"
							}else{
								str +="<img src='profile/"+item.id+"/"+item.profilepic+"' alt='프로필사진' class='boardprofile'>"
							}
							
							str +="<font style='text-align:left;'>"+item.nickname+"</font>"
					str += "</div>";
						str += "<div class='col-md-4 col-sm-4 col-xs-4 boardwriter'>";
							str +="<span class='boardwriteday' style='float:right; margin-right:10px;'>"+item.writeday+"</span>"
							str += "</div>";//아이디 끝
						str += updateBtnStr;
					}
					str +="<span id='boardnum' num='"+item.num+"'></span>"
					var imgstr = imgTag(num,img);
					if($.trim(imgstr)==""){
						str += "<div class='col-md-12 col-sm-12 col-xs-12 noimglist'>";
										
						str += "</div>";
					}else{
						str += "<div class='col-md-12 col-sm-12 col-xs-12 imglist'>";
							str += imgstr;
						str += "</div>";
					}
					
					//내용
					str += "<div class='col-md-12 col-sm-12 col-xs-12 boardcontent'>";
					var con = item.content;
					
					if($.trim(con.substring(0,1))==""){
						str +="...";
						str += "<button type='button' class='conmorebtn' idx='"+item.num+"'>더보기</button>";
					}else{
						if(con.length>10){
							str +=$.trim(con).substring(0,10)+"...";
							str += "<button type='button' class='conmorebtn' idx='"+item.num+"'>더보기</button>";
						}else{
							str +="<span class='boarddetail' num='"+item.num+"'>";
							str +="<pre>"+item.content+"</pre>"
							str += "</span>";
						}   
					}
   
					str += "</div>";//내용 끝
               
					//좋아요, 댓글 수 
					str += "<div class='col-md-12 col-sm-12 col-xs-12 boardlike_reply'>";
						str += likeTag(num,likes,item.likes);
						str +="<span>댓글 : "+item.reply+"</span>";
					str += "</div>";//좋아요, 댓글 수 끝

					//해쉬태그 
					str += "<div class='col-md-12 col-sm-12 col-xs-12 hashtags'>";
						str += hashTag(num,hashtag);
					str += "</div>";//해쉬태그 끝

				str += "</div>"//row 끝
			str += "</div>";//container 끝
		});
	}
	$("#list").append(str);
} -->