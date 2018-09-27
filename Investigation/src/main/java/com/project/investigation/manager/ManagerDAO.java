package com.project.investigation.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.investigation.VO.DepartmentVO;
import com.project.investigation.VO.QuestionStateVO;
import com.project.investigation.VO.SameVersionVO;

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

	public List<Integer> getTargetDepartUser(String depart){
		return sqlSession.selectList("ManagerMapper.getTargetDepartUser", depart);
	}

	public int setUserState(Map<String, Object> tempMap) {
		return sqlSession.insert("ManagerMapper.setUserState",tempMap);
	}

	public List<QuestionStateVO> getAllList(){
		return sqlSession.selectList("ManagerMapper.getAllList");
	}

	public List<QuestionStateVO> getAllDetailList() {

		//리스트 전부 가져옴
		List<QuestionStateVO> list = sqlSession.selectList("ManagerMapper.getAllDetailList");

		//반복문 돌면서 QuestionStateVO 객체에 타켓 유저 전부 저장
		for(int i=0 ; i<list.size() ; i++) {
			//설문 타켓에 해당하는 부서를 가져와,
			List<String> temp = sqlSession.selectList("ManagerMapper.getTargetList", list.get(i).getStateSeq() );

			int sum = 0;
			//해당 부서의 소속원 전체의 수를 가져와야한다
			for(int j=0 ; j<temp.size() ; j++) {
				String name = temp.get(j);
				int count = sqlSession.selectOne("ManagerMapper.getDepartEmpCount", name );
				sum = sum + count;
			}

			int stateSeq = list.get(i).getStateSeq() ;
			int answerCount = sqlSession.selectOne("ManagerMapper.getAnswerCount", stateSeq );

			list.get(i).setAnswerCount(answerCount);
			list.get(i).setTargetCount(sum);
			list.get(i).setAnswerRatio( Math.round((((double) answerCount/sum*100) * 100) / 100.0 )  );
		}

		return list;
	}

	public double[] getItemAvg (int stateSeq, String version) {
		//차수에 해당하는 version로 해당 차수의 item의 count 가져와 평균을 저장할 double 배열을 만들고 0으로 초기화
		int itemCount = sqlSession.selectOne("ManagerMapper.getItemCount", version );
		double[] itemArr = new double[itemCount];
		for(int i=0 ; i<itemArr.length ; i++)
			itemArr[i] = 0;

		//해당 차수의 유저 답변을 가져와서 ,를 자른 뒤 double로 변환한 후 배열에 저장
		List<String> list = sqlSession.selectList("ManagerMapper.getUserItemAvg", stateSeq );
		for(int i=0 ; i<list.size() ; i++) {
			String[] temp = list.get(i).split(",");
			for(int j=0 ; j<temp.length ; j++) {
				itemArr[j] = itemArr[j] + Double.parseDouble(temp[j]);
			}
		}
		//user_result에서 해당 차수의 유저중 답변을 완료한 유저의 수를 가져온 뒤, 평균을 구해줌
		int answerCount = sqlSession.selectOne("ManagerMapper.getAnswerCount2", stateSeq );

		for(int i=0 ; i<itemArr.length ; i++) {
			itemArr[i] = itemArr[i] / answerCount;
			itemArr[i] = Double.parseDouble(String.format("%.2f",itemArr[i]));
		}
		return itemArr;
	}

	public double[] getDepartItemAvg(int stateSeq, String version, String departCode) {
		//차수에 해당하는 version로 해당 차수의 item의 count 가져와 평균을 저장할 double 배열을 만들고 0으로 초기화
		int itemCount = sqlSession.selectOne("ManagerMapper.getItemCount", version );
		double[] itemArr = new double[itemCount];

		Map<String, Object> tempMap = new HashMap<String, Object>();
		tempMap.put("departCode", departCode);
		tempMap.put("stateSeq", stateSeq);

		//해당 차수+부서의 유저 답변을 가져와서 ,를 자른 뒤 double로 변환한 후 배열에 저장
		List<String> list = sqlSession.selectList("ManagerMapper.getDepartItemAvg", tempMap );
		for(int i=0 ; i<list.size() ; i++) {
			String[] temp = list.get(i).split(",");
			for(int j=0 ; j<temp.length ; j++) {
				itemArr[j] = itemArr[j] + Double.parseDouble(temp[j]);
			}
		}
		//user_result에서 해당 차수+부서의 유저중 답변을 완료한 유저의 수를 가져온 뒤, 평균을 구해줌
		int answerCount = sqlSession.selectOne("ManagerMapper.getAnswerCount3", tempMap );
		for(int i=0 ; i<itemArr.length ; i++) {
			itemArr[i] = itemArr[i] / answerCount;
			itemArr[i] = Double.parseDouble(String.format("%.2f",itemArr[i]));
			System.out.println(itemArr[i]);
		}

		return itemArr;
	}

	public List<DepartmentVO> getTargetOtherDepart(int stateSeq, String departCode){
		Map<String, Object> tempMap = new HashMap<String, Object>();
		tempMap.put("stateSeq", stateSeq);
		tempMap.put("departCode", departCode);
		return sqlSession.selectList("ManagerMapper.getTargetOtherDepart", tempMap );
	}

	public List<SameVersionVO> getSameVersion2(Map<String, Object> paramMap){
		return sqlSession.selectList("ManagerMapper.getSameVersion2",paramMap);
	}

	public int[][] getSentenceVal(int stateSeq, String version){

		int sentenceCount = sqlSession.selectOne("ManagerMapper.getSentenceCount", version );
		int[][] sentenceArr = new int[5][sentenceCount];

		List<String> list = sqlSession.selectList("ManagerMapper.getUserAnswer", stateSeq );
		for(int i=0 ; i<list.size() ; i++) {

			String[] temp = list.get(i).split(",");

			for(int j=0 ; j<temp.length ; j++) {
				if(Integer.parseInt(temp[j])==1) {
					sentenceArr[0][j]++;
				}
				else if(Integer.parseInt(temp[j])==2) {
					sentenceArr[1][j]++;
				}
				else if(Integer.parseInt(temp[j])==3) {
					sentenceArr[2][j]++;
				}
				else if(Integer.parseInt(temp[j])==4) {
					sentenceArr[3][j]++;
				}
				else {
					sentenceArr[4][j]++;
				}
			}
		}
		return sentenceArr;
	}

	public int[][] getDepartAns(int stateSeq, String version, String departCode){

		int sentenceCount = sqlSession.selectOne("ManagerMapper.getSentenceCount", version );
		int[][] sentenceArr = new int[5][sentenceCount];
		Map<String, Object> tempMap = new HashMap<String, Object>();
		tempMap.put("stateSeq", stateSeq);
		tempMap.put("departCode", departCode);

		List<String> list = sqlSession.selectList("ManagerMapper.getDepartAns", tempMap );
		for(int i=0 ; i<list.size() ; i++) {

			String[] temp = list.get(i).split(",");

			for(int j=0 ; j<temp.length ; j++) {
				if(Integer.parseInt(temp[j])==1) {
					sentenceArr[0][j]++;
				}
				else if(Integer.parseInt(temp[j])==2) {
					sentenceArr[1][j]++;
				}
				else if(Integer.parseInt(temp[j])==3) {
					sentenceArr[2][j]++;
				}
				else if(Integer.parseInt(temp[j])==4) {
					sentenceArr[3][j]++;
				}
				else {
					sentenceArr[4][j]++;
				}
			}
		}
		return sentenceArr;
	}

	public int getAnswerCount4(int stateSeq, String version, String departCode) {
		Map<String, Object> tempMap = new HashMap<String, Object>();
		tempMap.put("stateSeq", stateSeq);
		tempMap.put("departCode", departCode);
		int answerCount = sqlSession.selectOne("ManagerMapper.getAnswerCount4", tempMap );
		return answerCount;
	}

	public int getAnswerCount2(int stateSeq) {
		int answerCount = sqlSession.selectOne("ManagerMapper.getAnswerCount", stateSeq );
		return answerCount;
	}

	public int[] getSelectSentence(int stateSeq, int selectSen){

		int[] sentenceArr = new int[5];

		List<String> list = sqlSession.selectList("ManagerMapper.getUserAnswer", stateSeq );
		for(int i=0 ; i<list.size() ; i++) {
			String[] temp = list.get(i).split(",");
			if(Integer.parseInt(temp[selectSen-1])==1) {
				sentenceArr[0]++;
			}
			else if(Integer.parseInt(temp[selectSen-1])==2) {
				sentenceArr[1]++;
			}
			else if(Integer.parseInt(temp[selectSen-1])==3) {
				sentenceArr[2]++;
			}
			else if(Integer.parseInt(temp[selectSen-1])==4) {
				sentenceArr[3]++;
			}
			else {
				sentenceArr[4]++;
			}

		}
		return sentenceArr;
	}

	public List<DepartmentVO> getTargetDepart(int stateSeq){
		return sqlSession.selectList("ManagerMapper.getTargetDepart", stateSeq );
	}
}
