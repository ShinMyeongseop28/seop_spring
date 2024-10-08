package kr.co.smart.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.smart.common.PageVO;

@Mapper
public interface NoticeMapper {
	// CRUD
	int registerNotice(NoticeVO vo);			// 신규 공지글 등록
	List<NoticeVO> getListOfNotice();			// 공지글 목록조회
	NoticeVO getOneNotice(int id);				// 공지글 정보조회
	int updateNotice(NoticeVO vo);				// 공지글 정보변경저장
	int deleteNotice(int id);					// 공지글 정보삭제
	int updateReadCount(int id);				// 조회수 변경
	
	List<Object> getListOfNotice(PageVO page);	// 공지글 목록조회
	int countOfNotice(PageVO page);				// 공지글 총건수조회
	
	int registerReply(NoticeVO vo);				// 신규 답글저장
}
