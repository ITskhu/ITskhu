package com.project.investigation.manager;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.investigation.VO.ItemVO;
import com.project.investigation.VO.QuestionVO;
import com.project.investigation.VO.SentenceVO;

@Service
public class QuestionService {

	@Autowired
	private QuestionDAO dao;
	/**
	 * 엑셀 데이터 불러올때, 200자까지 제한하고 나머지부분은 잘라내는 기능 [한글은 2바이트 그 외엔 1바이트로 계산해서 넣어야하기 때문]
	 * @param strData - 제한해야할 데이터값
	 * @param iStartPos - 시작번호
	 * @param iByteLength - 제한할 길이
	 * @return
	 * @exception Exception
	 */
	public String subString(String strData, int iStartPos, int iByteLength) throws Exception {
		byte[] bytTemp = null;
		int iRealStart = 0;
		int iRealEnd = 0;
		int iLength = 0;
		int iChar = 0;

		try {
			// bytTemp에 데이터값을 "EUC-KR" 인코딩으로 바이트를 계산해서 넣고
			bytTemp = strData.getBytes("EUC-KR");
			// 그에 해당하는 길이를 계산한다.
			iLength = bytTemp.length;

			for (int iIndex = 0; iIndex < iLength; iIndex++) {
				if (iStartPos <= iIndex) {
					break;
				}
				iChar = bytTemp[iIndex];
				if ((iChar > 127) || (iChar < 0)) {
					iRealStart++;
					iIndex++;
				} else {
					iRealStart++;
				}
			}

			iRealEnd = iRealStart;
			int iEndLength = iRealStart + iByteLength;
			for (int iIndex = iRealStart; iIndex < iEndLength; iIndex++) {
				if(iIndex < iLength){
					iChar = bytTemp[iIndex];
					if ((iChar > 127) || (iChar < 0)) {
						iRealEnd++;
						iIndex++;
					} else {
						iRealEnd++;
					}
				}
			}
		}catch (NullPointerException e) {
			System.out.println("Error NullPointerException");
		}catch (IndexOutOfBoundsException e) {
			System.out.println("Error IndexOutOfBoundsException");
		}catch (Exception e) {
			System.out.println("Error");
		}

		return strData.substring(iRealStart, iRealEnd);
	}


	/**
	 * 엑셀파일 업로드 [.xlsx] 기능
	 * @param excel - InputStream
	 * @return
	 * @exception Exception
	 */
	public QuestionVO ExcelParse_xlsx(final InputStream excel, QuestionVO question) throws Exception {
		String message="";
		QuestionVO QuestionVO = question;
		List<ItemVO> ItemVOList = new ArrayList<ItemVO>();
		List<SentenceVO> SentenceVOList = new ArrayList<SentenceVO>();

		Workbook wb = new XSSFWorkbook(excel);
		Sheet sheetItem = wb.getSheetAt(0); //시트1 읽기
		Sheet sheetSentence = wb.getSheetAt(1); //시트2 읽기

		//rowFor : sheetItem
		for(Row row : sheetItem) {
			if(row.getRowNum() == 0){continue;}
			ItemVO ItemVO = new ItemVO();
			for(Cell cell : row){
				String value = "";
				CellReference cellRef = new CellReference(row.getRowNum(), cell.getColumnIndex());
				//가능하면 String으로 받음. 날짜 또한 날짜형식으로 오면 String으로 바꾸고 숫자형식도 String으로 바꿈.
				switch (cell.getCellType()) {
				case Cell.CELL_TYPE_STRING:
					value = cell.getRichStringCellValue().getString();
					break;
				case Cell.CELL_TYPE_NUMERIC:
					if (DateUtil.isCellDateFormatted(cell)) {
						SimpleDateFormat df = new SimpleDateFormat("yyyymmdd");
						value = df.format(cell.getDateCellValue());
					} else {
						value = String.valueOf(Math.round(cell.getNumericCellValue()));
					}
					break;
				case Cell.CELL_TYPE_FORMULA:
					value = cell.getCellFormula();
					break;
				case Cell.CELL_TYPE_BLANK:
					value = "";
					break;
				case Cell.CELL_TYPE_ERROR:
					break;
				default:
					break;
				} //end of switch

				value = subString(value, 0, 200);
				String colValue = subString(cellRef.formatAsString(), 0, 1);

				//첫번째 줄은 제목이므로 뛰어넘음.
				//if (rowValue.equals("1")) { continue rowFor;}
				//cell A,B,C,D,E,F,G,H,I,J,K 이외는 무시
				//시트1 항목
				if(value != null && value != ""){
					if (colValue.equals("A")){
						ItemVO.setItemSeq(Integer.parseInt(value));
					}else if (colValue.equals("B")){
						ItemVO.setItemNm(value);
					}else if (colValue.equals("C")){
						ItemVO.setItemDec(value);
					}
				}
			} //end of for cell
			ItemVOList.add(ItemVO);
		} //end of for row

		//rowFor : sheetSentence
		for(Row row : sheetSentence) {
			if(row.getRowNum() == 0){continue;}
			SentenceVO SentenceVO = new SentenceVO();
			for(Cell cell : row){
				String value = "";
				CellReference cellRef = new CellReference(row.getRowNum(), cell.getColumnIndex());
				//가능하면 String으로 받음. 날짜 또한 날짜형식으로 오면 String으로 바꾸고 숫자형식도 String으로 바꿈.
				switch (cell.getCellType()) {
				case Cell.CELL_TYPE_STRING:
					value = cell.getRichStringCellValue().getString();
					break;
				case Cell.CELL_TYPE_NUMERIC:
					if (DateUtil.isCellDateFormatted(cell)) {
						SimpleDateFormat df = new SimpleDateFormat("yyyymmdd");
						value = df.format(cell.getDateCellValue());
					} else {
						value = String.valueOf(Math.round(cell.getNumericCellValue()));
					}
					break;
				case Cell.CELL_TYPE_FORMULA:
					value = cell.getCellFormula();
					break;
				case Cell.CELL_TYPE_BLANK:
					value = "";
					break;
				case Cell.CELL_TYPE_ERROR:
					break;
				default:
					break;
				} //end of switch

				value = subString(value, 0, 200);
				String colValue = subString(cellRef.formatAsString(), 0, 1);

				//첫번째 줄은 제목이므로 뛰어넘음.
				//if (rowValue.equals("1")) { continue rowFor;}
				//cell A,B,C,D,E,F,G,H,I,J,K 이외는 무시
				//시트2 문항
				if(value != null && value != ""){
					if (colValue.equals("A")){
						SentenceVO.setItemNm(value);
					}else if (colValue.equals("B")){
						SentenceVO.setSentenceSeq(Integer.parseInt(value));
					}else if (colValue.equals("C")){
						SentenceVO.setSentence(value);
					}
				}
			} //end of for cell
			SentenceVOList.add(SentenceVO);
		} //end of for row

		QuestionVO.setItems(ItemVOList);
		QuestionVO.setSentences(SentenceVOList);
		wb.close();
		return QuestionVO;
	}

	/**
	 * 엑셀파일 업로드 [.xls] 기능  / 97-2003 엑셀파일 (.xls)
	 * @param excel - InputStream
	 * @return
	 * @exception Exception
	 */
	public QuestionVO ExcelParse_xls(final InputStream excel, QuestionVO question) throws Exception {
		String message="";
		QuestionVO QuestionVO = question;
		List<ItemVO> ItemVOList = new ArrayList<ItemVO>();
		List<SentenceVO> SentenceVOList = new ArrayList<SentenceVO>();

		Workbook wb = new HSSFWorkbook(excel);
		Sheet sheetItem = wb.getSheetAt(0);
		Sheet sheetSentence = wb.getSheetAt(1);

		//rowFor : sheetItem
		for(Row row : sheetItem) {
			if(row.getRowNum() == 0){continue;}
			ItemVO ItemVO = new ItemVO();
			for(Cell cell : row){
				String value = "";
				CellReference cellRef = new CellReference(row.getRowNum(), cell.getColumnIndex());
				//가능하면 String으로 받음. 날짜 또한 날짜형식으로 오면 String으로 바꾸고 숫자형식도 String으로 바꿈.
				switch (cell.getCellType()) {
				case Cell.CELL_TYPE_STRING:
					value = cell.getRichStringCellValue().getString();
					break;
				case Cell.CELL_TYPE_NUMERIC:
					if (DateUtil.isCellDateFormatted(cell)) {
						SimpleDateFormat df = new SimpleDateFormat("yyyymmdd");
						value = df.format(cell.getDateCellValue());
					} else {
						value = String.valueOf(Math.round(cell.getNumericCellValue()));
					}
					break;
				case Cell.CELL_TYPE_FORMULA:
					value = cell.getCellFormula();
					break;
				case Cell.CELL_TYPE_BLANK:
					value = "";
					break;
				case Cell.CELL_TYPE_ERROR:
					break;
				default:
					break;
				} //end of switch

				value = subString(value, 0, 100);
				String colValue = subString(cellRef.formatAsString(), 0, 1);

				//첫번째 줄은 제목이므로 뛰어넘음.
				//if (rowValue.equals("1")) { continue rowFor;}
				//cell A,B,C,D,E,F,G,H,I,J,K 이외는 무시
				if(value != null && value != ""){
					if (colValue.equals("A")){
						ItemVO.setItemSeq(Integer.parseInt(value));
					}else if (colValue.equals("B")){
						ItemVO.setItemNm(value);
					}else if (colValue.equals("C")){ //이부분 없는것 같아서 내가 적어줌
						ItemVO.setItemDec(value);
					}
				}
			} //end of for cell
			ItemVOList.add(ItemVO);
		} //end of for row

		//rowFor : sheetSentence
		for(Row row : sheetSentence) {
			if(row.getRowNum() == 0){continue;}
			SentenceVO SentenceVO = new SentenceVO();
			for(Cell cell : row){
				String value = "";
				CellReference cellRef = new CellReference(row.getRowNum(), cell.getColumnIndex());
				//가능하면 String으로 받음. 날짜 또한 날짜형식으로 오면 String으로 바꾸고 숫자형식도 String으로 바꿈.
				switch (cell.getCellType()) {
				case Cell.CELL_TYPE_STRING:
					value = cell.getRichStringCellValue().getString();
					break;
				case Cell.CELL_TYPE_NUMERIC:
					if (DateUtil.isCellDateFormatted(cell)) {
						SimpleDateFormat df = new SimpleDateFormat("yyyymmdd");
						value = df.format(cell.getDateCellValue());
					} else {
						value = String.valueOf(Math.round(cell.getNumericCellValue()));
					}
					break;
				case Cell.CELL_TYPE_FORMULA:
					value = cell.getCellFormula();
					break;
				case Cell.CELL_TYPE_BLANK:
					value = "";
					break;
				case Cell.CELL_TYPE_ERROR:
					break;
				default:
					break;
				} //end of switch

				value = subString(value, 0, 200);
				String colValue = subString(cellRef.formatAsString(), 0, 1);

				//첫번째 줄은 제목이므로 뛰어넘음.
				//if (rowValue.equals("1")) { continue rowFor;}
				//cell A,B,C,D,E,F,G,H,I,J,K 이외는 무시
				if(value != null && value != ""){
					if (colValue.equals("A")){
						SentenceVO.setItemNm(value);
					}else if (colValue.equals("B")){
						SentenceVO.setSentenceSeq(Integer.parseInt(value));
					}else if (colValue.equals("C")){
						SentenceVO.setSentence(value);
					}
				}
			} //end of for cell
			SentenceVOList.add(SentenceVO);
		} //end of for row

		QuestionVO.setItems(ItemVOList);
		QuestionVO.setSentences(SentenceVOList);

		return QuestionVO;
	}

	@Transactional(rollbackFor={Exception.class})
	public Boolean setQuestion(QuestionVO questionVO) throws Exception {

		SimpleDateFormat cvVer = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA);
		SimpleDateFormat cvRegDt = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		Date d = new Date();
		String cvVerStr = cvVer.format(d);
		String cvRegDtStr = cvRegDt.format(d);

		questionVO.setVersion(cvVerStr);
		questionVO.setRegistryDt(cvRegDtStr);

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("version", cvVerStr);
		paramMap.put("Items", questionVO.getItems());
		paramMap.put("Sentences", questionVO.getSentences());

		System.out.println("name="+questionVO.getName());
		System.out.println("version="+questionVO.getVersion());
		System.out.println("registryDt="+questionVO.getRegistryDt());

		for(int i=0 ; i<questionVO.getItems().size() ; i++)
			System.out.println(questionVO.getItems().get(i).getItemNm());

		for(int i=0 ; i<questionVO.getSentences().size() ; i++)
			System.out.println(questionVO.getSentences().get(i).getSentence());

		int chkReg = dao.setQuestion(questionVO);
		int chkItem = dao.setItems(paramMap);
		int chkSentence = dao.setSentences(paramMap);

		if(chkReg > 0 && chkItem > 0 && chkSentence > 0){
			return true;
		}else{
			return false;
		}


	}


}
