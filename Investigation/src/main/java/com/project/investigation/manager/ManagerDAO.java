package com.project.investigation.manager;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.investigation.VO.DepartmentVO;
import com.project.investigation.VO.QuestionStateVO;

@Repository
public class ManagerDAO {

	@Autowired
	private SqlSession sqlSession;

	public List<DepartmentVO> getAllDepartment(){
		return sqlSession.selectList("DepartmentMapper.getAllDepartment");
	}

	public List<DepartmentVO> getLevelDepartment(int level){
		return sqlSession.selectList("DepartmentMapper.getLevelDepartment", level);
	}

	public int setQuestionMaking(QuestionStateVO questionStateVO) {
		return sqlSession.insert("ManagerMapper.setQuestionMaking", questionStateVO);
	}

	public int setTargetDepart(Map<String, Object> paramMap) {
		return sqlSession.insert("ManagerMapper.setTargetDepart", paramMap);
	}

}
