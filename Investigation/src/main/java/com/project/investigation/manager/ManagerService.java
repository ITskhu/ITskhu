package com.project.investigation.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.investigation.VO.QuestionVO;
import com.project.investigation.VO.SentenceVO;

@Service
public class ManagerService {

	@Autowired
	private QuestionDAO dao;

	public List<QuestionVO> getQuestionRegistryList(){
		return dao.getQuestionRegistryList();
	}

	public List<SentenceVO> getQuestionSentenceList(String version){
		return dao.getQuestionSentenceList(version);
	}
}
