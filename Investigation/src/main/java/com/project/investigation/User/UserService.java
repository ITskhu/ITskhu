package com.project.investigation.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.investigation.VO.UserVO;
import com.project.investigation.dto.LoginDTO;

@Service
public class UserService {

	@Autowired
	private UserDAO userDao;

	public UserVO login(LoginDTO dto) {
		return userDao.login(dto);
	}

}

