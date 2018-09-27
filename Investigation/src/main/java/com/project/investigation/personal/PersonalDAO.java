package com.project.investigation.personal;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.investigation.VO.QuestionStateVO;
import com.project.investigation.VO.ResultUserVO;
import com.project.investigation.VO.SameVersionVO;

@Repository
public class PersonalDAO {

	@Autowired
	private SqlSession sqlSession;

	public int SetUserResult(ResultUserVO resultUserVO) {
		return sqlSession.insert("PersonalMapper.SetUserResult",resultUserVO );

	}

	public int setUserState(Map<String, Object> tempMap) {
		return sqlSession.update("PersonalMapper.setUserState",tempMap);
	}

	public List<QuestionStateVO> getAnswerList(int empno){
		return sqlSession.selectList("PersonalMapper.getAnswerList",empno);
	}

	public ResultUserVO getPersonalResult(Map<String, Object> paramMap) {
		return sqlSession.selectOne("PersonalMapper.getPersonalResult",paramMap);
	}

	public List<SameVersionVO> getSameVersion(Map<String, Object> paramMap){
		return sqlSession.selectList("PersonalMapper.getSameVersion",paramMap);
	}
}
