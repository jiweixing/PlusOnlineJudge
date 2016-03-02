package com.jinhaoplus.oj.service.langCore.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;

import org.springframework.stereotype.Service;

import com.jinhaoplus.oj.service.langCore.LangCoreService;

@Service
public class CCoreServiceImpl implements LangCoreService {

	@Override
	public String compileCode(int problemId,String path) {
		String result="";
		try {
			String fileName = path.substring(0,path.lastIndexOf("."));
			String compileCommand = "gcc -o "+fileName+" "+path;
			Process compileProcess = Runtime.getRuntime().exec(compileCommand);
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(compileProcess.getInputStream()));
			String compileResult = bufferedReader.readLine();
			result += "[compile INFO] "+compileResult+"\n";
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String runCode(Long codeId) {
		String result="";
		try {
			Process runProcess = Runtime.getRuntime().exec("hello.exe");
			BufferedReader bufferedReader1 = new BufferedReader(new InputStreamReader(runProcess.getInputStream()));
			String runResult = bufferedReader1.readLine();
			result += "[run INFO] "+runResult+"\n";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public String OJResult() {
		String result="";
		try {
			result += "[run INFO] "+"AC"+"\n";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String createTempSourceFile(String fileOrDirName) {
		return fileOrDirName;
	}

	
}