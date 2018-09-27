package com.project.investigation.personal;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.investigation.VO.QuestionStateVO;
import com.project.investigation.VO.ResultUserVO;
import com.project.investigation.VO.SameVersionVO;

@Service
public class PersonalService {

	@Autowired
	private PersonalDAO dao;

	@Transactional(rollbackFor={Exception.class})
	public Boolean SetUserResult(ResultUserVO resultUserVO) {

		SimpleDateFormat simDate = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		Date d1 = new Date();
		String serverStartDate = simDate.format(d1);
		resultUserVO.setInputDt(serverStartDate);
		int chkInsert = dao.SetUserResult(resultUserVO);

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("stateSeq", resultUserVO.getStateSeq());
		paramMap.put("inputDt",serverStartDate);
		paramMap.put("empno",resultUserVO.getEmpno());

		//개인 state도 update 해야함
		int chkUserState = dao.setUserState(paramMap);

		if(chkInsert > 0 && chkUserState > 0){
			return true;
		}else{
			return false;
		}

	}

	public List<QuestionStateVO> getAnswerList(int empno){
		return dao.getAnswerList(empno);
	}

	public ResultUserVO getPersonalResult(int empno, int stateSeq) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("empno", empno);
		paramMap.put("stateSeq", stateSeq);
		return dao.getPersonalResult(paramMap);
	}

	public List<SameVersionVO> getSameVersion(int empno, int stateSeq, String version){

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("empno", empno);
		paramMap.put("stateSeq", stateSeq);
		paramMap.put("version", version);
		return dao.getSameVersion(paramMap);
	}
}
