package com.project.investigation.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project.investigation.DAO.TestDAO;
import com.project.investigation.VO.UserVOTest;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration( locations ={"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class DBTest1 {

	@Autowired
	private TestDAO dao;


	@Test
	public void getname() throws Exception{
		System.out.println(dao.getName());
	}

	@Test
	public void getUserList() throws Exception{
		List<UserVOTest> list = dao.getUserList();
		for(int i=0 ; i<list.size() ; i++) {
			System.out.println(list.get(i).getName());
		}
	}
}

