package com.kh.hana.group.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.group.model.vo.GroupMemberList;
import com.kh.hana.group.model.vo.GroupBoardComment;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.group.model.vo.GroupBoardEntity;

public interface GroupDao {
	
	public Group selectOneGroup(String groupId);

	public int insertOneGroup(Group group);

	public List<Group> selectGroupList(Member member);
	
	public int insertGroupBoard(GroupBoardEntity groupBoard);

	public GroupBoard selectOneBoard(int no);

	List<Member> selectTagMemberList(GroupBoardEntity groupBoard);

	public List<Map<String,String>> selectGroupMemberList(String groupId);

	public List<GroupBoardEntity> selectGroupBoardList(String groupId);

	public int insertGroupBoardComment(GroupBoardComment groupBoardComment);

	public int insertEnrollGroupForm(Map<String, Object> map);

	public List<Map<String, Object>> getGroupApplyRequest(String groupId);

	public List<GroupBoardComment> selectGroupBoardCommentList(int boardNo);

	public int deleteBoardComment(int no);

	public int insertGroupMember(Map<String, Object> map);

	public int deleteGroupApplyList(Map<String, Object> map);

	public int deleteGroupBoard(int no);

	public int updateBoardContent(Map<String, Object> param);
	
//	public List<Map<String, Object>> groupMemberList(String groupId);

	public Group selectGroupInfo(String groupId);

	public List<Map<String, Object>> groupMemberList2(String groupId);

	public Map<String, Object> selectOneLikeLog(Map<String, Object> param);

	public int deleteLikeLog(Map<String, Object> param);

	public int insertLikeLog(Map<String, Object> param);

	public int selectLikeCount(Map<String, Object> param);

	public int deleteGroupMember(String memberId);

	public int updateGroupGrade(Map<String, Object> map);

	public int updateGroup(Group group);

	public int updateHashtag(Group group);

	public int insertHashtag(Group group);

}
