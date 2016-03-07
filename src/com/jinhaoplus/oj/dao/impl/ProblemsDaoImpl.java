package com.jinhaoplus.oj.dao.impl;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.sql.DataSource;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.jinhaoplus.oj.dao.ProblemsDao;
import com.jinhaoplus.oj.domain.Problem;
import com.jinhaoplus.oj.domain.ProblemSolution;
import com.jinhaoplus.oj.domain.ProblemTest;
import com.jinhaoplus.oj.domain.ProblemTestResult;

@Repository
public class ProblemsDaoImpl extends SqlMapClientDaoSupport implements ProblemsDao{

	@Resource(name = "dataSource")  
    private DataSource dataSource;  
    @PostConstruct  
        public void initDataSource(){  
         super.setDataSource(dataSource);
    }   

	@Resource(name = "sqlMapClient")  
    private SqlMapClient sqlMapClient;  
    @PostConstruct  
        public void initSqlMapClient(){  
         super.setSqlMapClient(sqlMapClient);  
    }   
	@Override
	public List<Problem> getAllProblems() {
		return getSqlMapClientTemplate().queryForList("getAllProblems",null);
	}

	@Override
	public Problem getProblemById(int id) {
		return (Problem) getSqlMapClientTemplate().queryForObject("getProblemById",id);
	}
	
	@Override
	public List<ProblemTest> getTestsByProblemId(int problemId) {
		return  (List<ProblemTest>) getSqlMapClientTemplate().queryForList("getTestsByProblemId",problemId);
	}
	@Override
	public void insertTestResult(ProblemTestResult testResult) {
		getSqlMapClientTemplate().insert("insertTestResult", testResult);
		
	}
	@Override
	public int insertSolution(ProblemSolution problemSolution) {
		return (int) getSqlMapClientTemplate().insert("insertSolution", problemSolution);
		
	}
	@Override
	public List<ProblemSolution> getAllSolutionsByCoderId(int coderId) {
		return  (List<ProblemSolution>) getSqlMapClientTemplate().queryForList("getAllSolutionsByCoderId",coderId);
	}
	@Override
	public ProblemSolution getSolutionById(int solutionId) {
		return (ProblemSolution) getSqlMapClientTemplate().queryForObject("getSolutionById",solutionId);
	}
	@Override
	public void updateSolution(ProblemSolution problemSolution) {
		getSqlMapClientTemplate().update("updateSolution", problemSolution);
		
	}
	@Override
	public List<ProblemTestResult> getTestResultById(int solutionId) {
		return  (List<ProblemTestResult>) getSqlMapClientTemplate().queryForList("getTestResultById",solutionId);
	}
	@Override
	public List<ProblemSolution> getTestResultsBySolutionId(int solutionId) {
		return  (List<ProblemSolution>) getSqlMapClientTemplate().queryForList("getTestResultsBySolutionId",solutionId);
	}

	
	

}
