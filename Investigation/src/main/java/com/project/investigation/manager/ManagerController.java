package com.project.investigation.manager;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.investigation.VO.DepartmentVO;
import com.project.investigation.VO.ItemVO;
import com.project.investigation.VO.QuestionStateVO;
import com.project.investigation.VO.QuestionVO;
import com.project.investigation.VO.SameVersionVO;
import com.project.investigation.VO.SentenceVO;


/*
 * 관리자 전용 컨트롤러
 * 설문 등록(엑셀 파일), 설문 출제를 할 수 있다.
 * 통계 보기는 statistics 에서 처리한다.
 */

@Controller
@RequestMapping("/manager")
public class ManagerController {

	@Autowired
	private QuestionService uploadQuestionService;

	@Autowired
	private ManagerService managerService;

	/*
	 * 설문 목록
	 * 설문 목록을 가져와
	 */
	@GetMapping("/registry")
	public ModelAndView questionList(){

		List<QuestionVO> questionList = managerService.getQuestionRegistryList();
		ModelAndView response = new ModelAndView("/manager/registry");
		response.addObject("QuestionList", questionList);
		return response;
	}


	//설문 양식 다운로드
	@GetMapping("/sampledownload")
	public void SampleDownload(HttpServletResponse response) throws Exception{

		File file = new ClassPathResource("excelfiles/test.xlsx").getFile();
		//new FileSystemResource
		byte fileByte[] = FileUtils.readFileToByteArray(file);

		if(fileByte.length == 0) {

		}
		else {

			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition", "attachment; fileName=test.xlsx");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}

	//설문 Excel 등록
	//@RequestMapping(value="/question/registry/excel", method=RequestMethod.POST, produces="text/plain; charset=UTF-8")
	//@Secured("ROLE_CC")
	@PostMapping("/excelregistry")
	@ResponseBody
	public ResponseEntity<String> questionExcelRegistry(@RequestParam(value="excelFile") MultipartFile excelFile,
			@RequestParam(value="titleNm") String titleNm) throws Exception{

		String fileName = excelFile.getOriginalFilename();
		//fileName = new String(fileName.getBytes("8859_1"), "utf-8");
		//String titleName = new String(titleNm.getBytes("8859_1"), "utf-8");

		QuestionVO question = new QuestionVO();
		question.setName(titleNm);

		/*
		 * 엑셀 파일 시그니처
		 *  50 4B 03 04
		 *   FD FF FF FF
		 *   D0 CF 11 E0
		 *   이렇게 3개 검사해서, 해당 파일이 엑셀파일인지 아닌지 확인하는 보안 코드 나중에 작성
		 */

		if (fileName.indexOf(".xlsx") > -1) {
			question = uploadQuestionService.ExcelParse_xlsx(excelFile.getInputStream(), question);
		}
		else if(fileName.indexOf(".xls") > -1) {
			question = uploadQuestionService.ExcelParse_xls(excelFile.getInputStream(), question);
		}


		Boolean checkService = uploadQuestionService.setQuestion(question);

		if(checkService != null && checkService){
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}else{
			return new ResponseEntity<String>("false", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	//설문 세부내용
	//@Secured("ROLE_CC")
	@PostMapping("/registry/detail")
	@ResponseBody
	public List<SentenceVO> questionDetail(@RequestParam(value="version") String version){
		List<SentenceVO> sentencceList = managerService.getQuestionSentenceList(version);

		return sentencceList;
	}

	@GetMapping("/making")
	public ModelAndView questionMaking() throws Exception{

		//List<DepartmentVO> departList = managerService.getAllDepartment();
		ModelAndView response = new ModelAndView("/manager/making");

		List<DepartmentVO> levelOne = managerService.getLevelDepartment(1);
		response.addObject("LevelOne", levelOne);
		List<DepartmentVO> leveltwo = managerService.getLevelDepartment(2);
		response.addObject("LevelTwo", leveltwo);
		List<DepartmentVO> levelThree = managerService.getLevelDepartment(3);
		response.addObject("LevelThree", levelThree);

		List<QuestionVO> questionList = managerService.getQuestionRegistryList();
		response.addObject("QuestionList", questionList);
		return response;

	}

	@PostMapping(value="/making/input", produces="application/json; charset=UTF-8")
	//@ResponseBody
	public String QuestionMaking(@RequestBody QuestionStateVO questionStateVO) throws Exception{

		String jsonResult;
		Boolean check = managerService.setQuestionMaking(questionStateVO);

		if(check==true) {
			jsonResult = "{\"state\": \"success\"}" ;
		}else {
			jsonResult = "{\"state\": \"false\"}" ;
		}
		return jsonResult;
	}

	@GetMapping("/progress")
	public ModelAndView Progress() {

		ModelAndView response = new ModelAndView("/manager/progress");
		List<QuestionStateVO> list = managerService.getAllDetailList();

		response.addObject("QuestionList",list);
		return response;
	}

	@GetMapping("/statisticseq")
	public ModelAndView Statistic() {

		ModelAndView response = new ModelAndView("/manager/statisticseq");
		List<QuestionStateVO> list = managerService.getAllList();

		response.addObject("QuestionList",list);
		return response;
	}

	@GetMapping("/itemstatistic")
	public ModelAndView Itemstatistic(@RequestParam(value = "stateSeq", required = false) String stateSeq,
			@RequestParam(value = "version", required = false) String version) {

		int seq = Integer.parseInt(stateSeq);
		ModelAndView response = new ModelAndView("/manager/itemstatistic");

		//버전에 해당하는 item들 가져와야함 문자열로
		List<ItemVO> items = managerService.getQuestionItemList(version);
		String itemString ="";

		for(int i=0 ; i<items.size() ; i++) {
			if(i==0) {
				itemString = itemString+items.get(i).getItemNm();
			}else {
				itemString = itemString + ","+ items.get(i).getItemNm();
			}
		}
		response.addObject("ItemString", itemString);

		//item 평균 가져와 문자열로 만들기
		String itemAvg = "";
		double[] arr = managerService.getItemAvg(seq, version);
		for(int i=0 ; i<arr.length ; i++) {
			if(i==0) {
				itemAvg = itemAvg+arr[i];
			}else {
				itemAvg = itemAvg + ","+ arr[i];
			}
		}
		response.addObject("ItemAvgStr", itemAvg);
		response.addObject("StateSeq",stateSeq);
		response.addObject("Version",version);
		return response;

	}

	@GetMapping("/sentencestatistic")
	public ModelAndView Sentencestatistic(@RequestParam(value = "stateSeq", required = false) String stateSeq,
			@RequestParam(value = "version", required = false) String version) {

		//문항 이름 가져와야함-> 필요없음 그냥 1번 2번 하면 됨
		int seq = Integer.parseInt(stateSeq);
		int arr[][] = managerService.getSentenceVal(seq, version);
		List<String> answerList = new ArrayList<String>();

		for(int i=0 ; i<arr.length ;i++) {
			String temp = "";
			for(int j=0 ; j<arr[0].length ; j++) {
				if(j==0) {
					temp = temp + arr[i][j];
				}else {
					temp = temp + ","+ arr[i][j];
				}
			}
			answerList.add(temp);
		}
		int answerCount = managerService.getAnswerCount2(seq);
		ModelAndView response = new ModelAndView("/manager/sentencestatistic");
		response.addObject("AnswerList", answerList);
		response.addObject("StateSeq",stateSeq);
		response.addObject("Version",version);
		response.addObject("SentenceLength",arr.length);
		response.addObject("SentenceCount",arr[0].length);
		response.addObject("AnswerCount",answerCount);
		return response;
	}

	@GetMapping("/statistidepart")
	public ModelAndView Comparedepart(@RequestParam(value = "stateSeq", required = false) String stateSeq,
			@RequestParam(value = "version", required = false) String version) {

		ModelAndView response = new ModelAndView("/manager/statistidepart");

		int seq = Integer.parseInt(stateSeq);

		List<DepartmentVO> targetDepart = managerService.getTargetDepart(seq);

		//버전에 해당하는 item들 가져와야함 문자열로
		List<ItemVO> items = managerService.getQuestionItemList(version);
		String itemString ="";

		for(int i=0 ; i<items.size() ; i++) {
			if(i==0) {
				itemString = itemString+items.get(i).getItemNm();
			}else {
				itemString = itemString + ","+ items.get(i).getItemNm();
			}
		}
		response.addObject("ItemString", itemString);

		response.addObject("TargetDepart", targetDepart);
		response.addObject("stateSeq",stateSeq);
		response.addObject("version", version);
		return response;
	}

	@GetMapping("/selectdepart")
	@ResponseBody
	public Map<String, Object> SelectDepart(@RequestParam(value = "stateSeq", required = false) String stateSeq,
			@RequestParam(value = "departCode", required = false) String departCode,
			@RequestParam(value = "cate", required = false) String cate,
			@RequestParam(value = "version", required = false) String version) {

		int seq = Integer.parseInt(stateSeq);
		int category = Integer.parseInt(cate);
		String itemAvg = "";
		Map<String, Object> tempMap = new HashMap<String, Object>();

		if(category==1) { //항목별->비교 가능한 부서들도 맵에 포함시켜야함
			double[] arr = managerService.getDepartItemAvg(seq, version, departCode);
			for(int i=0 ; i<arr.length ; i++) {
				if(i==0) {
					itemAvg = itemAvg+arr[i];
				}else {
					itemAvg = itemAvg + ","+ arr[i];
				}
			}
			tempMap.put("ItemAvgStr", itemAvg);
			List<DepartmentVO> list = managerService.getTargetOtherDepart(seq, departCode);
			tempMap.put("OtherDepart", list);

		}else;

		return tempMap;
	}

	@GetMapping("/selectcomparedepart")
	@ResponseBody
	public String SelectCompareDepart(@RequestParam(value = "stateSeq", required = false) String stateSeq,
			@RequestParam(value = "selectCode", required = false) String selectCode,
			@RequestParam(value = "version", required = false) String version){

		int seq = Integer.parseInt(stateSeq);
		String itemAvg = "";


		double[] arr = managerService.getDepartItemAvg(seq, version, selectCode);
		for(int i=0 ; i<arr.length ; i++) {
			if(i==0) {
				itemAvg = itemAvg+arr[i];
			}else {
				itemAvg = itemAvg + ","+ arr[i];
			}
		}

		return itemAvg;
	}

	@GetMapping("/sentencedpart")
	@ResponseBody
	public Map<String, Object> SentenceDepart(@RequestParam(value = "stateSeq", required = false) String stateSeq,
			@RequestParam(value = "departCode", required = false) String departCode,
			@RequestParam(value = "cate", required = false) String cate,
			@RequestParam(value = "version", required = false) String version){

		List<String> answerList = new ArrayList<>();
		int seq = Integer.parseInt(stateSeq);
		int category = Integer.parseInt(cate);
		int arr[][] = managerService.getDepartAns(seq, version, departCode);

		for(int i=0 ; i<arr.length ;i++) {
			String temp = "";
			for(int j=0 ; j<arr[0].length ; j++) {
				if(j==0) {
					temp = temp + arr[i][j];
				}else {
					temp = temp + ","+ arr[i][j];
				}
			}
			answerList.add(temp);
		}
		int answerCount = managerService.getAnswerCount4(seq, version, departCode);

		Map<String, Object> tempMap = new HashMap<String, Object>();
		tempMap.put("answerList", answerList);
		tempMap.put("answerCount", answerCount);
		tempMap.put("SentenceLength",arr.length);
		tempMap.put("SentenceCount",arr[0].length);

		return tempMap;
	}

	@GetMapping("/compare")
	@ResponseBody
	public Map<String, Object> Compareseq(@RequestParam(value = "selectSeq", required = false) String selectSeq,
			@RequestParam(value = "version", required = false) String version) {
		int seq = Integer.parseInt(selectSeq);
		Map<String, Object> tempMap = new HashMap<String, Object>();
		String itemAvg = "";

		double[] arr = managerService.getItemAvg(seq, version);
		for(int i=0 ; i<arr.length ; i++) {
			if(i==0) {
				itemAvg = itemAvg+arr[i];
			}else {
				itemAvg = itemAvg + ","+ arr[i];
			}
		}
		tempMap.put("ItemAvgStr", itemAvg);
		tempMap.put("SelectSeq", selectSeq);
		return tempMap;
	}

	@GetMapping("/sameversion")
	@ResponseBody
	public List<SameVersionVO> SameVersionList2(@RequestParam(value = "stateSeq", required = false) String stateSeq,
			@RequestParam(value = "version", required = false) String version) {

		int seq = Integer.parseInt(stateSeq);

		List<SameVersionVO> same = managerService.getSameVersion2(seq, version);

		return same;

	}

	@GetMapping("selectsentence")
	@ResponseBody
	public int[] SelectSentence(@RequestParam(value = "selectSen", required = false) String selectSen,
			@RequestParam(value = "stateSeq", required = false) String stateSeq) {


		int seq = Integer.parseInt(stateSeq);
		int select = Integer.parseInt(selectSen);

		int[] arr = managerService.getSelectSentence(seq, select);


		return arr;

	}
}
