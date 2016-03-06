package com.jinhaoplus.oj.service.langCore.impl;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ThreadPoolExecutor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jinhaoplus.oj.common.ResultReadCallable;
import com.jinhaoplus.oj.common.TestWriteCallable;
import com.jinhaoplus.oj.dao.ProblemsDao;
import com.jinhaoplus.oj.domain.CommonMessage;
import com.jinhaoplus.oj.domain.ProblemSolution;
import com.jinhaoplus.oj.domain.ProblemTest;
import com.jinhaoplus.oj.domain.ProblemTestResult;
import com.jinhaoplus.oj.service.langCore.LangCoreService;
import com.jinhaoplus.oj.util.PropertiesUtil;


@Service
public class RubyCoreServiceImpl implements LangCoreService {

	@Autowired
	private ProblemsDao problemsDao;

	public void setProblemsDao(ProblemsDao problemsDao) {
		this.problemsDao = problemsDao;
	}
	
	private ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors .newCachedThreadPool();

	
	@Override
	public CommonMessage insertSolution(ProblemSolution problemSolution) {
		problemsDao.insertSolution(problemSolution);
		return null;
	}
	
	@Override
	public CommonMessage compileCode(int problemId,String path) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProblemTestResult> runCode(int problemId, String path) {
		List<ProblemTest> problemTests = problemsDao
				.getTestByProblemId(problemId);
		for (ProblemTest problemTest : problemTests) {
			CommonMessage message = null;
			ProcessBuilder processBuilder;
			String fileName = path.substring(path.lastIndexOf("/")+1, path.length());
			String rbDir = path.substring(0,path.lastIndexOf("/"));
			processBuilder = new ProcessBuilder("ruby",fileName);
			processBuilder.directory(new File(rbDir));
			processBuilder.redirectErrorStream(true);

			try {
				Process runProcess = processBuilder.start();
				final InputStream inputStream = runProcess.getInputStream();
				final InputStream errorStream = runProcess.getErrorStream();
				final OutputStream outputStream = runProcess.getOutputStream();

				ResultReadCallable runResultThread = new ResultReadCallable(inputStream);
				ResultReadCallable runErrorThread = new ResultReadCallable(errorStream);
				TestWriteCallable runTestWriteThread = new TestWriteCallable(outputStream, problemTest.getProblemTestInput());
				Future<String> runErrorInfo = executor.submit(runErrorThread);
				Future<String> runResultInfo = executor.submit(runResultThread);
				executor.submit(runTestWriteThread);
				
				runProcess.waitFor();
				runProcess.destroy();
				
				if(runProcess.exitValue()==0){
					message = new CommonMessage(PropertiesUtil.getProperty("RUN_SUCCESS_CODE"), 
							PropertiesUtil.getProperty("RUN_SUCCESS"), 
							runResultInfo.get());
				}else{
					message = new CommonMessage(PropertiesUtil.getProperty("RUN_ERROR_CODE"), 
							PropertiesUtil.getProperty("RUN_ERROR"), 
							runErrorInfo.get());
				}
			} catch (Exception e) {

				e.printStackTrace();
			}
		}
		return null;
	}

	@Override
	public String OJResult(ProblemTest problemTest,ProblemTestResult testResult) {
		if(problemTest.getProblemTestOutput().equals(testResult.getResult())){
			return "AC";
		}else{
			return "WA";
		}
	}

	@Override
	public String createTempSourceFile(String fileOrDirName) {
		return fileOrDirName;
	}
}
