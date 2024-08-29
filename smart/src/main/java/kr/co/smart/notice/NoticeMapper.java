package kr.co.smart.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoticeMapper {
	// CRUD
	int registerNotice(NoticeVO vo);	// 신규 공지글 등록
	List<NoticeVO> getListOfNotice();	// 공지글 목록조회
	NoticeVO getOneNotice(int id);		// 공지글 정보조회
	int updateNotice(NoticeVO vo);		// 공지글 정보변경저장
	int deleteNotice(int id);			// 공지글 정보삭제
	int updateReadCount(int id);		// 조회수 변경
}
