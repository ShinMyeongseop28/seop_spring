package kr.co.smart.controller;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.smart.auth.LoginUser;
import kr.co.smart.common.CommonUtility;
import kr.co.smart.member.MemberMapper;
import kr.co.smart.member.MemberVO;
import lombok.RequiredArgsConstructor;

@Controller @RequiredArgsConstructor @RequestMapping("/member")
public class MemberController {
	private final CommonUtility common;
	private final MemberMapper mapper;
	private final PasswordEncoder password;
	
	@Value("${smart.files}")
	private String filesPath;
	
	// Principal : 접근주체인 UserDetails (LoginUser)
	// 내정보 변경저장 처리 요청
	@PutMapping("/user/myPage/modify")
	public String myPage( @AuthenticationPrincipal LoginUser principal,
			MemberVO vo, boolean img, MultipartFile file, HttpSession session, HttpServletRequest request) {
		// 원래 프로필정보를 조회해오기
		MemberVO user = mapper.getOneMember(vo.getUserid());
		
		// 프로필을 첨부하지 않은 경우
		if( file.isEmpty() ) {
			// 원래X -> 화면imgX -> 처리X
			// 원래O -> 화면imgO -> DB저장할 vo에 담기
			// 원래O -> 화면프로필삭제:화면imgX -> 물리적파일 삭제
			if( img ) {
				vo.setProfile( user.getProfile() );
			}
		} else {
			// 프로필을 첨부한 경우
			// 원래X -> 새로첨부 -> DB저장할 vo의 profile에 담기
			// 원래O -> 바꿔첨부 -> DB저장할 vo의 profile에 담기 + 물리적파일 삭제
			vo.setProfile( common.fileUpload("profile", file, request));
		}
		
		// 화면에서 입력한 정보로 DB에 변경저장
		// 변경된 정보가 화면에 반영되도록 세션 정보를 변경하기
		if( mapper.updateMember(vo)==1 ) {
			// 물리적파일 삭제
			// 원래O -> 화면imgX -> 물리적파일 삭제
			// 원래O -> 바꿔첨부 -> DB저장할 vo의 profile에 담기 + 물리적파일 삭제
			if( user.getProfile() != null ) {
				if( !img || !file.isEmpty() ) {
					common.fileDelete(user.getProfile(), request);
				}
			}
			
			principal.setUser(vo);
		}
		return "redirect:/";
	}
	
	// MyPage 화면 요청
	@RequestMapping("/user/myPage")
	public String myPage(@AuthenticationPrincipal LoginUser user,
			HttpSession session, Model model) {
		session.setAttribute("category", "my");
		
		// 로그인한 사용자 정보를 조회해오기
		String userid = user.getUsername();
		model.addAttribute("vo", mapper.getOneMember(userid));
		return "member/myPage";
	}
	
	// 회원가입처리 요청
	@ResponseBody @RequestMapping("/register")
	public String join(MultipartFile file, MemberVO vo, HttpServletRequest request) {
		// 프로필 이미지 첨부한 경우
		if( ! file.isEmpty() ) {
			vo.setProfile( common.fileUpload("profile", file, request) );
		}
		
		// 입력비번 암호화하기
		vo.setUserpw( password.encode(vo.getUserpw()) );
		// 화면에서 입력한 정보로 DB에 회원정보저장 처리 -> 로그인/회원가입화면으로 연결
		StringBuffer msg = new StringBuffer("<script>");
		
		if( mapper.registerMember(vo) == 1 ) {
			// 회원가입축하 메시지를 이메일로 보내기
			common.emailForJoin(vo, new File( filesPath + "[무료 자료]Do it! 안드로이드 앱 프로그래밍_개정8판_미리보기.pdf" ).getPath());
			
			msg.append("alert('회원가입을 축하합니다^^'); ");
			msg.append("location='login'; ");
			//return "redirect:login";
		} else {
			msg.append("alert('회원가입 실패ㅠㅠ'); ");
			msg.append("location='join'; ");
			//return "redirect:join";
		}
		msg.append("</script>");
		return msg.toString();
	}
	
	// 아이디 중복확인 요청
	@ResponseBody @RequestMapping("/idCheck")
	public boolean idCheck(String userid) {
		return mapper.getOneMember(userid)==null ? true : false;
	}
	
	// 회원가입화면 요청
	@RequestMapping("/join")
	public String join(HttpSession session) {
		session.setAttribute("category", "join");
		return "default/member/join";
	}
	
	// 새 비밀번호로 변경저장 처리 요청
	@ResponseBody @RequestMapping("/user/resetPassword")
	public boolean resetPassword(@AuthenticationPrincipal LoginUser user,
			MemberVO vo, String userpw) {
		//MemberVO의 id: park, pw: asd123A
		vo.setUserpw( password.encode(userpw) ); // 입력비번을 암호화하기
		return mapper.updatePassword(vo)==1 ? true : false;
	}
	
	// 현재 입력한 비번이 정확한지 확인 요청
	@ResponseBody @RequestMapping("/user/correctPassword")
	public boolean correctPassword(@AuthenticationPrincipal LoginUser user,
			String userid, String userpw) {
		//입력한 비번이 DB의 비번과 일치하는지
		MemberVO vo = mapper.getOneMember(user.getUsername());
		return password.matches(userpw, vo.getUserpw());
	}
	
	// 비밀번호 변경 화면 요청
	@RequestMapping("/user/changePassword")
	public String changePassword(HttpSession session) {
		session.setAttribute("category", "change");
		return "member/change";
	}
	
	// 임시 비밀번호 발급처리 요청
	@ResponseBody @RequestMapping("/tempPassword")
	public String tempPassword(MemberVO vo) {
		//화면에서 입력한 아이디와 이메일이 일치하는 회원에게
		vo = mapper.getOneMemberByUseridAndEmail(vo);
		StringBuffer msg = new StringBuffer("<script>");
		if( vo == null ) {
			msg.append("alert('아이디나 이메일이 맞지 않습니다. \\n확인하세요!');");
			msg.append("location='findPassword'");
		}else {
			//임시비번을 생성한 후 회원정보에 변경저장, 임시비번을 이메일로 알려주기
			String pw = UUID.randomUUID().toString().substring(0, 6); 
			vo.setUserpw( password.encode(pw) ); //임시비번을 암호화하여 담기
			
			//DB에 변경저장하기
			if( mapper.updatePassword(vo)==1 && common.emailForPassword(vo, pw)) {
				//발급한 임시비번을 메일로 보내기 -> 임시비번을 사용해 로그인하도록 로그인화면 연결
				msg.append("alert('임시 비밀번호가 발급되었습니다. \\n이메일을 확인하세요');");
				msg.append("location='login'");
			}else {
				msg.append("alert('임시 비밀번호 발급 실패ㅠㅠ'); ");
				msg.append("location='findPassword'");
			}
		}
		msg.append("</script>");
		return msg.toString();
	}
	
	// 비밀번호찾기 화면 요청
	@RequestMapping("/findPassword")
	public String findPassword(HttpSession session) {
		session.setAttribute("category", "find");
		return "default/member/find";
	}
	
	// 로그인 처리 요청
	// @ResponseBody @RequestMapping("/smartLogin")
	public String login(String userid, String userpw, HttpServletRequest request, HttpSession session) {
		//화면에서 입력한 아이디/비번이 일치하는 회원정보 조회하기
		MemberVO vo = mapper.getOneMember(userid);
		boolean match = false;
		if(vo != null) {
			//해당 아이디의 회원정보가 있는 경우만 입력비번과 DB의 암호화된 비번의 일치여부 확인
			match = password.matches(userpw, vo.getUserpw());
		}
		
		StringBuffer msg = new StringBuffer("<script>");
		if(match) {
			//로그인된 경우 - 웰컴페이지로 연결
			//return "redirect:/";
			msg.append("location='").append(common.appURL(request)) .append("'");
			//로그인정보를 session에 저장하기
			session.setAttribute("loginInfo", vo);
		}else {
			//로그인되지 않은 경우 - 로그인페이지로 연결
			//return "redirect:login";
			msg.append("alert('아이디나 비밀번호가 일치하지 않습니다');");
			msg.append("location='login'");	
		}

		msg.append("</script>");
		return msg.toString();
	}
	
	// 로그인 실패 처리
	@ResponseBody @RequestMapping("/login/fail")
	public String loginFail(HttpServletRequest request) {
		StringBuffer msg = new StringBuffer("<script>");
		msg.append("alert('아이디나 비밀번호가 일치하지 않습니다');");
		msg.append("location='").append(common.appURL(request, "/member/login")).append("'");
		msg.append("</script>");
		return msg.toString();
	}
	
	// 로그인 화면 요청
	@RequestMapping("/login")
	public String login(HttpSession session, boolean redirect, HttpServletRequest request) {
		session.setAttribute("category", "login");
		
		if( redirect ) {
			//http://localhost/smart/board/info?id=1&pageNo=1...
			StringBuffer url = new StringBuffer( request.getHeader("referer") );
			if( ! request.getHeader("referer").contains("?") ) {
				url.append("?");
				for( String key : request.getParameterMap().keySet() ) {
					if( key.equals("redirect") ) continue;
					url.append(key).append("=").append( request.getParameter(key) ).append("&");
				}
				url.deleteCharAt( url.length()-1 );
			}
			session.setAttribute("savedURL", url.toString());
		}
		
		return "default/member/login";
	}
}
