<%@page import="board.BoardHashTagDTO"%>
<%@page import="board.BoardHashTagDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="board.BoardImgDAO"%>
<%@page import="imgfile.ImgFileDelete"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="imgfile.MoveFile"%>
<%@page import="imgfile.ImgFolderInSearch"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
	String userFolderPath = getServletContext().getRealPath("/save/"+id); //폴더 경로
	String prviewFolderPath = getServletContext().getRealPath("/preview/"+id); //폴더 경로

	//해당 유저 폴더에 같은 이름의 이미지 삭제
	ImgFileDelete ifd = new ImgFileDelete();
	ifd.userFolderImgFileDelete(prviewFolderPath,userFolderPath);
	//삭제 후 저장
	MoveFile mf = new MoveFile();
	List<String> fianlNames = 
			mf.previewToUserFolder(prviewFolderPath,userFolderPath);
	
	int uploadSize = 1024*1024*5;
	String imgName = "";
	MultipartRequest multi = null;

	try{
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = new BoardDTO();
		BoardImgDAO imgdao = new BoardImgDAO();
		BoardHashTagDAO hstgdao = new BoardHashTagDAO();
		BoardHashTagDTO hstgdto = new BoardHashTagDTO();
		//의미 없는 것
		multi = new MultipartRequest(request, prviewFolderPath, uploadSize,"utf-8", new DefaultFileRenamePolicy());
		String num = multi.getParameter("num");
		String content = multi.getParameter("content");
		String hash = multi.getParameter("taghidden");
		
		dto.setNum(num);
		dto.setId(id);
		dto.setContent(content);
		dao.updateBoard(dto);
		
		imgdao.deleteImgBoard(num);
		for(String fileName : fianlNames){
			System.out.println(fileName);
			imgdao.insertImgFileName(num, id+"/"+fileName);
		}
		//해당 게시글의 해시태그 먼저 지우기
		hstgdao.deleteHashTag(num);
		//
		String[] tag = hash.split(",");
		for(String hashtag : tag){
			if(!hashtag.equals("")||hashtag!=null){
				System.out.println(hashtag);
				hstgdto.setNum(num);
				hstgdto.setHashtag(hashtag);
				hstgdao.insertHashTag(hstgdto);
			}
		}
%>
		<script type="text/javascript">
			location.replace("boardlist.jsp");
		</script>
<%
	}catch(Exception e){
		System.out.println(e);
	}
%>