package com.project.investigation.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.investigation.VO.DepartmentVO;
import com.project.investigation.VO.QuestionVO;
import com.project.investigation.VO.SentenceVO;

@Service
public class ManagerService {

	@Autowired
	private QuestionDAO QuestionDao;

	@Autowired
	private ManagerDAO managerDao;

	public List<QuestionVO> getQuestionRegistryList(){
		return QuestionDao.getQuestionRegistryList();
	}

	public List<SentenceVO> getQuestionSentenceList(String version){
		return QuestionDao.getQuestionSentenceList(version);
	}

	public List<DepartmentVO> getAllDepartment(){
		return managerDao.getAllDepartment();
	}
}
