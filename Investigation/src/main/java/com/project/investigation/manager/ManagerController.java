package com.project.investigation.manager;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.investigation.VO.QuestionVO;


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
			System.out.println("파일 다운로드 실패");
		}
		else {
			System.out.println("파일 다운로드 성공");
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
	//@ResponseBody
	public ResponseEntity<String> questionExcelRegistry(@RequestParam(value="excelFile") MultipartFile excelFile,
			@RequestParam(value="titleNm") String titleNm) throws Exception{


		String fileName = excelFile.getOriginalFilename();
		//fileName = new String(fileName.getBytes("8859_1"), "utf-8");
		//String titleName = new String(titleNm.getBytes("8859_1"), "utf-8");

		System.out.println("파일 이름="+fileName );
		System.out.println("파일 사이즈="+excelFile.getSize());
		System.out.println("타입="+excelFile.getContentType());
		System.out.println("titleName="+titleNm);

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
			return new ResponseEntity<String>("false", HttpStatus.BAD_REQUEST);
		}

		/*
		ResponseEntity<String> entity = null;

		if(excelFile.getSize() != 0)
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		else
			entity = new ResponseEntity<String>("false", HttpStatus.BAD_REQUEST);

		System.out.println(entity.toString());

		return entity;
		 */

		/*
		if (fileName.indexOf(".xlsx") > -1) {
			cvQuestion = uploadQuestionService.ExcelParse_xlsx(excelFile.getInputStream(), cvQuestion);
		}else if(fileName.indexOf(".xls") > -1) {
			cvQuestion = uploadQuestionService.ExcelParse_xls(excelFile.getInputStream(), cvQuestion);
		}

		Boolean checkService = uploadQuestionService.setQuestion(cvQuestion);
		if(checkService != null && checkService){
			return new SimpleApiResponse(true, "정상적으로 처리되었습니다.");
		}else{
			return new SimpleApiResponse(false, "처리 중 오류가 발생했습니다.");
		}
		 */
	}
}
