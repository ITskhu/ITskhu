package com.project.investigation;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.project.investigation.board.BoardService;

@Component
public class Schedule {

	@Autowired
	private BoardService boardService;

	@Scheduled(cron="0 0 23 * * *")
	public void DataSchedule() {

		SimpleDateFormat test = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		Date d = new Date();
		String date = test.format(d);

		boardService.setQuestionState(date);

	}
}
