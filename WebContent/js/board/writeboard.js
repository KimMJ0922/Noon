$(function(){
	var hashlist = new Array();
	var cnt = 0;
	$(window).on('beforeunload', function(e) {
		return "변경사항이 저장되지 않을 수 있습니다.";
	});

	deletePreviewFolder();
	
	//파일 업로드 바꼈을 때
	$("#photo").change(function(){
		var form = $("form")[0];        
        var formData = new FormData(form);
		//파일 업로드 할 갯수
		var imgFileCount = $(this).get(0).files;
		//취소 눌렀을 때
		if(imgFileCount.length==0){
			return false;
		}
		var imgFileNames = "";
		//파일 이름 합치기
		for(var i=0;i<imgFileCount.length;i++){
			var imgFileName = $(this)[0].files[i].name;
			var lio = imgFileName.lastIndexOf(".");
			var extention = imgFileName.substring(lio,imgFileName.length).toLowerCase();
			if(extention==".png"||
			   extention==".jpg"||
			   extention==".gif"||
			   extention==".jpge"){
				imgFileNames += imgFileName+",";
			}else{
				alert("이미지 파일만 올려주세요");
				return false;
			}
			
		}
		imgFileNames = imgFileNames.substring(0,imgFileNames.length-1)

		imgUpload();
	});

	//삭제
	$(document).on("click",".delBtn",function(){
		var id = $(this).attr("id");
		
		$.ajax({
			type: "post",
			url: "board/img/deleteimg.jsp", 
			data:{
				"imgName":id
			},
			dataType: "json",
			success:function(data){
				imglist(data);
			}
		});
	});
	$(window).on("keydown","submit",function(e){
		if(e.keyCode==13){
			$(window).off("submit");
			return false;
		}
	});
	
	
	$("#write").click(function(){
		$(window).off("beforeunload");
		var text = $.trim($("#content").val());
		if(text==null||text==""){
			alert("내용을 입력해주세요");
			return false;
		}else{
			var form = $("form")[0];
			$("#hashtagtext").val("");
			$("#taghidden").val(hashlist);
			form.submit();
			
			return true;
		}
	});
	
	//텍스트에서 엔터 눌렀을 때 submit 막기
	$('input[type="text"]').keydown(function() {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
	});
	
	//해시태그
	$("#hashtagtext").keydown(function(e){
		if(e.keyCode==13||e.keyCode==32){
			var hash = $(this).val();
			if(hash==""||hash==null||hash==" "){
				return false;
			}
			
			for(var i=0;i<hashlist.length;i++){
				if(hash==hashlist[i]){
					alert("중복된 태그입니다.");
					$(this).val("");
					return false;
				}
			}
			$("#taglist").append("<div class='tag'>#"+hash+"<span class='glyphicon glyphicon-remove delhashbtn' idx='"+cnt+"'></span></div>");
			$(this).val("");
			hashlist[cnt] = hash;
			cnt++;
		}
	});
	
	//해시태그 삭제
	$(document).on("click",".delhashbtn",function(){
		var idx = $(this).attr("idx");
		hashlist[idx]=null;
		$(this).parent().remove();
	});
});	

function imgUpload(){
	$("#fileform").ajaxForm({
		type: "post", 
		url: "board/img/imguploadaction.jsp",
		processData: false,
		contentType: false,
		cache: false,
		async: false,	
		dataType: "json",
		success:function(data){
			imglist(data);
		},
		error:function(request,status,error){
			alert("이미지 용량이 너무 큽니다.");
		}
	});
	
	$("#fileform").submit();
}

function imglist(data){
	var str="";
	$.each(data,function(i,item){
		str += "<div class='imgSample' style='background-image:url("+item.imgURL+"); max-width:150px; background-size:150px 150px;' >";
			str += "<div class='delBtn' id='"+item.img+"'>"
				str += "<span class='glyphicon glyphicon-remove removebtn'></span>"
			str += "</div>";
		str += "</div>";
	});
	$("#imglist").html(str); 
	$("#photo").val("");

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