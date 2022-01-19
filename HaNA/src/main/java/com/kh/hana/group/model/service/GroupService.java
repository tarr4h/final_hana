package com.kh.hana.group.model.service;

import java.util.List;
import java.util.Map;

import com.kh.hana.group.model.vo.Group;

import com.kh.hana.member.model.vo.Member;

import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.member.model.vo.Member;


public interface GroupService {

	Group selectOneGroup(String groupId);

	int insertOneGroup(Group group);

	Map<String, String> selectGroupEnrolled(Map<String, String> map);

	List<Group> selectGroupList(Member member);

	int insertGroupBoard(GroupBoard groupBoard);

	GroupBoard selectOneBoard(int no);

	List<Member> selectMemberList(GroupBoard groupBoard);

	List<Member> selectGroupMemberList(String groupId);

}
