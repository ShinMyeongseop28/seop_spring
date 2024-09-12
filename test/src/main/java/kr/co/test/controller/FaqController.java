package kr.co.test.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.test.faq.FaqMapper;
import kr.co.test.faq.FaqVO;
import lombok.RequiredArgsConstructor;

@Controller	@RequestMapping("/faq") @RequiredArgsConstructor
public class FaqController {
	
	private final FaqMapper mapper;
	
	// 질문글 삭제처리 요청
	@RequestMapping("/delete")
	public String delete(int id) {
		// DB에서 선택한 질문글 삭제
		mapper.deleteFaq(id);
		
		return "redirect:list";
	}
	
	// 신규 질문글 저장처리 요청
	@PostMapping("/register")
	public String register(FaqVO vo) {
		// 화면에서 입력한 정보로 DB에 신규저장
		mapper.registerFaq(vo);
		
		return "redirect:list";
	}
	
	// 신규 질문글 등록화면 요청
	@GetMapping("/register")
	public String register() {
		
		return "faq/register";
	}
	
	// 질문글 수정저장처리 요청
	@PostMapping("/update")
	public String update(FaqVO vo) {
		// 화면에서 변경한 정보를 DB에 저장
		mapper.updateFaq(vo);
		
		return "redirect:info?id=" + vo.getId();
	}
	
	// 선택한 질문글 수정화면 요청
	@RequestMapping("/modify")
	public String modify(int id, Model model) {
		// 선택한 질문글 정보를 DB에서 조회해오기
		FaqVO vo = mapper.getOneFaq(id);
		// -> 수정화면에 출력할 수 있도록 Model 객체에 저장하기
		model.addAttribute("vo", vo);
		
		return "faq/modify";
	}
	
	// 선택한 질문글 화면 요청
	@RequestMapping("/info")
	public String info(int id, Model model) {
		// 선택한 질문글 정보를 DB에서 조해해오기 -> 화면에 출력할 수 있도록 Model 객체에 담기
		FaqVO vo = mapper.getOneFaq(id);
		model.addAttribute("vo", vo);
		
		return "faq/info";
	}
	
	// 질문글 화면 요청
	@RequestMapping("/list")
	public String list(Model model) {
		// DB에서 질문글 목록을 조회해오기 -> 화면에 출력할 수 있도록 Model 객체에 담기
		List<FaqVO> list = mapper.getListOfFaq();
		model.addAttribute("list", list);
		
		return "faq/list";
	}
}
