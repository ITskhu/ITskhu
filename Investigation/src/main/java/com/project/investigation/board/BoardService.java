package com.project.investigation.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.investigation.VO.QuestionStateVO;

@Service
public class BoardService {

	@Autowired
	private BoardDAO boardDAO;

	public List<QuestionStateVO> getStateY(int empno){
		return boardDAO.getStateY(empno);
	}

	public List<QuestionStateVO> getStateN(int empno){
		return boardDAO.getStateN(empno);
	}

	public void setQuestionState(String date) {
		boardDAO.setQuestionState(date);
	}


}
