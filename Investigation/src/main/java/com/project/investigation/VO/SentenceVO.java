package com.project.investigation.VO;

public class SentenceVO {

	private String version;				//등록된 엑셀 파일의 버전
	private String itemNm;				//항목 이름
	private Integer sentenceSeq;		//문항 순서
	private String sentence;			//문항
	private Integer weight;				//가중치
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getItemNm() {
		return itemNm;
	}
	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}
	public Integer getSentenceSeq() {
		return sentenceSeq;
	}
	public void setSentenceSeq(Integer sentenceSeq) {
		this.sentenceSeq = sentenceSeq;
	}
	public String getSentence() {
		return sentence;
	}
	public void setSentence(String sentence) {
		this.sentence = sentence;
	}
	public Integer getWeight() {
		return weight;
	}
	public void setWeight(Integer weight) {
		this.weight = weight;
	}


}
