<%@page import="member.MemberDto"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="imgfile.MoveFile"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardImgDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="imgfile.ImgFolderCreate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	BoardDAO bdao = new BoardDAO();
	String num = request.getParameter("num");
	MemberDto dto = (MemberDto)session.getAttribute("dto");
	String id = dto.getId();

	//임시 폴더 경로
	String previewFolderPath = getServletContext().getRealPath("/preview/"+id);
	String userFolderPath = getServletContext().getRealPath("/save/"+id);
	
	//임시 폴더 생성
	ImgFolderCreate ifc = new ImgFolderCreate();
	ifc.createFolder(previewFolderPath);
	
	//수정하는 게시물의 이미지 목록 db 검색
	BoardImgDAO dao = new BoardImgDAO();
	List<String> list = dao.getNumImglist(num);
	
	if(list.size()!=0){
		//파일 이름만 잘라서 다시 list에 넣기
		for(int i=0; i<list.size();i++){
			String fileName = list.get(i);
			fileName = fileName.substring(id.length()+1,fileName.length());
			list.set(i,fileName);
		}
		//검색한 파일을 저장된 폴더에서 임시 폴더로 옮기기
		MoveFile suftp = new MoveFile();
		suftp.userFolderToPreviewFolder(list,previewFolderPath,userFolderPath);
		
		JSONArray arr = new JSONArray();
		String url=request.getContextPath();
		for(int i=0; i<list.size();i++){
			String fileName = list.get(i);
			fileName = url+"/preview/"+id+"/"+fileName;
			JSONObject ob=new JSONObject();
			ob.put("file",fileName);
			arr.add(ob);
		}
%>
		<%=arr.toString() %>
<%
	}
%>