<%@page import="member.MemberDto"%>
<%@page import="board.BoardHashTagDTO"%>
<%@page import="board.BoardHashTagDAO"%>
<%@page import="board.BoardImgDAO"%>
<%@page import="imgfile.ImgFolderCreate"%>
<%@page import="imgfile.MoveFile"%>
<%@page import="java.util.List"%>
<%@page import="imgfile.ImgFolderInSearch"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	MemberDto mdto = (MemberDto)session.getAttribute("dto");
	String id = mdto.getId();
	String createUserFolderPath = getServletContext().getRealPath("/save/"+id); //폴더 경로
	String prviewFolderPath = getServletContext().getRealPath("/preview/"+id); //폴더 경로
	//해당 유저의 아이디로 된 폴더명 생성(없으면 생성)
	ImgFolderCreate ifc = new ImgFolderCreate();
	ifc.createFolder(prviewFolderPath);
	ifc.createFolder(createUserFolderPath);
	
	//검색한 파일 리스트 넘기기
	MoveFile ptuf = new MoveFile();
	String ch="";
	List<String> fianlFileName = 
	ptuf.previewToUserFolder(prviewFolderPath,createUserFolderPath,ch);
	
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
		String hash = multi.getParameter("taghidden");	
		String content = multi.getParameter("content");
		dto.setContent(content);
		dto.setId(id);
		String num = dao.insertPosts(dto);
		//파일 이름 넣기
		if(fianlFileName.size()!=0){
			for(String fileName : fianlFileName){
				imgdao.insertImgFileName(num, id+"/"+fileName);
			}
		}
		//해시태그 넣기
		if(!hash.equals("")||hash!=null){
			String[] tag = hash.split(",");
			for(String hashtag : tag){
				if(!hashtag.equals("")||hashtag!=null){
					System.out.println(hashtag);
					hstgdto.setNum(num);
					hstgdto.setHashtag(hashtag);
					hstgdao.insertHashTag(hstgdto);
				}
			}
		}
		
%>
		<script type="text/javascript">
			location.replace("../main.jsp?main=board/boardlist.jsp");
		</script>
<%
	}catch(Exception e){
		System.out.println(e);
	}
%>