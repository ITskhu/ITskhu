package com.project.investigation.User;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.investigation.VO.UserVO;
import com.project.investigation.dto.LoginDTO;

@Repository
public class UserDAO {

	@Autowired
	private SqlSession sqlSession;

	public UserVO login(LoginDTO dto) {

		return sqlSession.selectOne("UserMapper.login",dto);
	}

}