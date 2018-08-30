package com.project.investigation.manager;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.investigation.VO.QuestionVO;

@Repository
public class UploadQuestionDAO {

	@Autowired
	private SqlSession sqlSession;

	public int setQuestion(QuestionVO questionVO){

		return sqlSession.insert("QuestionMapper.setQuestion",questionVO);
	}

	public int setItems(Map<String, Object> paramMap) {

		return sqlSession.insert("QuestionMapper.setItems", paramMap);
	}

	public int setSentences(Map<String, Object> paramMap) {

		return sqlSession.insert("QuestionMapper.setSentences", paramMap);
	}
}
