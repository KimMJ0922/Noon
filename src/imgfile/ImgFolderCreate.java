package imgfile;

import java.io.File;

public class ImgFolderCreate {
	public void createFolder(String path) {
		File folder = new File(path);
		
		// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
		if (!folder.exists()) {
			try{
				folder.mkdir(); //폴더 생성합니다.
			    System.out.println("폴더가 생성되었습니다.");
		        } 
		        catch(Exception e){
			    e.getStackTrace();
			}        
		}else {
			System.out.println("이미 폴더가 생성되어 있습니다.");
		}
	}
}
