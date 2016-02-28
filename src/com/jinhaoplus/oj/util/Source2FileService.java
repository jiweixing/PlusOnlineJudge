package com.jinhaoplus.oj.util;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import com.jinhaoplus.oj.domain.ProblemSolution;

public class Source2FileService {
	private Source2FileService(){
		
	}
	public static String renameForTempSource(ProblemSolution solution){
		StringBuffer rename = new StringBuffer();
		long sysMill = System.currentTimeMillis();
		rename.append("prblm");
		rename.append(solution.getProblemId());
		rename.append("#");
		rename.append(solution.getSolutionCoder().substring(0, 4));
		rename.append(new String(new Long(sysMill).toString()));
		return rename.toString();
	}
	public static void persistentFile(ProblemSolution solution,String path) {
		try {
			String source = solution.getCodeSubmit();
			File file = new File(path);
			file.createNewFile();
			FileWriter fileWriter;
			fileWriter = new FileWriter(file);
			fileWriter.write(source);
			fileWriter.close();
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
	}
}
