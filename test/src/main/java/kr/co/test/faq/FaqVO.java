package kr.co.test.faq;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter	@Setter
public class FaqVO {
	private int id;
	private String question, answer;
	private Date writedate;
}
