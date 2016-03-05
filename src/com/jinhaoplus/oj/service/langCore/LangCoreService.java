package com.jinhaoplus.oj.service.langCore;

import java.util.List;

import com.jinhaoplus.oj.domain.CommonMessage;
import com.jinhaoplus.oj.domain.ProblemTestResult;

public interface LangCoreService {
	public String createTempSourceFile(String fileOrDirName);
	//Compile source Code
	public CommonMessage compileCode(int ProblemId,String path);
	//Run compiled Code
	public List<ProblemTestResult> runCode(int problemId,String path);
	//OJ Result of the Running
	public String OJResult();
}
