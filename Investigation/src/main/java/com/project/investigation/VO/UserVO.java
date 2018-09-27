package com.project.investigation.VO;

public class UserVO {
	private String name;
	private int empno;
	private char sex;
	private String departCode;
	private int master;

	public int getMaster() {
		return master;
	}
	public void setMaster(int master) {
		this.master = master;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public char getSex() {
		return sex;
	}
	public void setSex(char sex) {
		this.sex = sex;
	}
	public String getDepartCode() {
		return departCode;
	}
	public void setDepartCode(String departCode) {
		this.departCode = departCode;
	}


}
