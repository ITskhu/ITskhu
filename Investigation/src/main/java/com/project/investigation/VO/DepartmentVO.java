package com.project.investigation.VO;

public class DepartmentVO {

	private String departCode;
	private int departLevel;
	private String levelCode;
	private char lowDepartExist;
	private String highDepartCode;
	private String name;
	public String getDepartCode() {
		return departCode;
	}
	public void setDepartCode(String departCode) {
		this.departCode = departCode;
	}
	public int getDepartLevel() {
		return departLevel;
	}
	public void setDepartLevel(int departLevel) {
		this.departLevel = departLevel;
	}
	public String getLevelCode() {
		return levelCode;
	}
	public void setLevelCode(String levelCode) {
		this.levelCode = levelCode;
	}
	public char getLowDepartExist() {
		return lowDepartExist;
	}
	public void setLowDepartExist(char lowDepartExist) {
		this.lowDepartExist = lowDepartExist;
	}
	public String getHighDepartCode() {
		return highDepartCode;
	}
	public void setHighDepartCode(String highDepartCode) {
		this.highDepartCode = highDepartCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}


}
