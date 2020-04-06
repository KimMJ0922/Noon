$(function(){
	var hashlist = new Array();
	var cnt = 0;
	$(window).on('beforeunload', function(e) {
		return "변경사항이 저장되지 않을 수 있습니다.";
	});
	deletePreviewFolder();
	var num = $("#num").val();
	//내용 가져오기
	getData(num);
	//이미지 가져오기
	var str = getImgFile(num);
	//해시태그 목록 가져오기
	hashlist = getHashList(num);
	cnt = hashlist.length;
	
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

		imgUpload(str);
	});
	$("#write").click(function(){
		var form = $("form")[0];
		$("#hashtagtext").val("");
		$("#taghidden").val(hashlist);
		form.submit();
		 $(window).off("beforeunload");
		 return true;
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
	
	//텍스트에서 엔터 눌렀을 때 submit 막기
	$('input[type="text"]').keydown(function() {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
	});
	
});//$(function)끝

//해당 로그인 된 아이디의 임시 폴더 삭제
function deletePreviewFolder(){
	$.ajax({
		type: "post", 
		url: "deletepreviewfolder.jsp",
		dataType: "html",
		success:function(data){
		}
	});
}

function getData(num){
	//내용
	$.ajax({
		type: "post", 
		url: "updateboarddata.jsp",
		data:{
			"num":num
		},
		async:false,
		dataType: "json",
		success:function(data){
			$.each(data,function(i,item){
				$("#content").html(item.content);
			});
		}
	});
}

function getImgFile(num){
	var str = "";
	var str2 = "";
	//이미지 파일
	$.ajax({
		type: "post", 
		url: "updateboardimgfilelist.jsp",
		data:{
			"num":num
		},
		async: false,
		dataType: "json",
		success:function(data){
			
			$.each(data,function(i,item){
				str += "<div class='imgSample' style='background-image:url("+item.file+"); background-size:cover;' >";
					str += "<div class='delBtn' id='"+item.img+"'>"
						str += "<span class='glyphicon glyphicon-remove removebtn'></span>"
					str += "</div>";
				str+="</div>";
			});
			$("#imglist").html(str); 
			
		}
	});
	return str;
}

function imgUpload(){
	$("#fileform").ajaxForm({
		type: "post", 
		url: "imguploadaction.jsp",
		processData: false,
		contentType: false,
		cache: false,
		async: false,
		dataType: "json",
		success:function(data){
			imglist(data);
		}
	});
	
	$("#fileform").submit();
}

function imglist(data){
	var str="";
	$.each(data,function(i,item){
		str += "<div class='imgSample' style='background-image:url("+item.imgURL+"); background-size:cover;' >";
			str += "<div class='delBtn' id='"+item.img+"'>"
				str += "<span class='glyphicon glyphicon-remove removebtn'></span>"
			str += "</div>";
		str += "</div>";
	});
	$("#imglist").html(str); 
	$("#photo").val("");

}

//이미지 삭제
$(document).on("click",".delBtn",function(){
	var id = $(this).attr("id");
	
	$.ajax({
		type: "post", 
		url: "deleteimg.jsp", 
		data:{
			"imgName":id
		},
		dataType: "json",
		success:function(data){
			imglist(data);
		}
	});
});

//해시태그 목록
function getHashList(num){
	var list = new Array();
	var cnt = 0;
	$.ajax({
		type: "post", 
		url: "getnumhashtag.jsp",
		data:{
			"num":num
		},
		async:false,
		dataType: "json",
		success:function(data){
			$.each(data,function(i,item){
				list[cnt] = item.hashtag;
				$("#taglist").append("<div class='tag'>#"+item.hashtag+"<span class='glyphicon glyphicon-remove delhashbtn' idx='"+cnt+"'></span></div>");
				cnt++;
			});
		}
	});
	
	return list;
}