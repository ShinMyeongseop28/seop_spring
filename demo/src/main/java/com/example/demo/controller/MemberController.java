package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.member.MemberVO;

@Controller
public class MemberController {
	
	//로그인처리 요청
	@RequestMapping("/loginResult")
	public String login(String userid, String userpw) {
		//아이디:hong, 비번:1234 인 경우만 로그인되게
		//일치하는 경우: 로그인성공 -> 홈으로
		//일치하지 않는 경우: 로그인실패 -> 로그인화면으로
		if(userid.equals("hong") && userpw.equals("1234")) {
			//return "index"; //forward
			return "redirect:/";
		}else {
			//return "member/login"; //forward
			return "redirect:login";
		}
	}
	
	//로그인화면 요청
	@RequestMapping("/login")
	public String login() {
		return "member/login";
	}
	
	//회원가입 요청 파라미터 접근
	//3. @ModelAttribute :
	@RequestMapping("/joinModel")
	public String join(@ModelAttribute MemberVO vo, Model model) {
		model.addAttribute("vo", vo);
		model.addAttribute("method", "@ModelAttribute 접근");
		return "member/info";
	}
	
	//2. @RequestParam
	@RequestMapping("/joinParam")
	public String join(String name, @RequestParam("gender") String g, 
			int age, Model model) {
		model.addAttribute("method", "@RequestParam 접근");
		model.addAttribute("name", name);
		model.addAttribute("gender", g);
		model.addAttribute("age", age);
		return "member/info";
	}
	
	//1. HttpServletRequest
	@RequestMapping("/joinRequest")
	public String join(Model model, HttpServletRequest request) {
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		int age = Integer.parseInt(request.getParameter("age"));
		
		model.addAttribute("method", "HttpServletRequest 접근");
		model.addAttribute("name", name);
		model.addAttribute("gender", gender);
		model.addAttribute("age", age);
		return "member/info";
	}
	
	//회원가입화면요청
	@RequestMapping("/member")
	public String member() {
		return "member/join";
	}
}
