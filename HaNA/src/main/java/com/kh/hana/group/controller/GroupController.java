package com.kh.hana.group.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.omg.CORBA.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hana.chat.model.service.ChatService;
import com.kh.hana.common.util.HanaUtils;
import com.kh.hana.group.model.service.GroupService;
import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.group.model.vo.GroupBoardComment;
import com.kh.hana.group.model.vo.GroupBoardEntity;
import com.kh.hana.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/group")
@Slf4j
public class GroupController {

	
	@Autowired
	private GroupService groupService;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private ChatService chatService;
	
	@GetMapping("/groupPage/{groupId}")
	public String groupPage(@PathVariable String groupId, Model model) {
		Group group = groupService.selectOneGroup(groupId);// 그룹정보 가져오기
		log.debug("group = {}", group);
		model.addAttribute(group);
		
		List<Map<String,String>> groupMembers = groupService.selectGroupMemberList(group.getGroupId());
		log.info("groupMembers = {}",groupMembers);
		model.addAttribute("groupMembers",groupMembers);
		
		List<GroupBoardEntity> groupBoardList = groupService.selectGroupBoardList(groupId);
		log.info("groupBoardList = {}", groupBoardList);
		model.addAttribute("groupBoardList", groupBoardList);
		return "group/groupPage";
	}

	@GetMapping("/groupList")
	public void groupList(@AuthenticationPrincipal Member member, Model model) {
		List<Group> groupList = groupService.selectGroupList(member);
		model.addAttribute("groupList",groupList);
		log.info("loginMember = {}",member);
		log.info("groupList = {}", groupList);
		
	
	}
	
	@GetMapping("/createGroupForm")
	public void createGroupForm() {}
	
	@PostMapping("/createGroup")
	public String insertGroup(Group group,
		@RequestParam(name="profileImage",required=false)MultipartFile[] profileImage,
		RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		try{
			log.info("multipartFile.isEmpty() = {}",profileImage[0].isEmpty());
			log.info("group.getHashtag = {}",group.getHashtag());
			log.info("group.getHashtag().isEmpty() = {}",group.getHashtag() == null);
			log.info("multipartFile.isEmpty() = {}",profileImage[0].isEmpty());
			String saveDirectory = application.getRealPath("/resources/upload/group/profile");
			MultipartFile image = profileImage[0];
			if(!image.isEmpty()) {
				String originalFilename = image.getOriginalFilename();
				String renamedFilename = HanaUtils.rename(originalFilename);
				
				File dest = new File(saveDirectory, renamedFilename);
				log.info("dest = {}", dest);
				Path path = Paths.get(dest.toString()).toAbsolutePath();
				log.info("path = {}", path);
				image.transferTo(path.toFile());
				
				group.setImage(renamedFilename);
			}
			
			int result = groupService.insertOneGroup(group);
			int chatresult = 0;
			if(result > 0) {
				chatresult = chatService.CreateGroupChat(group);
				log.info("{}", chatresult > 0 ? "그룹채팅생성 성공" : "그룹채팅생성 실패");
			}
			redirectAttr.addFlashAttribute("msg", "소모임 등록 성공!");	
			redirectAttr.addFlashAttribute("result", result);	
			return "redirect:/group/groupPage/"+group.getGroupId();
		
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			redirectAttr.addFlashAttribute("msg", "소모임 등록 실패 : 관리자에게 문의하세요.");	
			return "redirect:/group/groupList";
		}
	}

	@GetMapping("/groupBoardForm/{groupId}")
	public String groupBoardForm(@PathVariable String groupId, Model model){
		List<Map<String,String>> members = groupService.selectGroupMemberList(groupId);
		log.info("members = {}",members);
		model.addAttribute("groupId",groupId);
		model.addAttribute("members",members);
		return "/group/groupBoardForm";
	}
	//이거
	@PostMapping(value="/enrollGroupBoard")
	public String enrollGroupBoard(GroupBoardEntity groupBoard,
			@RequestParam(name="file", required=false) MultipartFile[] files){
		try {
			log.info("groupBoard = {}",groupBoard);

			List<String> fileList = new ArrayList<>();
			
			for(MultipartFile file : files) {
				if(!file.isEmpty()) {
					String originalFilename = file.getOriginalFilename();
					String renamedFilename = HanaUtils.rename(originalFilename);
					String saveDirectory = application.getRealPath("/resources/upload/group/board");
					
					File dest = new File(saveDirectory,renamedFilename);
					file.transferTo(dest);
					
					fileList.add(renamedFilename);
				}
			}
			
			log.info("fileList = {}",fileList);
			if(!fileList.isEmpty()) {
				String[] fileArray = fileList.toArray(new String[0]);
				groupBoard.setImage(fileArray);
			}
			
			log.info("groupBoard = {}",groupBoard);
			
			int result = groupService.insertGroupBoard(groupBoard);
			
			return "redirect:/group/groupPage/"+groupBoard.getGroupId();
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			return "redirect:/group/enrollGroupBoard";
		}
	}
	//이거
	@GetMapping("/groupBoardDetail/{no}")
	public ResponseEntity<Map<String,Object>> groupBoardDetail(@AuthenticationPrincipal Member loginMember, @PathVariable int no, Model model) {
		//게시물 정보
		GroupBoard groupBoard = groupService.selectOneBoard(no);
		log.info("groupBoard = {}",groupBoard);
		//태그멤버
		List<Member> tagMembers = groupService.selectTagMemberList(groupBoard);
		log.info("tagMembers = {}",tagMembers);
		//좋아요여부
		Map<String,Object> param = new HashMap<>();
		param.put("memberId",loginMember.getId());
		param.put("boardNo", no);
		Map<String,Object> likeLog = groupService.selectOneLikeLog(param);
		boolean isLiked = likeLog == null? false : true;
		log.info("isLiked = {}",isLiked);
		
		Map<String, Object> map = new HashMap<>();
		map.put("groupBoard",groupBoard);
		map.put("tagMembers",tagMembers);
		map.put("isLiked",isLiked);
		
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/enrollGroupBoardComment")
	@ResponseBody
	public Map<String,Object> enrollGroupBoardComment(@RequestBody GroupBoardComment groupBoardComment){
		log.info("groupBoardComment = {}",groupBoardComment);
		int result = groupService.insertGroupBoardComment(groupBoardComment);
		
		Map<String,Object> map = new HashMap<>();
		map.put("msg", "댓글 등록 성공");
		map.put("result",result);
		return map;
	}
	
	@GetMapping("/enrollGroupForm")
	public void enrollGroupForm(@RequestParam String groupId, Model model) {
		log.info("groupId = {}", groupId);
		model.addAttribute("groupId", groupId);
	}
	
	@PostMapping("/enrollGroupForm")
	public String enrolledGroupForm(
			@RequestParam Map<String, Object> map,
			Model model) {
		log.info("map = {}", map);
		int result = groupService.insertEnrollGroupForm(map);
		
		String msg = result > 0 ? "가입 신청 완료." : "가입 신청 실패.";
		log.info("msg ={}", msg);
		
		return "redirect:/group/groupPage/"+map.get("groupId");
	}

	
	@GetMapping("/getCommentList/{boardNo}")
	public ResponseEntity<List<GroupBoardComment>> getCommentList(@PathVariable int boardNo){
		log.info("boardNo = {}",boardNo);
		List<GroupBoardComment> list = groupService.selectGroupBoardCommentList(boardNo);
		log.info("list = {}",list);
		return ResponseEntity.ok(list);
	}
	

	@DeleteMapping("/groupBoardCommentDelete/{no}")
	public ResponseEntity<Map<String,Object>> groupBoardCommentDelete(@PathVariable int no) {
		Map<String, Object> map = new HashMap<>();
		try{
			log.info("no = {}",no);
			int result = groupService.deleteBoardComment(no);
			log.info("result = {}",result);
			map.put("msg", "삭제 성공!");
			map.put("result",result);
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			map.put("msg", "삭제 실패, 관리자에게 문의");
		}
		return ResponseEntity.ok(map);
	}
    @GetMapping("/getGroupApplyRequest")
    public ResponseEntity<List<Map<String, Object>>> getGroupApplyRequest(@RequestParam String groupId) {
        log.info("groupId ={}", groupId);
        
        List<Map<String, Object>> groupApplyList = groupService.getGroupApplyRequest(groupId);
        log.info("groupApplyList ={}", groupApplyList);
        
        return ResponseEntity.ok(groupApplyList);       
    }
	
    @PostMapping("/groupApplyProccess")
    @ResponseBody
    public String groupApplyProcess(
            @RequestParam(name="no") int no, 
            @RequestParam(name="groupId") String groupId,
            @RequestParam(name="memberId") String memberId,
            @RequestParam(name="approvalYn") String approvalYn,
            @RequestParam Map<String, Object> map
            ) {
        log.info("no = {}", no);
        log.info("groupId = {}", groupId);
        log.info("memberId = {}", memberId);
        log.info("approvalYn = {}", approvalYn);
        //승인(y)
        if(approvalYn.equals("y")) {
            int result = groupService.insertGroupMember(map);
            log.info("result ={}", result);
            
            String msg = result > 0 ? "가입 승인 성공" : "가입 승인 실패";
            log.info("msg ={}", msg);
            
            int deleteResult = groupService.deleteGroupApplyList(map);
            log.info("deleteResult ={}", deleteResult);
        }
        //거절(n)
        else {
            int result = groupService.deleteGroupApplyList(map);
            log.info("result ={}", result);
            
            String msg = result > 0 ? "가입 거절 성공" : "가입 거절 실패";
            log.info("msg ={}", msg);
            
        }
        
        return "redirect:/group/groupPage/"+groupId;
    }
    
    @PostMapping("/deleteGroupBoard")
    public String deleteGroupBoard(@RequestParam int no, @RequestParam String groupId){
    	
    	try{
//    		int result = groupService.deleteGroupBoard(no);
    		log.info("no = {}",no);
    		log.info("groupId = {}",groupId);
    		int result = groupService.deleteGroupBoard(no);
    		
    	}catch(Exception e) {
    		log.error(e.getMessage(),e);
       	}
    	return "redirect:/group/groupPage/"+groupId;
    	
    }
    @PostMapping("/groupBoardModifying")
    public ResponseEntity<Map<String,Object>> groupBoardModifying(@RequestParam int no, @RequestParam String content) {

    	Map<String,Object> param = new HashMap<>();
    	Map<String,Object> resultMap = new HashMap<>();
    	
    	try {
    		log.info("no = {}",no);
    		log.info("content = {}",content);
    		
    		param.put("no", no);
    		param.put("content", content);
    		int result = groupService.updateBoardContent(param);
    		
    		resultMap.put("msg","게시물 수정 성공");
    		resultMap.put("result",result);
    	}catch(Exception e) {
    		log.error(e.getMessage(),e);
    		resultMap.put("msg","게시물 수정 실패");
    	}
    	
    	return ResponseEntity.ok(resultMap);
    	
    }
//    @PutMapping("/groupBoardModifying/{no}")
//    public ResponseEntity<Map<String,Object>> groupBoardModifying(@PathVariable int no, @RequestBody String content) {
//    	Map<String,Object> param = new HashMap<>();
//    	Map<String,Object> resultMap = new HashMap<>();
//    	
//    	try {
//    		log.info("no = {}",no);
//    		log.info("content = {}",content);
//    		
//    		param.put("no", no);
//    		param.put("content", content);
//    		int result = groupService.updateBoardContent(param);
//    		
//    		resultMap.put("msg","게시물 수정 성공");
//    		resultMap.put("result",result);
//    	}catch(Exception e) {
//    		log.error(e.getMessage(),e);
//    		resultMap.put("msg","게시물 수정 실패");
//    	}
//    	
//    	return ResponseEntity.ok(resultMap);
//    }

	@DeleteMapping("/unlike/{no}")
	public ResponseEntity<Map<String,Object>> unlike(@PathVariable int no, @AuthenticationPrincipal Member member) {
		Map<String,Object> map = new HashMap<>();
		
		try {
			Map<String,Object> param = new HashMap<>();
			param.put("memberId",member.getId());
			param.put("boardNo",no);
			map.put("memberId",member.getId());
			map.put("boardNo",no);
			
			int result = groupService.deleteLikeLog(param);
			
			map.put("msg", "unlike 성공");
			map.put("result", result);
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			map.put("result", "unlike 실패");
		}
		
		
		return ResponseEntity.ok(map);
	}
	
//    @GetMapping("/groupMemberList/{groupId}") 
//    public ResponseEntity<List<Map<String, Object>>> groupMemberList(@PathVariable String groupId, @AuthenticationPrincipal Member member) {
//    		log.info("groupId ={}", groupId);
//    		
//    		List<Map<String, Object>> groupMemberList = groupService.groupMemberList(groupId);
//    		log.info("groupMemberList ={}", groupMemberList);
//    		
//    		return ResponseEntity.ok(groupMemberList);
//    }
    
    @GetMapping("/groupMemberList/{groupId}")
    public String groupMemberList(@PathVariable String groupId, Model model){
    	log.info("groupId ={}", groupId);
    	
    	List<Map<String, Object>> groupMemberList = groupService.groupMemberList2(groupId);
    	log.info("groupMemberList = {}", groupMemberList);
    	
    	model.addAttribute("groupMemberList", groupMemberList);
    	return "/group/groupMemberList";
    }
    	
    @GetMapping("/groupSetting/{groupId}")
    public void groupSetting(@PathVariable String groupId, Model model){
    	Group groupInfo = groupService.selectGroupInfo(groupId);
    	log.info("groupInfo ={}", groupInfo);
    }
    
	@PostMapping("/like")
	public ResponseEntity<Map<String,Object>> like(@RequestParam int no, @AuthenticationPrincipal Member member){
		Map<String,Object> map = new HashMap<>();
		
		try {
			log.info("no = {}",no);
			log.info("member = {}",member);
			Map<String,Object> param = new HashMap<>();
			param.put("memberId",member.getId());
			param.put("boardNo",no);
			int result = groupService.insertLikeLog(param);
			
			map.put("msg", "like 성공");
			map.put("result", result);
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			map.put("result", "like 실패");
		}
		
		
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getLikeCount/{no}")
	public ResponseEntity<Map<String,Object>> getLikeCount(@PathVariable int no){
		Map<String,Object> map = new HashMap<>();
		Map<String,Object> param = new HashMap<>();
		
		param.put("no",no);
		int likeCount = groupService.selectLikeCount(param);
		map.put("likeCount",likeCount);
		
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/groupCalendar")
	public void groupCalendar() {}

	@RequestMapping(value = "/deleteGroupMember/{memberId}/{groupId}", method = RequestMethod.GET)
	public String deleteGroupMember (
			@PathVariable String memberId,
			@PathVariable String groupId) {
		
		log.info("memberId ={}", memberId);
		log.info("groupId ={}", groupId);
		int result = groupService.deleteGroupMember(memberId);
		String msg = result > 0 ? "회원 탈퇴 성공" : "회원 탈퇴 실패";
		log.info("msg ={}", msg);
		
		return "redirect:/group/groupMemberList/"+groupId;
	}
	
	@GetMapping("/groupProfile")
	public void groupProfile(@RequestParam String groupId, Model model) {
		log.info("groupProfile groupId = {}", groupId);
		Group group = groupService.selectGroupInfo(groupId);
    	log.info("groupInfo ={}", group);
    	
    	model.addAttribute(group);
	}
	
	@PostMapping("/groupUpdate")
	public String groupUpdate(Group group, 
							@RequestParam MultipartFile upFile,
							RedirectAttributes redirectAttr,
							@AuthenticationPrincipal Group oldGroup) {
		
		log.info("group ={}", group);
		log.info("oldGroup ={}", oldGroup);
		String oldImage = group.getImage();
		
		if(oldImage != null) {
			String saveDirectory = application.getRealPath("/resources/upload/group/profile");
			File file = new File(saveDirectory, oldImage);
			boolean del = file.delete();
			log.info("del ={}", del);
		}
		return "redirect:/group/groupProfile";
	}
}


