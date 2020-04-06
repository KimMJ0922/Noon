package imgfile;

import java.io.File;
import java.util.List;

import board.BoardImgDTO;

public class ImgFileDelete {
	//글쓰기에 임시 폴더 안에 있는 파일 삭제
	public void imgDelete(String path,String imgName) {
		File file = new File(path);
		File[] fileList = file.listFiles();
		int pathLength = path.length();
		if(fileList.length > 0){
		    for(int i=0; i < fileList.length; i++){
		    	int fileLength = fileList[i].toString().length();
		    	String fileSubString = fileList[i].toString().substring(pathLength+1, fileLength);
		    	
		    	if(fileSubString.equals(imgName)) {
		    		fileList[i].delete();
		    	}
		    }
		}
	}
	
	//게시글 삭제 했을 때 저장된 이미지 삭제
	public void boardImgDelete(String folderPath,List<String> list) {
		for(String fileName : list) {
			String path = folderPath+"\\"+fileName;
			System.out.println(path);
			File file = new File(path);
			file.delete();
		}
	}
	//글 수정 했을 때 수정하지 않은 사진은 지웠다 다시 넣는다.
	public void userFolderImgFileDelete(String prviewFolderPath, String userFolderPath) {
		File previewFoloder = new File(prviewFolderPath);
		File[] previewFileList = previewFoloder.listFiles();
		
		File userFoloder = new File(userFolderPath);
		File[] userFileList = userFoloder.listFiles();
		
		for(int i=0;i<previewFileList.length;i++) {
			String previewFileName = previewFileList[i].getName();
			for(int j=0;j<userFileList.length;j++) {
				String userFileName = userFileList[j].getName();
				
				if(previewFileName.equals(userFileName)) {
					userFileList[j].delete();
				}
			}
		}
	}
	
}
