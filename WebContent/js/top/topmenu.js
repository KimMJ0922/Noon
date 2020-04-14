$(function(){
	//임시 로그아웃 버튼
   $("#logout").click(function(){
      $.ajax({
         type: "post", 
         url: "login/logoutaction.jsp", 
         dataType: "html",
         async: false,
         success:function(data){
            location.replace("login/noonlogin.jsp");
         }
      });
   });
   
   
   $(".searchbtn, #searchimg").click(function(){
	   var text = $.trim($(this).siblings(".searchtag").val());
	   if(text.indexOf("#")==-1){
		   location.href="main.jsp?view=member/MyProfile.jsp&content=profile.jsp&id="+text;
	   }else{
		   var maxrow = 10;
		   var top = 0;
		   createMaxrowCookie(maxrow,top);
		   text = text.replace("#","%23");
		   location.href="main.jsp?view=board/boardlist.jsp&search="+text+"";
	   }
	   
   });
});

function createMaxrowCookie(maxrow,top){
	   $.ajax({
	      type: "post", 
	      url: "board/cookie/createmaxrowcookie.jsp", 
	      dataType: "html",
	      data:{
	         "maxrow":maxrow,
	         "top":top
	      },
	      async: false
	   });
	}