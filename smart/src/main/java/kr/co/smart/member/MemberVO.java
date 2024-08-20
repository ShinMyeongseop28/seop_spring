package kr.co.smart.member;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class MemberVO {
	private String name, userid, userpw, gender, email, profile,
				   birth, phone, post, address1, address2, social;
}
