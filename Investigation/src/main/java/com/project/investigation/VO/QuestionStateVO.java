package com.project.investigation.VO;

public class QuestionStateVO {

	private String version;
	private String titleNm;
	private String explanation;
	private String startDate;
	private String endDate;
	private int stateSeq;
	private char state;
	private int targetCount;
	private int answerCount;
	private double answerRatio;

	public double getAnswerRatio() {
		return answerRatio;
	}
	public void setAnswerRatio(double answerRatio) {
		this.answerRatio = answerRatio;
	}
	public int getAnswerCount() {
		return answerCount;
	}
	public void setAnswerCount(int answerCount) {
		this.answerCount = answerCount;
	}
	public int getTargetCount() {
		return targetCount;
	}
	public void setTargetCount(int targetCount) {
		this.targetCount = targetCount;
	}
	public char getState() {
		return state;
	}
	public void setState(char state) {
		this.state = state;
	}
	public int getStateSeq() {
		return stateSeq;
	}
	public void setStateSeq(int stateSeq) {
		this.stateSeq = stateSeq;
	}
	private String[] targetSosok;
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getTitleNm() {
		return titleNm;
	}
	public void setTitleNm(String titleNm) {
		this.titleNm = titleNm;
	}
	public String getExplanation() {
		return explanation;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String[] getTargetSosok() {
		return targetSosok;
	}
	public void setTargetSosok(String[] targetSosok) {
		this.targetSosok = targetSosok;
	}



}
