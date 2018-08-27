package com.project.investigation.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.investigation.VO.UserVOTest;


@Repository
public class TestDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public String getName() {
		return sqlSession.selectOne("TestMapper.getName");
	}

	public List<UserVOTest> getUserList(){
		return sqlSession.selectList("TestMapper.getUserList");
	}

}
