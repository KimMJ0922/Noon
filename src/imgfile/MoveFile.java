package imgfile;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Vector;

public class MoveFile {
	public List<String> previewToUserFolder(String prviewFolderPath,String userFolderPath) {
		sameFileNameDelete(prviewFolderPath,userFolderPath);
		//이름 중복 체크
		fileNameChack(prviewFolderPath,userFolderPath);
		File previewFolder = new File(prviewFolderPath);
		File[] previewFileList = previewFolder.listFiles();
		List<String> fileNames = new Vector<String>();
		//파일 옮기기
		for(int i=0;i<previewFileList.length;i++) {
			String fileName = previewFileList[i].getName();
			File previewFile = new File(prviewFolderPath+"/"+fileName);
			String movePath = userFolderPath+"/"+fileName;
			previewFile.renameTo(new File(movePath));
			//db에 저장할 아이디/파일명
			fileNames.add(fileName);
		}
		return fileNames;
	}
	
	
	public void userFolderToPreviewFolder(List<String> list, String previewPath,String userPath) {
		//파일 복사
		for(String fileName : list) {
			
			//파일객체생성
	        File oriFile = new File(userPath+"/"+fileName);
	        //복사파일객체생성
	        File copyFile = new File(previewPath+"/"+fileName);
	        
	        try {
	            
	            FileInputStream fis = new FileInputStream(oriFile); //읽을파일
	            FileOutputStream fos = new FileOutputStream(copyFile); //복사할파일
	            int fileByte = 0; 
	            // fis.read()가 -1 이면 파일을 다 읽은것
	            while((fileByte = fis.read()) != -1) {
	                fos.write(fileByte);
	            }
	            //자원사용종료
	            fis.close();
	            fos.close();
	            
	        } catch (FileNotFoundException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void previewFolderDelete(String prviewFolderPath) {
		//임시 폴더 삭제
		File folder = new File(prviewFolderPath);
		File[] filelist = folder.listFiles();
		if (folder.exists()) {
			if(filelist.length!=0) {
				for (int i = 0; i < filelist.length; i++) {
					filelist[i].delete(); //파일 삭제 
				}
			}
			try{
				folder.delete(); //폴더 삭제
				System.out.println(prviewFolderPath);
			    System.out.println(folder.getName()+" 폴더 삭제");
		    }catch(Exception e){
			    e.getStackTrace();
			}        
		}
	}
	
	public void fileNameChack(String prviewFolderPath,String userFolderPath) {
		char[] ranch = {'a','b','c','d','e','f','g','h','i','j','k',
				'l','m','n','o','p','q','r','s','t','u','v',
				'w','x','y','0','1','2','3','4','5','6','7',
				'8','9'};
		File previewFolder = new File(prviewFolderPath);
		File[] previewFileList = previewFolder.listFiles(); 
		
		//파일명 중복인것 바꾸기
		for(int i=0;i<previewFileList.length;i++) {
			previewFileList = previewFolder.listFiles();
			String previewFileName = previewFileList[i].getName();
			
			//동일 디렉토리 내에 이름 중복 확인
			for(int j=0; j<previewFileList.length;j++) {
				if(i!=j) {
					String previewFileName2 = previewFileList[j].getName();
					
					//파일 이름이 같다면
					if(previewFileName.equals(previewFileName2)) {
						String fileName = previewFileName.substring(0,previewFileName.lastIndexOf("."));
						String extention = previewFileName.substring(previewFileName.lastIndexOf("."),previewFileName.length());
						//배열의 랜덤 인덱스
						double ran = Math.random()*34;
						int ranf = (int)ran;
						//현재 파일
						File file = new File(prviewFolderPath+"/"+previewFileName);
						//현재 파일의 이름을 바꾸기 지정
						File fileRename = new File(prviewFolderPath+"/"+ranch[ranf]+extention);
						//파일이 있을 때
						if(file.exists()) {
							System.out.println("파일 있음");
							//이름 바꾸기
							file.renameTo(fileRename);
							i=0;
							j=0;
							break;
						}
					}
				}
			}
			File userFolder = new File(userFolderPath);
			File[] userwFileList = userFolder.listFiles();
			if(userwFileList.length!=0) {
				//저장하는 디렉토리 안에 중복 확인
				for(int j=0;j<userwFileList.length;j++) {
					String userFileName = userwFileList[j].getName();
					String fileName = "";
					String extention = "";
					
					//파일명이 서로 같을 때
					if(userFileName.equals(previewFileName)) {
						fileName = previewFileName.substring(0,previewFileName.lastIndexOf("."));
						
						extention = previewFileName.substring(previewFileName.lastIndexOf("."),previewFileName.length());
						
						//배열의 랜덤 인덱스
						double ran = Math.random()*34;
						int ranf = (int)ran;
		
						File file = new File(prviewFolderPath+"/"+previewFileName);
						File fileRename = null;
						if(fileName.length()>150) {
							fileName = ""+ranch[ranf];
						}else {
							fileName += ranch[ranf];
						}
						
						fileRename = new File(prviewFolderPath+"/"+fileName+extention);
						if(file.exists()) {
							file.renameTo(fileRename);
						}
						i=0;
						j=0;
						break;
					}
				}
			}
		}
	}
	
	public void sameFileNameDelete(String prviewFolderPath,String userFolderPath) {
		File previewFolder = new File(prviewFolderPath);
		File[] previewFileList = previewFolder.listFiles();
		
		File userFolder = new File(userFolderPath);
		File[] userFileList = userFolder.listFiles();
		
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
