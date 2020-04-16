package imgfile;

import java.io.File;

public class ImgFolderCreate {
	public void createFolder(String path) {
		File folder = new File(path);
		
		// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
		if (!folder.exists()) {
			try{
				folder.mkdir(); //폴더 생성합니다.
			    
		        } 
		        catch(Exception e){
			    e.getStackTrace();
			}        
		}
	}
}
