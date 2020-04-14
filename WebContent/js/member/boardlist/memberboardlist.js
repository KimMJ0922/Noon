$(function(){
	var minrow = 0;
	var maxrow = 10;
	memberBoardList(minrow, maxrow);
	
	//임시폴더에 아이디 폴더 삭제
	deletePreviewFolder();
	
	$(window).on("scroll",function(){
      if($(window).scrollTop() == ($(document).height() - $(window).height())){
        minrow = maxrow;
        maxrow = maxrow+5;
        memberBoardList(minrow, maxrow);
      }
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
		var con = getNumContent(num);
		$(this).parent("span").html(con);
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
      $(this).parent(".hashtagspan").html(str);
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
            	memberBoardList(minrow, maxrow);
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
        	 memberBoardList(minrow, maxrow);
         }
      });
      
   });
   //검색
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
		   var sort="";
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
				    	  location.href="main.jsp?view=board/boardlist.jsp&text=";
				      }
				   });
			   
		   }else{
			   
		   }
	   }
   });
});
//회원이 작성한 글
function memberBoardList(minrow, maxrow){
	var text = $.trim($(".searchtag").val());
	var loginid = $.trim($("#loginid").text());
	
	if(text.indexOf("#")==-1 && text.length==0){
		$("#getId").val(loginid);
	}else if(text.indexOf("#")==-1 && text.length>0){
		$("#getId").val(text);
	}else{
		$("#getId").val(loginid);
	}
	
	id = $("#getId").val();
	$.ajax({
        type: "post", 
        url: "board/memberboard/getmemberboardlist.jsp", 
        dataType: "html",
        async: false,
        data:{
           "id":id,
           "minrow":minrow,
           "maxrow":maxrow
        },
        success:function(data){
        	$("#memberboardlist").append(data);
        }
     });
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
    	  content += "<a href='main.jsp?view=board/board_Detail/board_Detail_form.jsp?num="+num+"'><pre class='content'>"+con+"</pre></a>";
      }
   });
   
   return content;
}

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