package com.project.investigation.manager;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.investigation.VO.DepartmentVO;
import com.project.investigation.VO.QuestionStateVO;
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

	public List<DepartmentVO> getLevelDepartment(int level){
		return managerDao.getLevelDepartment(level);
	}

	@Transactional(rollbackFor={Exception.class})
	public Boolean setQuestionMaking(QuestionStateVO questionStateVO) {

		SimpleDateFormat simDate = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		Date d1 = new Date();
		String serverStartDate = simDate.format(d1);
		questionStateVO.setStartDate(serverStartDate);

		List<String> targetString = new ArrayList<>();
		Map<String, Object> paramMap = new HashMap<String, Object>();

		for(int i=0 ; i<questionStateVO.getTargetSosok().length ; i++) {
			targetString.add(questionStateVO.getTargetSosok()[i]);
			System.out.println(targetString.get(i));
		}
		paramMap.put("targetList", targetString);
		int checkMaking = managerDao.setQuestionMaking(questionStateVO);

		System.out.println("방금 입력된 seq="+questionStateVO.getStateSeq());
		paramMap.put("stateSeq",questionStateVO.getStateSeq());
		int checkTarget = managerDao.setTargetDepart(paramMap);

		if(checkMaking > 0 && checkTarget > 0)
			return true;
		else
			return false;
	}
}
