package com.project.investigation.VO;

import java.util.List;

public class QuestionVO {

	private String version; 		//등록된 엑셀 파일의 버전
	private String name;			//엑셀 파일 이름
	private String registryDt;		//등록 날짜

	private List<ItemVO> items;
	private List<SentenceVO> sentences;

	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegistryDt() {
		return registryDt;
	}
	public void setRegistryDt(String registryDt) {
		this.registryDt = registryDt;
	}
	public List<ItemVO> getItems() {
		return items;
	}
	public void setItems(List<ItemVO> items) {
		this.items = items;
	}
	public List<SentenceVO> getSentences() {
		return sentences;
	}
	public void setSentences(List<SentenceVO> sentences) {
		this.sentences = sentences;
	}


}
