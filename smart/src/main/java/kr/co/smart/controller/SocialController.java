package kr.co.smart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller @RequestMapping("/member")
public class SocialController {

	//네이버 로그인처리 요청
	@RequestMapping("/naverLogin")
	public void naverLogin() {
		
	}
}