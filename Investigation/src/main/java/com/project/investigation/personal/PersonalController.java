package com.project.investigation.personal;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.investigation.VO.ItemVO;
import com.project.investigation.VO.ResultUserVO;
import com.project.investigation.VO.SameVersionVO;
import com.project.investigation.VO.UserVO;
import com.project.investigation.board.BoardService;
import com.project.investigation.manager.ManagerService;

@Controller
public class PersonalController {

	@Autowired
	private PersonalService personalService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private ManagerService managerService;

	@PostMapping("/join/input")
	@ResponseBody
	//public ResponseEntity<String> InputResult(@RequestBody ResultUserVO resultUserVO) throws Exception{
	public Boolean InputResult(@RequestBody ResultUserVO resultUserVO) throws Exception{
		System.out.println(resultUserVO.getVersion());
		System.out.println(resultUserVO.getStateSeq());
		System.out.println(resultUserVO.getEmpno());
		System.out.println(resultUserVO.getAnswersVal());
		System.out.println(resultUserVO.getTotalAvg());
		System.out.println(resultUserVO.getItemsAvg());
		System.out.println(resultUserVO.getInputDt());


		Boolean chk = personalService.SetUserResult(resultUserVO);

		if(chk){
			return true;
		}else{
			return false;
		}
	}


	@GetMapping("/personal")
	public ModelAndView PersonalResultList(HttpSession session) {
		UserVO user = (UserVO) session.getAttribute("login");
		int empno = user.getEmpno();

		ModelAndView response = new ModelAndView("/personal/list");
		response.addObject("QuestionList", personalService.getAnswerList(empno));
		return response;
	}

	@PostMapping("/personal/result")
	public ModelAndView PersonalResult(HttpSession session, @RequestParam(value="version") String version,
			@RequestParam(value="stateSeq") String stateSeq) {

		ModelAndView response = new ModelAndView("/personal/result");
		UserVO user = (UserVO) session.getAttribute("login");
		int empno = user.getEmpno();
		int seq = Integer.parseInt(stateSeq);
		//개인 답변 가져와야함
		ResultUserVO userResult = personalService.getPersonalResult(empno, seq);
		response.addObject("UserResult", userResult);

		//버전에 해당하는 item들 가져와야함 문자열로
		List<ItemVO> items = managerService.getQuestionItemList(version);
		String itemString ="";

		for(int i=0 ; i<items.size() ; i++) {
			if(i==0) {
				itemString = itemString+items.get(i).getItemNm();
			}else {
				itemString = itemString + ","+ items.get(i).getItemNm();
			}
		}
		response.addObject("ItemString", itemString);
		//전부 문자열로 가면 됨, jsp단에선 fn:split로 잘라서 배열 만들면되고
		//자바스크립트단에서도.split(","); 로 잘라서 배열 만들면 됨
		return response;
	}

	@PostMapping("/personal/sameversion")
	@ResponseBody
	public List<SameVersionVO> SameVersionList(HttpSession session, @RequestBody ResultUserVO vo ) {

		System.out.println("SameVersionList()");
		UserVO user = (UserVO) session.getAttribute("login");

		int emp = Integer.parseInt(vo.getEmpno());
		int seq = Integer.parseInt(vo.getStateSeq());
		String ver = vo.getVersion();
		System.out.println(seq);

		List<SameVersionVO> same = personalService.getSameVersion(emp, seq, ver);
		return same;

	}

	@GetMapping("/personal/compare")
	@ResponseBody
	public ResultUserVO Compare(HttpSession session, @RequestParam(value = "stateSeq", required = false) String stateSeq) {

		UserVO user = (UserVO) session.getAttribute("login");

		int empno = user.getEmpno();
		int seq = Integer.parseInt(stateSeq);
		//개인 답변 가져와야함
		ResultUserVO userResult = personalService.getPersonalResult(empno, seq);

		//List<SameVersionVO> same = personalService.getSameVersion(emp, seq, ver);
		return userResult;

	}
}
