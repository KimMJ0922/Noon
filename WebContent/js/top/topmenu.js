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
});