package com.project.investigation.manager;

import java.io.File;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/*
 * 관리자 전용 컨트롤러
 * 설문 등록(엑셀 파일), 설문 출제를 할 수 있다.
 * 통계 보기는 statistics 에서 처리한다.
 */

@Controller
@RequestMapping("/manager")
public class ManagerController {

	/*
	 * 설문 목록
	 * 설문 목록을 가져와
	 */
	@GetMapping("/registry")
	public ModelAndView questionList(){

		//List<CvQuestionVO> cvQuestionList = managerService.getQuestionRegistryList();

		ModelAndView response = new ModelAndView("/manager/registry");

		//response.addObject("cvQuestionList", cvQuestionList);
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
}
