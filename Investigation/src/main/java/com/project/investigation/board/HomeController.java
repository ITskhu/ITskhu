package com.project.investigation.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.investigation.VO.ItemVO;
import com.project.investigation.VO.QuestionStateVO;
import com.project.investigation.VO.SentenceVO;
import com.project.investigation.VO.UserVO;
import com.project.investigation.manager.ManagerService;




@Controller
public class HomeController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private ManagerService managerService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);


	/**
	 * Simply selects the home view to render by returning its name.
	 */
	/*
	 @RequestMapping(value = {"/"}, method = RequestMethod.GET)

	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate );

		return "main";
	}
	 */

	@RequestMapping("/")
	public String first() {
		return "/user/login";

	}

	@RequestMapping("/main")
	public String mainPage(HttpSession session) {

		return "main";
	}

	@GetMapping("/introduce/introduce")
	public String Introduce() {

		return "introduce/introduce";
	}

	@GetMapping("/introduce/how")
	public String How() {

		return "introduce/how";
	}


	@GetMapping("/state")
	public ModelAndView state(HttpSession session) {
		UserVO user = (UserVO) session.getAttribute("login");

		String departCode = user.getDepartCode();
		int empno = user.getEmpno();

		List<QuestionStateVO> stateY = boardService.getStateY(empno);
		List<QuestionStateVO> stateN = boardService.getStateN(empno);

		ModelAndView response = new ModelAndView("state/state");
		response.addObject("stateY", stateY);
		response.addObject("stateN", stateN);
		return response;
	}


	@PostMapping("/state/join")
	public ModelAndView Join(@RequestParam(value="version") String version,
			@RequestParam(value="stateSeq") String stateSeq) {

		ModelAndView response = new ModelAndView("state/join");

		List<ItemVO> items = managerService.getQuestionItemList(version);
		List<SentenceVO> sentences = managerService.getQuestionSentenceList(version);
		response.addObject("version",version);
		response.addObject("stateSeq",stateSeq);
		response.addObject("items",items);
		response.addObject("sentences",sentences);
		response.addObject("itemCount",items.size());
		response.addObject("sentenceCount",sentences.size());
		return response;
	}


}
