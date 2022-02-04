 package com.kh.hana.member.controller;

 
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hana.common.util.HanaUtils;
import com.kh.hana.group.model.vo.GroupBoardComment;
import com.kh.hana.member.model.service.MemberService;
import com.kh.hana.member.model.vo.Board;
import com.kh.hana.member.model.vo.BoardComment;
import com.kh.hana.member.model.vo.Follower;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.shop.model.vo.Shop;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private ServletContext application;
	
	@GetMapping("/login")
	public void loginMain() {
		
	}
	
	@GetMapping("/memberEnrollMain")
	public void memberEnrollMain() {
		
	}
	
	@PostMapping("/memberEnroll")
	public String memberEnroll(Member member, @RequestParam(name="pictureFile") MultipartFile upFile, RedirectAttributes redirectAttr) {
		
		log.info("member = {}", member);
		
		String password = member.getPassword();
		String encodedPassword = bcryptPasswordEncoder.encode(password);
		member.setPassword(encodedPassword);
		
		if(!upFile.getOriginalFilename().equals("")) {
			String originalFilename = upFile.getOriginalFilename();
			String renamedFilename = HanaUtils.rename(originalFilename);
			
			String saveDirectory = application.getRealPath("/resources/upload/member/profile");
			
			File saveImg = new File(saveDirectory, renamedFilename);
			try {
				upFile.transferTo(saveImg);
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage(), e);
			}
			
			member.setPicture(renamedFilename);					
		}
		
		int result = memberService.memberEnroll(member);
		
		redirectAttr.addFlashAttribute("msg", result > 0 ? "회원가입에 성공했습니다." : "회원가입에 실패했습니다.");
		return "redirect:/member/login";					
	}
	
	@GetMapping("/{view}/{id}")
	public String memberView(@PathVariable String id, @PathVariable String view, Model model) {
		//following 수 조회
		int followingCount = memberService.countFollowing(id);
		log.info("followingCount = {}", followingCount);
		model.addAttribute("followingCount", followingCount);
		
		//follower 수 조회
		int followerCount = memberService.countFollower(id);
		log.info("followerCount = {}", followerCount);
		model.addAttribute("followerCount", followerCount);
		
		//정보 가져오기
		Member member = memberService.selectOneMember(id);
		log.info("member={}", member);
		model.addAttribute("member", member);
		
		if(member.getAccountType() == 0) {
			Shop shopInfo = memberService.selectOneShopInfo(id);
			log.info("shopInfo = {}", shopInfo);
			model.addAttribute("shopInfo", shopInfo);
		}
		
		//게시글 목록 가져오기
		List<Board> boardList = memberService.selectBoardList(id);
		log.info("boardList = {}", boardList);
		
		model.addAttribute("boardList", boardList);
		
		return "/member/"+view;
	}
	
	@GetMapping("/memberSetting/{param}")
	public void memberSetting(@PathVariable String param) {

	}
	
	@GetMapping("/shopSetting/{param}")
	public void shopSetting(@PathVariable String param, Authentication authentication, Model model) {
		Member member = (Member) authentication.getPrincipal();
		String memberId = member.getId();
		try {
			if(param.equals("shopInfo")) {
				Shop shop = memberService.selectOneShopInfo(memberId);
				log.info("shop Setting ={}", shop);
				if(shop != null) {
					model.addAttribute(shop);
				} else {
					model.addAttribute("msg", "등록된 정보가 없습니다. 매장정보를 입력해주세요.");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	
	//정보 수정하기
	@PostMapping("/memberUpdate")
    public String memberUpdate(Member member, @RequestParam MultipartFile upFile,
                                @AuthenticationPrincipal Member oldMember,
                                RedirectAttributes redirectAttr) {
		
        String newProfile = upFile.getOriginalFilename();
        
        if(!newProfile.equals("")) {
			String saveDirectory = application.getRealPath("/resources/upload/member/profile");
			File file = new	File(saveDirectory, member.getPicture());
			file.delete();
			  
			String renamedFilename = HanaUtils.rename(newProfile);
			File regFile = new File(saveDirectory, renamedFilename);
			  
			try {
				upFile.transferTo(regFile);
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage(), e);
			}
			  
			member.setPicture(renamedFilename);	
		}
        
        int result = memberService.updateMember(member, oldMember);

        //spring-security memberController memberUpdate쪽
        oldMember.setName(member.getName());
		oldMember.setPicture(member.getPicture());			
        oldMember.setIntroduce(member.getIntroduce());
        oldMember.setAddressFull(member.getAddressFull());
        oldMember.setAddressAll(member.getAddressAll());
        oldMember.setPersonality(member.getPersonality());
        oldMember.setInterest(member.getInterest());
        oldMember.setLocationX(member.getLocationX());
        oldMember.setLocationY(member.getLocationY());

//    	Authentication newAuthentication = 
//				new UsernamePasswordAuthenticationToken(
//						oldMember, 
//						oldMember.getPassword());
//		
//		SecurityContextHolder.getContext().setAuthentication(newAuthentication);
//        
        redirectAttr.addFlashAttribute("msg", result > 0? "프로필 편집에 성공했습니다." : "프로필 편집에 실패했습니다.");
        if(member.getAccountType() != 1) {
        	return "redirect:/member/memberSetting/memberSetting";        	
        } else {
    		return "redirect:/member/shopSetting/personal";
        }
    }
	
	//친구추가
	@PostMapping("/addFollowing")
	public String addFollowing(@AuthenticationPrincipal Member member, @RequestParam String friendId, String myId, RedirectAttributes redirectAttr) {
		log.info("addFollowing.member={}", member.getId());
		
		Map<String, Object> map = new HashMap<>();
		map.put("myId", myId);
		map.put("friendId", friendId);
		log.info("map ={}", map);
		
		int result = memberService.addFollowing(map);
		log.info("result ={}", result);
		redirectAttr.addFlashAttribute("msg", result > 0? "친구 추가에 성공했습니다." : "친구 추가에 실패했습니다.");
		return "redirect:/member/memberView/"+friendId;
	}
	
	
	//팔로워리스트 가져오기
	@GetMapping("/followerList")
	@ResponseBody
	public List<Follower> followerList(@RequestParam String friendId, Model model) {
		List<Follower> follower = memberService.followerList(friendId);
		log.info("followerList.follower={}", follower);
		model.addAttribute("follower", follower);
		
		return follower;
		
	}
 
	//팔로잉리스트 가져오기
	@GetMapping("/followingList")
	@ResponseBody
	public List<Follower> followingList(@RequestParam String friendId, Model model){
		List<Follower> followingList = memberService.followingList(friendId);
		log.info("followingList.followingList={}", followingList);
		model.addAttribute("followingList", followingList);
		
		return followingList;
	}
	
	
	@GetMapping("/boardForm")
	public void boardForm() {
	}
	
	@PostMapping("/shopSetting/shopInfo")
	public String updateShopInfo(Shop shop, RedirectAttributes redirectAttr) {
		log.info("updateShopInfo shop = {}", shop);
		int result = memberService.updateShopInfo(shop);
		
		String msg = "";
		if(result > 0) {
			msg = "수정되었습니다.";
		} else {
			msg = "수정에 실패했습니다.";
		}
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/member/shopSetting/shopInfo";
	}

 

	//게시글 작성하기
	@PostMapping("/memberBoardEnroll")
    public String insertMemberBoard(
            Member member,
            Board  board, 
            RedirectAttributes redirectAttr,
            Model model,
            @RequestParam(name="uploadFile", required = false) MultipartFile[] files) throws IllegalStateException, IOException {

		try {
			log.info("board = {}",board);

			List<String> fileList = new ArrayList<>();
			
			for(MultipartFile file : files) {
				if(!file.isEmpty()) {
					String originalFilename = file.getOriginalFilename();
					String renamedFilename = HanaUtils.rename(originalFilename);
					String saveDirectory = application.getRealPath("/resources/upload/member/board");
					
					File dest = new File(saveDirectory,renamedFilename);
					file.transferTo(dest);
					
					fileList.add(renamedFilename);
				}
			}
			
			log.info("fileList = {}",fileList);
			if(!fileList.isEmpty()) {
				String[] fileArray = fileList.toArray(new String[0]);
				board.setPicture(fileArray);
			}
			
			log.info("board = {}",board);
			
			int result = memberService.insertMemberBoard(board);
			
			return "redirect:/member/memberView/"+member.getId();
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			return "redirect:/member/memberView/"+member.getId();
		}
	}
	
	@PostMapping("/testModal")
	public void testModal(@RequestParam MultipartFile upFile) {
		 log.info("upFile = {}", upFile);
	}
	
	
	//비밀번호 수정하기
	@PostMapping("/updatePassword")
	public String updatePassword(@RequestParam String password, 
								@RequestParam String newPassword, 
								@RequestParam String passwordCheck,
								Member updateMember, 
								@AuthenticationPrincipal Member oldMember,
								RedirectAttributes redirectAttr,
								Model model
								) {
			log.info("passwordUpdate.password= {}", password);
			log.info("passwordUpdate.newPassword= {}", newPassword);
			log.info("passwordUpdate.passwordCheck= {}", passwordCheck);
			log.info("passwordUpdate.updatemember= {}", updateMember);
			log.info("passwordUpdate.oldMember = {}", oldMember);

			if(bcryptPasswordEncoder.matches(password, oldMember.getPassword())) {
				String encodedPassword = bcryptPasswordEncoder.encode(newPassword);
				updateMember.setPassword(encodedPassword);
				int result = memberService.updatePassword(updateMember);
				String msg = result > 0 ? "비밀번호가 수정되었습니다." : "비밀번호 수정에 실패했습니다.";
				redirectAttr.addFlashAttribute("msg", msg);
				oldMember.setPassword(bcryptPasswordEncoder.encode(updateMember.getPassword()));
				
				log.info("oldMember.password = {}", oldMember.getPassword());
				log.info("SecurityContextHolder.getContext().getAuthentication() = {}",
						SecurityContextHolder.getContext().getAuthentication());
			 
					if(oldMember.getAccountType() == 1) {
						return "redirect:/member/memberView/"+oldMember.getId(); 
					} else {
						return "redirect:/member/shopSetting/password";
					}
			}else {
				String msg = "현재 비밀번호가 일치하지 않습니다.";
				model.addAttribute("msg",msg);
				return "/member/memberSetting/updatePassword";	
			}
	}
	
	
	//게시글 상세보기
	@GetMapping("/memberBoardDetail/{no}")
	public ResponseEntity<Map<String,Object>> boardDetail(@ModelAttribute Member member,
				@AuthenticationPrincipal Member loginMember, @PathVariable int no, Model model) { 
	
	//게시글 정보
	Board  boardDetail = memberService.selectOneBoard(no);
	log.info("boardDetail = {}", boardDetail);
	
	//좋아요여부
	Map<String,Object> param = new HashMap<>();
	param.put("memberId",loginMember.getId());
	param.put("boardNo", no);
	Map<String,Object> likeLog = memberService.selectOneLikeLog(param);
	boolean isLiked = likeLog == null? false : true;
	log.info("isLiked = {}",isLiked);
	
	Map<String, Object> map = new HashMap<>();
	map.put("boardDetail", boardDetail);
	map.put("isLiked",isLiked);
	
	return ResponseEntity.ok()
						.body(map);
	}
	
	//게시글 삭제하기
	 @PostMapping("/deleteBoard")
	    public String deleteBoard(@RequestParam int no, @RequestParam String id){
	    	
	    	try{
	    		log.info("delete.no = {}",no);
	    		log.info("delete.member.id = {}",id);
	    		int result = memberService.deleteBoard(no);
	    		
	    	}catch(Exception e) {
	    		log.error(e.getMessage(),e);
	       	}
	    	return "redirect:/member/memberView/"+id;
	    	
	    }
	
	 //게시글수정하기
	 @PostMapping("/boardModifying")
	    public ResponseEntity<Map<String,Object>> boardModifying(@RequestParam int no, @RequestParam String content) {

	    	Map<String,Object> param = new HashMap<>();
	    	Map<String,Object> resultMap = new HashMap<>();
	    	
	    	try {
	    		log.info("no = {}",no);
	    		log.info("content = {}",content);
	    		
	    		param.put("no", no);
	    		param.put("content", content);
	    		int result = memberService.updateBoardContent(param);
	    		
	    		resultMap.put("msg","게시물 수정 성공");
	    		resultMap.put("result",result);
	    	}catch(Exception e) {
	    		log.error(e.getMessage(),e);
	    		resultMap.put("msg","게시물 수정 실패");
	    	}
	    	
	    	return ResponseEntity.ok(resultMap);
	    	
	    }
	//댓글등록
	@PostMapping("/enrollBoardComment")
	@ResponseBody
	public Map<String,Object> enrollBoardComment(@RequestBody BoardComment boardComment){
		log.info("boardComment = {}",boardComment);
		int result = memberService.enrollBoardComment(boardComment);
		
		Map<String,Object> map = new HashMap<>();
		map.put("msg", "댓글 등록 성공");
		map.put("result",result);
		return map;
	}
	
	//댓글리스트 가져오기
	@GetMapping("/getCommentList/{boardNo}")
	public ResponseEntity<List<BoardComment>> getCommentList(@PathVariable int boardNo){
		log.info("리스트!!!!!!!boardNo = {}",boardNo);
		List<BoardComment> list = memberService.selectBoardCommentList(boardNo);
		log.info("list = {}",list);
		return ResponseEntity.ok(list);
	}
	
	//댓글 삭제하기
	@DeleteMapping("/boardCommentDelete/{no}")
	public ResponseEntity<Map<String,Object>> boardCommentDelete(@PathVariable int no) {
		Map<String, Object> map = new HashMap<>();
		try{
			log.info("댓글삭제하기.no = {}",no);
			int result = memberService.deleteBoardComment(no);
			log.info("result = {}",result);
			map.put("msg", "삭제 성공!");
			map.put("result",result);
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			map.put("msg", "삭제 실패, 관리자에게 문의");
		}
		return ResponseEntity.ok(map);
	}	
	
	//좋아요
	@PostMapping("/like")
	public ResponseEntity<Map<String,Object>> like(@RequestParam int no, @AuthenticationPrincipal Member member){
		Map<String,Object> map = new HashMap<>();
		
		try {
			log.info("좋아요 no = {}",no);
			log.info("좋아요 member = {}",member);
			Map<String,Object> param = new HashMap<>();
			param.put("memberId",member.getId());
			param.put("boardNo",no);
			int result = memberService.insertLikeLog(param);
			
			map.put("msg", "like 성공");
			map.put("result", result);
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			map.put("result", "like 실패");
		}
		
		
		return ResponseEntity.ok(map);
	}
	
	//싫어요
	@DeleteMapping("/unlike/{no}")
	public ResponseEntity<Map<String,Object>> unlike(@PathVariable int no, @AuthenticationPrincipal Member member) {
		Map<String,Object> map = new HashMap<>();
		
		try {
			Map<String,Object> param = new HashMap<>();
			param.put("memberId",member.getId());
			param.put("boardNo",no);
			map.put("memberId",member.getId());
			map.put("boardNo",no);
			
			int result = memberService.deleteLikeLog(param);
			
			map.put("msg", "unlike 성공");
			map.put("result", result);
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			map.put("result", "unlike 실패");
		}
		
		
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getLikeCount/{no}")
	public ResponseEntity<Map<String,Object>> getLikeCount(@PathVariable int no){
		Map<String,Object> map = new HashMap<>();
		Map<String,Object> param = new HashMap<>();
		
		param.put("no",no);
		int likeCount = memberService.selectLikeCount(param);
		map.put("likeCount",likeCount);
		
		return ResponseEntity.ok(map);
	}
	
	

}
