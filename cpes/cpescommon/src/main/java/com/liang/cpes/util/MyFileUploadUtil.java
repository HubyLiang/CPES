package com.liang.cpes.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class MyFileUploadUtil {
	
	public static List<String> imgsUpload(MultipartFile[] files){
		List<String> imgList = new ArrayList<String>();
		for(int i = 0;i<files.length;i++){
			try {
				String originalFilename =  System.currentTimeMillis()+files[i].getOriginalFilename();
				files[i].transferTo(new File("D:\\MyWork\\CPES\\cpes\\cpesweb\\src\\main\\webapp\\upload"+originalFilename));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return imgList;
	}
	
	public static List<String> imgsUpload(MultipartFile file){
		List<String> imgList = new ArrayList<String>();
			try {
				String originalFilename =  System.currentTimeMillis()+file.getOriginalFilename();
				file.transferTo(new File("D:\\MyWork\\CPES\\cpes\\cpesweb\\src\\main\\webapp\\upload"+originalFilename));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		return imgList;
	}
}
