package imgfile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.attribute.BasicFileAttributes;
import java.nio.file.attribute.FileTime;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Vector;

public class ImgFolderInSearch {
	public List<String> searchFolder(String path) {
		List<String> list = new Vector<>();
		File file = new File(path);
		File[] fileList = file.listFiles();

		//ModifiedDate클래스에 정의된 순서에 의해 정렬한다.
		Arrays.sort(fileList,new ImgSort());
   
		//리스트에서 파일을 하나씩 꺼낸다
		for(File f:fileList){
			//파일일 경우만 출력
			if(f.isFile()){
				//날짜 출력을 위한 Date객체 생성 생성자로 마지막 수정날짜인 lastModified메소드의 long리턴값을 넣는다.
				Date d=new Date(f.lastModified());
				//파일명, 날짜, 크기를 출력한다.
				//System.out.println(f.getName()+"\t"+d.toString()+"\t"+f.length());
				
				//파일명만 가져오기
				list.add(f.getName());
			}
		}

		
		return list;
	}
}
