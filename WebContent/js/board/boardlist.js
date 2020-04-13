$(function(){
   //루트 경로
   var root = $("#root").val();
   var text = "#";
   //초기에 화면에 보여질 글 갯수
   var minrow = 0;
   var arry = getMaxrowCookie();
  
   var maxrow = parseInt(arry[0]);
   var sort = arry[1];
   //쿠키 삭제
   deleteMaxrowCookie();
   
   //임시폴더에 아이디 폴더 삭제
   deletePreviewFolder();
   
   //이미지 불러오기
   var img = getImgList(minrow,maxrow,sort,text);
   
   //해시태그 불러오기
   var hashtag = getHashTag(minrow,maxrow,sort,text);
  
   //좋아요 불러오기
   var likes = getLikeList(minrow,maxrow,sort,text);
   boardList(minrow,maxrow,img,hashtag,likes,sort,text);
   
   //글쓰는 페이지 이동
   $("#writebtn").click(function(){
	  createMaxrowCookie(maxrow,sort);
      location.href="main.jsp?view=board/writeboard.jsp";
   });
   
   //스크롤 내리면 자동으로 항목 불러오기
   $(window).on("scroll",function(){
      if($(window).scrollTop() == ($(document).height() - $(window).height())){
        minrow = maxrow;
        maxrow = maxrow+5;
        img = getImgList(minrow,maxrow,sort,text);
        hashtag = getHashTag(minrow,maxrow,sort,text);
        likes = getLikeList(minrow,maxrow,sort,text);
        boardList(minrow,maxrow,img,hashtag,likes,sort,text);
      }
   });
   
   
   
   //삭제 버튼
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
            	$("#list").html("");
            	img = getImgList(minrow,maxrow,sort,text);
            	hashtag = getHashTag(minrow,maxrow,sort,text);
            	likes = getLikeList(minrow,maxrow,sort,text);
            	boardList(minrow,maxrow,img,hashtag,likes,sort,text);
            }
         });
      }else{
         return false;
      }
   }); 
   //수정 버튼
   $(document).on("click",".updatebtn",function(){
      $("updatefrm").submit();      
   });
   
   
   //글 리스트에서 페이지 이동할 때 반드시 쿠키 만들 것
   //페이지 이동시 쿠키 만들기
   $(document).on("click",".move",function(){
      createMaxrowCookie(maxrow,sort);
   });
   
   
   //좋아요
   $(document).on("click",".likey",function(){
      var num = $(this).attr("num");
      var src = $(this).attr("src");
      var cnt = 0;
      if(src=="img/like/like02.png"){
         $(this).attr("src","img/like/like01.png");
         cnt = -1;
      }else{
         $(this).attr("src","img/like/like02.png");
         cnt = +1;
      }
      $.ajax({
         type: "post", 
         url: "board/likes/updatelike.jsp",
         dataType: "html",
         data:{
            "num":num,
            "likes":cnt
         },
         context: this,
         success:function(html){
            $(this).next("span").html(html);
         }
      });
      
   });

   //메뉴 버튼
   $(document).on("click",".menubtn",function(){
      var css = $(this).siblings(".btns").css("display");
      var posX = $(".menubtn").offset().left;
      var posY = $(".menubtn").offset().top;
      if(css=="none"){
    	 $(this).siblings(".btns").css("display","inline-block");
    	 $(this).siblings(".btns").css("position","relative");
      }else{
    	  $(this).siblings(".btns").css("display","none");
      }
   });
   
   //내용 더보기 버튼
   $(document).on("click",".conmorebtn",function(){
      var num = $(this).attr("idx");
      //해당 번호의 해시태그 가져오기
      var content = getNumContent(num);
      var str = "<span class='boarddetail' num='"+num+"'>";
      	str +="<pre class='content'>"+content+"</pre>";
      	str +="</span>"
      $(this).parent(".boardcontent").html(str);
   });
   
   
   //해시태그 더보기 버튼
   $(document).on("click",".hashtagmore",function(){
      var str = "";
      var num = $(this).attr("idx");
      //해당 번호의 해시태그 가져오기
      var hash = getNumHashTag(num);
      $.each(hash,function(i,item){
         str+="<a href='#' class='hashtag'>#"+item.hashtag+"</a>";
      });
      $(this).parent(".hashtags").html(str);
   });
   
   
   //알림
   $(document).on("click",".alam",function(){
      $.ajax({
         type: "post", 
         url: "history/gethistory.jsp", 
         dataType:"json",
         success:function(data){
            var str = "<ul>";
            $.each(data,function(i,item){
               str += "<li>";
               	//프로필 사진
               	if(item.profilepic==null||item.profilepic==""){
               		str += "<img src=profile/default.png>";
               	}else{
               		str += "<img src=profile/"+item.fromid+"/"+item.profilepic+">";
               	}
               	
               	//좋아요, 댓글이면 해당 게시물로 이동
               	if(item.action.indexOf("좋아요")>=0 || item.action.indexOf("댓글")>=0){
               		str += "<a class='move' href='main.jsp?view=board/board_Detail/board_Detail_form.jsp?num="+item.num+"'>";
               	}
               	
               	str += item.fromid+"님이 회원님의 게시물에 "+item.action+"<br>";
               	str += "</a>";
               	str += "<span class='actionday'>"+item.actionday+"</span>";
               str += "</li>";
            });
            str += "</ul>";
            
            $(".alamli").html(str);
         }
      });
   });
   
   $(document).on("click",".boarddetail",function(){
	   createMaxrowCookie(maxrow,sort);
	   var num = $(this).attr("num");
	   location.href="main.jsp?view=board/board_Detail/board_Detail_form.jsp?num="+num;
   });
  
   //좋아요 많은 순서대로
   $(".favorite").click(function(){
	   sort = "like";
	   minrow=0;
	   maxrow=10;
	   $(window).scrollTop(0);
	   text = "#";
	   $("#list").html("");
	   var img = getImgList(minrow,maxrow,sort,text);
	   var hashtag = getHashTag(minrow,maxrow,sort,text);
       var likes = getLikeList(minrow,maxrow,sort,text);
       boardList(minrow,maxrow,img,hashtag,likes,sort,text);
   });
   
   //최신순
   $(".showboard").click(function(){
	   sort = "";
	   minrow=0;
	   maxrow=10;
	   $(window).scrollTop(0);
	   text = "#";
	   $("#list").html("");
	   var img = getImgList(minrow,maxrow,sort,text);
       var hashtag = getHashTag(minrow,maxrow,sort,text);
       var likes = getLikeList(minrow,maxrow,sort,text);
       boardList(minrow,maxrow,img,hashtag,likes,sort,text);
   });
   
   //리모컨 아이콘 마우스 올렸을 때
   $(document).on("mouseover",".showboard, .favorite, .pagetopup, .alam, .setting",function(){
	   var idx = $(this).attr("idx");
	   $(this).css("cursor","pointer");
	   var windowwidth = $(window).width();
	   if(windowwidth>=766){
		   $(".remoconcomment:eq("+idx+")").css({ 
			   "display":"inline-block",
			   "position":"relative",
			   "top":"-50px",
			   "left":"-84px",
			   "margin":"0",
			   "padding":"0",
			   "float":"right",
			   "text-align":"center",
		   });
	   }
   });
   $(document).on("mouseout",".showboard, .favorite, .pagetopup, .alam, .setting",function(){
	   var idx = $(this).attr("idx");
	   var windowwidth = $(window).width();
	   if(windowwidth>=766){
		   $(".remoconcomment:eq("+idx+")").css({
			   "display":"none"
		   });
	   }
   });
   $(document).on("click",".hashtag, .searchbtn",function(){
	   var cl = $(this).attr("class");
	   if(cl=="hashtag"){
		   text = "#";
		   text = $.trim($(this).text());
	   }else if(cl == "searchbtn"){
		   text = "#";
		   text = $.trim($(".searchtag").val());
	   }
	   
	   if(text.length==0){
		   alert("검색할 내용을 입력해주세요");
	   }else{
		   //해시태그 검색
		   if(text.indexOf("#")!=-1){
			   text = text.substring(1,text.length);
			   $.ajax({
				      type: "post", 
				      url: "board/getboardlist.jsp",
				      data:{
				         "minrow":0,
				         "maxrow":10,
				         "sort":sort,
				         "text":text
				      },
				      dataType: "json",
				      async: false,
				      success:function(data){
				    	  
				    	  $(window).scrollTop(0);
				    	  $("#list").html("");
				    	  var img = getImgList(minrow,maxrow,sort,text);
				    	  var hashtag = getHashTag(minrow,maxrow,sort,text);
				    	  var likes = getLikeList(minrow,maxrow,sort,text);
				    	  boardList(minrow,maxrow,img,hashtag,likes,sort,text);
				      }
				   });
			   
		   }else{
			   
		   }
	   }
   });
});//$(function) 끝




//해당 로그인 된 아이디의 임시 폴더 삭제
function deletePreviewFolder(){
   $.ajax({
      type: "post", 
      url: "board/img/deletepreviewfolder.jsp",
      dataType: "html",
      success:function(data){
      }
   });
}
//글 목록
function boardList(minrow,maxrow,img,hashtag,likes,sort,text){
   $.ajax({
      type: "post", 
      url: "board/getboardlist.jsp",
      data:{
         "minrow":minrow,
         "maxrow":maxrow,
         "sort":sort,
         "text":text
      },
      dataType: "json",
      async: false,
      success:function(data){
         listform(data,img,hashtag,likes);
      }
   });

}


//이미지 가져오기
function getImgList(minrow,maxrow,sort,text){
   var imglist ="";
   $.ajax({
      type: "post", 
      url: "board/img/getimglist.jsp", 
      dataType: "json",
      data:{
         "minrow":minrow,
         "maxrow":maxrow,
         "sort":sort,
         "text":text
      },
      async: false,
      success:function(img){
         imglist = img;
      }
   });
   
   return imglist;
}


//해시태그 가져오기
function getHashTag(minrow,maxrow,sort,text){
   var hashtag ="";
   $.ajax({
      type: "post", 
      url: "board/hashtag/gethashtag.jsp", 
      dataType: "json",
      data:{
         "minrow":minrow,
         "maxrow":maxrow,
         "sort":sort,
         "text":text
      },
      async: false,
      success:function(hash){
         hashtag = hash;
      }
   });
   
   return hashtag;
}


//좋아요 가져오기
function getLikeList(minrow,maxrow,sort,text){
   var likelist ="";
   $.ajax({
      type: "post", 
      url: "board/likes/getlikelist.jsp", 
      dataType: "json",
      data:{
         "minrow":minrow,
         "maxrow":maxrow,
         "sort":sort,
         "text":text
      },
      async: false,
      success:function(likes){
    	  
    	  likelist = likes;
      }
   });
   return likelist;
}

//번호 해시태그 가져오기
function getNumHashTag(num){
   var hashtag ="";
   $.ajax({
      type: "post", 
      url: "board/hashtag/getnumhashtag.jsp", 
      dataType: "json",
      data:{
         "num":num
      },
      async: false,
      success:function(hash){
    	  hashtag = hash;
      }
   });
   
   return hashtag;
}

//번호 내용 가져오기
function getNumContent(num){
   var content ="";
   $.ajax({
      type: "post", 
      url: "board/getnumcontent.jsp", 
      dataType: "html",
      data:{
         "num":num
      },
      async: false,
      success:function(con){
         content = con;
      }
   });
   
   return content;
}


////////////////////////////////////////////
//태그 만들기
////////////////////////////////////////////
//해시태그 태그 만들기
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

//글 리스트 태그 만들기
function listform(data,img,hashtag,likes){
	var endcheck = true;
	var str="";
	//db에서 가져온 테이블이 존재 할 경우
	if(data.length!=0){
		$.each(data,function(i,item){
			var num =item.num;
			str +="<div id='"+item.num+"' class='container bordercontainer'>"
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
}

////////////////////////////////////////////
//쿠키 관련
////////////////////////////////////////////
//페이지 이동 시 현재 maxrow를 쿠키에 저장
function createMaxrowCookie(maxrow,sort){
   $.ajax({
      type: "post", 
      url: "board/cookie/createmaxrowcookie.jsp", 
      dataType: "html",
      data:{
         "maxrow":maxrow,
         "sort":sort
      },
      async: false,
      success:function(con){
      }
   });
}

//쿠키에 저장된 maxrow 가져오기
function getMaxrowCookie(){
   var arr = new Array();
   $.ajax({
      type: "post", 
      url: "board/cookie/getmaxrowcookie.jsp", 
      dataType: "json",
      async: false,
      success:function(data){
    	  arr[0] = data.maxrow;
    	  arr[1] = data.sort;
      }
   });
   
   return arr;
}


//일회용으로 쓴 쿠키 삭제
function deleteMaxrowCookie(){
   var scrollTop=0;
   $.ajax({
      type: "post", 
      url: "board/cookie/deletemaxrowcookie.jsp", 
      dataType: "html",
      async: false,
      success:function(scroll){
         
      }
   });
   
   return scrollTop;
}
