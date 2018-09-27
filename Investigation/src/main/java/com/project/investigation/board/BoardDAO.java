package com.project.investigation.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.investigation.VO.QuestionStateVO;

@Repository
public class BoardDAO {

	@Autowired
	private SqlSession sqlSession;

	public List<QuestionStateVO> getStateY(int empno){
		return sqlSession.selectList("BoardMapper.getStateY",empno);
	}

	public List<QuestionStateVO> getStateN(int empno){
		return sqlSession.selectList("BoardMapper.getStateN",empno);
	}


}
