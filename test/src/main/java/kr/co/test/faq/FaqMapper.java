package kr.co.test.faq;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FaqMapper {
	// CRUD
	int registerFaq(FaqVO vo);		// 신규 질문 등록
	List<FaqVO> getListOfFaq();		// 질문글 목록조회
	FaqVO getOneFaq(int id);		// 질문글 정보조회
	int updateFaq(FaqVO vo);		// 질문글 변경저장
	int deleteFaq(int id);			// 질문글 삭제요청
}
