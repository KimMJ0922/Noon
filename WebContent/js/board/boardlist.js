$(function(){
   var text = "#";
   
   //초기에 화면에 보여질 글 갯수
   var arry = getMaxrowCookie();
   var minrow = 0;
   var maxrow = parseInt(arry[0]);
   var sort = arry[1];
   var top = arry[2];
   var searchText = $("#searchText").val();
   var getId = $("#getId").val();
   var logid = $("#loginid").children("a").text();
   if(searchText.length!=0){
	   $(".searchtag").val(searchText);
   }
   if(getId.length!=0&&logid != getId){
	   $(".searchtag").val(getId);
   }
   //쿠키 삭제
   deleteMaxrowCookie();
   
   //임시폴더에 아이디 폴더 삭제
   deletePreviewFolder();
   
   boardList(minrow,maxrow,sort,searchText,getId);
   $(document).scrollTop(top);
   //글쓰는 페이지 이동
   $("#writebtn").click(function(){
	  createMaxrowCookie(maxrow,sort);
      location.href="main.jsp?view=board/writeboard.jsp";
   });
   
	//스크롤 내리면 자동으로 항목 불러오기
	$(window).on("scroll",function(){
		var scrollTop = $(window).scrollTop();
		var docuHeight = $(document).height();
		var winHeight = $(window).height();
		if(scrollTop == (docuHeight-winHeight)){
			minrow = maxrow;
			maxrow = maxrow+5;
			boardList(minrow,maxrow,sort,searchText);
		}
	});

  
	$(".alam").click(function(){
		$(".alambox").toggle("fast");
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
            	boardList(minrow,maxrow,sort);
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
   $(document).on("click",".move, .go",function(){
	  var top = $(window).scrollTop();
      createMaxrowCookie(maxrow,sort,top);
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
            $(this).siblings("#likecnt").html(html);
         }
      });
      
   });

   //메뉴 버튼
   $(document).on("click",".menubtn",function(){
      var css = $(this).siblings(".btns").css("display");
      if(css=="none"){
    	 $(this).siblings(".btns").css("display","inline-block");
    	 $(this).siblings(".btns").css("position","relative");
    	 var thiscon = $(this).parent(".menu").parent(".board").parent(".bordercontainer");
    	 thiscon.siblings(".bordercontainer").children(".board").children(".menu").children(".btns").css("display","none");
      }else{
    	  $(this).siblings(".btns").css("display","none");
      }
   });
   
   //내용 더보기 버튼
   $(document).on("click",".conmorebtn",function(){
      var num = $(this).attr("idx");
      //해당 번호의 해시태그 가져오기
      var content = getNumContent(num);
      $(this).parent(".conpre").html(content);
   });
   
   
   //해시태그 더보기 버튼
   $(document).on("click",".hashtagmore",function(){
      var num = $(this).attr("idx");
      //해당 번호의 해시태그 가져오기
      var hashtag = getNumHashTag(num);
      $(this).parent(".hashtagspan").html(hashtag);
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
	   searchText="";
	   $(".searchtag").val("");
	   minrow=0;
	   maxrow=10;
	   $(window).scrollTop(0);

	   $("#list").html("");
	   boardList(minrow,maxrow,sort);
   });
   
   //최신순
   $(".showboard").click(function(){
	   sort = "";
	   searchText="";
	   $(".searchtag").val("");
	   minrow=0;
	   maxrow=10;
	   $(window).scrollTop(0);
	   $("#list").html("");
	   boardList(minrow,maxrow,sort);
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
	$(document).on("click","a.hashtag",function(){
		var hash = $.trim($(this).text());
		hash = hash.replace("#","%23");
		location.href="main.jsp?view=board/boardlist.jsp&search="+hash;
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
function boardList(minrow,maxrow,sort,searchText,getId){
	$.ajax({
      type: "post", 
      url: "board/getboardlist.jsp",
      data:{
         "minrow":minrow,
         "maxrow":maxrow,
         "sort":sort,
         "search":searchText,
         "id":getId
      },
      dataType: "html",
      async: false,
      success:function(data){
         $("#list").append($.trim(data));
      }
   });

}


//번호 해시태그 가져오기
function getNumHashTag(num){
   var hashtag ="";
   $.ajax({
      type: "post", 
      url: "board/hashtag/gethashtag.jsp", 
      dataType: "html",
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
//쿠키 관련
////////////////////////////////////////////
//페이지 이동 시 현재 maxrow를 쿠키에 저장
function createMaxrowCookie(maxrow,sort,top){
   $.ajax({
      type: "post", 
      url: "board/cookie/createmaxrowcookie.jsp", 
      dataType: "html",
      data:{
         "maxrow":maxrow,
         "sort":sort,
         "top":top
      },
      async: false
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
    	  arr[2] = data.top;
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
