package com.project.investigation.manager;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.investigation.VO.DepartmentVO;

@Repository
public class ManagerDAO {

	@Autowired
	private SqlSession sqlSession;

	public List<DepartmentVO> getAllDepartment(){
		return sqlSession.selectList("DepartmentMapper.getAllDepartment");
	}


}
