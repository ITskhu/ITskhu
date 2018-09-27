package com.project.investigation.User;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.investigation.VO.UserVO;
import com.project.investigation.dto.LoginDTO;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) {

	}

	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public void loginPOST(LoginDTO dto, HttpSession session, Model model)
			throws Exception {

		UserVO vo = userService.login(dto);

		if (vo == null) {
			return;
		}
		System.out.println("loginPOST");
		System.out.println(vo.getName());
		System.out.println("--------------");
		//session.setAttribute("userVO", vo);

		model.addAttribute("userVO", vo);

	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		System.out.println("로그아웃");
		session.getAttribute("login");
		session.invalidate();						//session 전체 초기화

		//session.removeAttribute("userid");		//session 해당 키만 지움

		return "redirect:/main";
	}
}


