package com.project.investigation.VO;

public class ItemVO {

	private String version; 		//등록된 엑셀 파일의 버전
	private Integer itemSeq;		//항목 순서
	private String itemNm;			//항목 이름
	//private String itemCd;			//항목 코드
	private String itemDec;			//항목 설명

	public String getItemDec() {
		return itemDec;
	}
	public void setItemDec(String itemDec) {
		this.itemDec = itemDec;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public Integer getItemSeq() {
		return itemSeq;
	}
	public void setItemSeq(Integer itemSeq) {
		this.itemSeq = itemSeq;
	}
	public String getItemNm() {
		return itemNm;
	}
	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}
	/*
	public String getItemCd() {
		return itemCd;
	}
	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}
	 */


}
