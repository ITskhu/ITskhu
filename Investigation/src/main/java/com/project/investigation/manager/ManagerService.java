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
import com.project.investigation.VO.ItemVO;
import com.project.investigation.VO.QuestionStateVO;
import com.project.investigation.VO.QuestionVO;
import com.project.investigation.VO.SameVersionVO;
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

	public List<ItemVO> getQuestionItemList(String version){
		return QuestionDao.getQuestionItemList(version);
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

		//타켓 부서를 저장하는 리스트
		List<String> targetString = new ArrayList<>();

		Map<String, Object> paramMap = new HashMap<String, Object>();

		for(int i=0 ; i<questionStateVO.getTargetSosok().length ; i++) {
			targetString.add(questionStateVO.getTargetSosok()[i]);
		} //리스트에 타켓 부서 저장 완료

		//타켓 부서 입력
		paramMap.put("targetList", targetString);
		int checkMaking = managerDao.setQuestionMaking(questionStateVO);

		paramMap.put("stateSeq",questionStateVO.getStateSeq());

		//paramMap에 타켓 부서코드랑 출제된
		int checkTarget = managerDao.setTargetDepart(paramMap);

		List<Integer> targetUser = new ArrayList<>();
		for(int i=0 ; i<targetString.size() ; i++) {

			List<Integer> temp = managerDao.getTargetDepartUser(targetString.get(i) );

			//targetUser.addAll( managerDao.getTargetDepartUser(targetString.get(i) ));
			targetUser.addAll(temp);
		}

		Map<String, Object> tempMap = new HashMap<String, Object>();
		tempMap.put("targetUser", targetUser);
		tempMap.put("stateSeq", questionStateVO.getStateSeq());
		int checkUser = managerDao.setUserState(tempMap);


		if(checkMaking > 0 && checkTarget > 0 && checkUser >0)
			return true;
		else
			return false;
	}

	public List<QuestionStateVO> getAllDetailList() {
		return managerDao.getAllDetailList();
	}

	public List<QuestionStateVO> getAllList(){
		return managerDao.getAllList();
	}

	public double[] getItemAvg (int stateSeq, String version) {
		return managerDao.getItemAvg(stateSeq, version);
	}

	public List<SameVersionVO> getSameVersion2(int stateSeq, String version){

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("stateSeq", stateSeq);
		paramMap.put("version", version);
		return managerDao.getSameVersion2(paramMap);
	}

	public int[][] getSentenceVal(int stateSeq, String version){
		return managerDao.getSentenceVal(stateSeq, version);
	}

	public int getAnswerCount2(int stateSeq) {

		return managerDao.getAnswerCount2(stateSeq);
	}

	public int[] getSelectSentence(int stateSeq, int selectSen){
		return managerDao.getSelectSentence(stateSeq, selectSen);
	}

	public List<DepartmentVO> getTargetDepart(int stateSeq){
		return managerDao.getTargetDepart(stateSeq);
	}

	public double[] getDepartItemAvg(int stateSeq, String version, String departCode) {
		return managerDao.getDepartItemAvg(stateSeq, version, departCode);
	}

	public List<DepartmentVO> getTargetOtherDepart(int stateSeq, String departCode){

		return managerDao.getTargetOtherDepart(stateSeq, departCode);
	}

	public int[][] getDepartAns(int stateSeq, String version, String departCode){
		return managerDao.getDepartAns(stateSeq, version, departCode);
	}

	public int getAnswerCount4(int stateSeq, String version, String departCode) {
		return managerDao.getAnswerCount4(stateSeq, version, departCode);
	}
}
