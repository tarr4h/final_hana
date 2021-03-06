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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hana.common.util.HanaUtils;
import com.kh.hana.member.model.service.MemberService;
import com.kh.hana.member.model.vo.Board;
import com.kh.hana.member.model.vo.BoardComment;
import com.kh.hana.member.model.vo.Follower;
import com.kh.hana.member.model.vo.FollowingRequest;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.shop.model.vo.Shop;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
@SessionAttributes({"publicProfile"})
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
		
		redirectAttr.addFlashAttribute("msg", result > 0 ? "??????????????? ??????????????????." : "??????????????? ??????????????????.");
//		if(member.getAccountType() == 1) {
//			redirectAttr.addFlashAttribute("shopGuide", )
//		}
		return "redirect:/member/login";					
	}
	
	@GetMapping("/{view}/{id}")
	public String memberView(@PathVariable String id, @PathVariable String view, Model model,Authentication authentication) {
		//following ??? ??????
		int followingCount = memberService.countFollowing(id);
		log.info("followingCount = {}", followingCount);
		model.addAttribute("followingCount", followingCount);
		
		//follower ??? ??????
		int followerCount = memberService.countFollower(id);
		log.info("followerCount = {}", followerCount);
		model.addAttribute("followerCount", followerCount);
		
		//?????? ????????????
		Member member = memberService.selectOneMember(id);
		log.info("member={}", member);
		model.addAttribute("member", member);
		
		//????????? ?????? ????????????
		List<Board> boardList = memberService.selectBoardList(id);
		log.info("boardList = {}", boardList);
		
		model.addAttribute("boardList", boardList);
		
		//???????????? 
		 Member loginMember = (Member) authentication.getPrincipal();
		 String loginMemberId = loginMember.getId();
		 log.info("id={}",id);
		 log.info("loginMemberId={}",loginMemberId);
		 
		 Map<String, Object> map = new HashMap<>();
		 map.put("id", id);
		 map.put("loginMemberId", loginMemberId);
		 
		 int isFriend = memberService.checkFriend(map);
		 log.info("isFriend={}", isFriend);
		 model.addAttribute("isFriend", isFriend);
		 
		 //?????? ??????????????????
		 int isFollow = memberService.checkFollow(map);
		 log.info("isFollow={}", isFollow);
		 model.addAttribute("isFollow", isFollow);
		 
		 //?????????????????? ???????????????
		 int isRequest = memberService.isRequestFriend(map);
		 log.info("isRequest = {}", isRequest);
		 model.addAttribute("isRequest", isRequest);
		 
		//???????????? ?????? ??????
		 int request = memberService.followingRequest(map);
		 log.info("request={}", request);
		 model.addAttribute("request", request);
		
		// ????????? ?????? shop ?????? + ?????? ????????? ????????????
		if(member.getAccountType() == 0) {
			Shop shopInfo = memberService.selectOneShopInfo(id);
			log.info("shopInfo = {}", shopInfo);
			model.addAttribute("shopInfo", shopInfo);
			
			List<Board> reviewList = memberService.selectShopReviewList(shopInfo.getId());
			model.addAttribute("reviewList", reviewList);
			log.info("reviewLIst = {}", reviewList);
			
			return "/member/"+"shopView";
		};
			return "/member/"+ view;
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
				model.addAttribute(shop);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	
	//?????? ????????????
	@PostMapping("/memberUpdate")
    public String memberUpdate(Member member, @AuthenticationPrincipal Member oldMember, RedirectAttributes redirectAttr) {
		log.info("memberUpdate member = {}", member);
		log.info("authentication = {}", oldMember);
        
        int result = memberService.updateMember(member, oldMember);

        //spring-security memberController memberUpdate???
        oldMember.setName(member.getName());	
        oldMember.setIntroduce(member.getIntroduce());
        oldMember.setAddressFull(member.getAddressFull());
        oldMember.setAddressAll(member.getAddressAll());
        oldMember.setPersonality(member.getPersonality());
        oldMember.setInterest(member.getInterest());
        oldMember.setLocationX(member.getLocationX());
        oldMember.setLocationY(member.getLocationY());
        
        redirectAttr.addFlashAttribute("msg", result > 0? "????????? ????????? ??????????????????." : "????????? ????????? ??????????????????.");
        if(oldMember.getAccountType() == 1) {
        	return "redirect:/member/memberSetting/memberSetting";        	
        } else {
    		return "redirect:/member/shopSetting/personal";
        }
    }
	
	//????????????
	@PostMapping("/addFollowing")
	public String addFollowing(@AuthenticationPrincipal Member member, @RequestParam String friendId, String myId, RedirectAttributes redirectAttr) {
		log.info("addFollowing.member={}", member.getId());
		
		Map<String, Object> map = new HashMap<>();
		map.put("myId", myId);
		map.put("friendId", friendId);
		log.info("map ={}", map);
		
		int result = memberService.addFollowing(map);
		log.info("result ={}", result);
		redirectAttr.addFlashAttribute("msg", result > 0? "?????? ????????? ??????????????????." : "?????? ????????? ??????????????????.");
		return "redirect:/member/memberView/"+friendId;
	}
	
	
	//?????????????????? ????????????
	@GetMapping("/followerList")
	@ResponseBody
	public List<Follower> followerList(@RequestParam String friendId, Model model) {
		List<Follower> follower = memberService.followerList(friendId);
		log.info("followerList.follower={}", follower);
		model.addAttribute("follower", follower);
		
		return follower;
		
	}
 
	//?????????????????? ????????????
	@GetMapping("/followingList")
	@ResponseBody
	public List<Follower> followingList(@RequestParam String friendId, Model model){
		List<Follower> followingList = memberService.followingList(friendId);
		log.info("followingList.followingList={}", followingList);
		model.addAttribute("followingList", followingList);
		
		return followingList;
	}
	
	///???????????????????????? ????????????
	@GetMapping("/requestFollowingList")
	@ResponseBody
	public List<FollowingRequest> requestFollowingList(@RequestParam String myId, Model model){
		log.info("controller.myIddddddddddd={}", myId);
		List<FollowingRequest> requestFollowingList = memberService.requestFollowingList(myId);
		log.info("requestFollowingList.requestFollowingList={}", requestFollowingList);
		model.addAttribute("requestFollowingList", requestFollowingList);
		
		return requestFollowingList;
	}
	
	//???????????? ????????????
		@PostMapping("/applyFollowing")
		public String applyFollowing(@AuthenticationPrincipal Member member, @RequestParam String reqId, String myId, String status, RedirectAttributes redirectAttr) {
			log.info("applyFollowing.reqId={}", reqId);
			log.info("applyFollowing.myId={}", myId);
			log.info("applyFollowing.status={}", status);
			
			Map<String, Object> map = new HashMap<>();
			map.put("reqId", reqId);
			map.put("myId", myId);
			map.put("status", status);
			
			int result = memberService.applyFollowing(map);
			log.info("result ={}", result);
			redirectAttr.addFlashAttribute("msg", result > 0? "?????????????????????." : "?????? ??????");
			
			
    		if(result == 1) {
    			int addResult = 0;
    			addResult = memberService.addRequestFollowing(map);
    		}
    		
		
			return "redirect:/member/memberView/"+myId;
		}
		
		//???????????? ????????????
		@PostMapping("/refuseFollowing")
		public String refuseFollowing(@AuthenticationPrincipal Member member, @RequestParam String reqId, String myId, String status, RedirectAttributes redirectAttr) {
			log.info("refuseFollowing.reqId={}", reqId);
			log.info("refuseFollowing.myId={}", myId);
			log.info("refuseFollowing.status={}", status);
			
			Map<String, Object> map = new HashMap<>();
			map.put("reqId", reqId);
			map.put("myId", myId);
			map.put("status", status);
			
			int refuseResult = memberService.refuseFollowing(map);
			log.info("refuseResult  ={}", refuseResult) ;
			redirectAttr.addFlashAttribute("msg", refuseResult  > 0? "?????????????????????." : "????????? ??????????????????.");
			//redirectAttr.addFlashAttribute("refuseResult", refuseResult);
			return "redirect:/member/memberView/"+myId;
		}

		
	
	//????????? ???????????? ????????? ?????????
	@GetMapping("/followingListById")
	@ResponseBody
	public ResponseEntity<?> followingListById(@RequestParam String inputText, @AuthenticationPrincipal Member member){
		log.info("inputText = {}", inputText);
		
		String memberId = member.getId();
		
		Map<String, Object> map = new HashMap<>();
		map.put("inputText", inputText);
		map.put("memberId", memberId);
		
		List<Map<String, Object>> followingListById = memberService.followingListById(map);
		log.info("followingList By Id = {}", followingListById);
		
		return ResponseEntity.ok(followingListById);
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
			msg = "?????????????????????.";
		} else {
			msg = "????????? ??????????????????.";
		}
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/member/shopSetting/shopInfo";
	}

 

	//????????? ????????????
	@PostMapping("/memberBoardEnroll")
    public String insertMemberBoard(
            Member member,
            Board  board, 
            RedirectAttributes redirectAttr,
            Model model,
            @RequestParam(name="file", required = false) MultipartFile[] files)  {

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
	
	//???????????????2
	@PostMapping("/insertBoard")
	public String insertBoard(Board board, @RequestParam(value="upFile") MultipartFile[] upFiles, RedirectAttributes redirectAttr, @AuthenticationPrincipal Member member) {
		String[] picArr = new String[upFiles.length];
		String saveDirectory = application.getRealPath("/resources/upload/member/board");
		
		int i = 0;
		for(MultipartFile file : upFiles) {
			String ofn = file.getOriginalFilename();
			String rfn = HanaUtils.rename(ofn);
			File uploadImg = new File(saveDirectory, rfn);
			try {
				file.transferTo(uploadImg);
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage(), e);
			}
			picArr[i] = rfn;
			i++;
		};
		board.setPicture(picArr);
		
		int result = memberService.insertMemberBoard(board);
		String msg = result > 0 ? "???????????? ?????????????????????." : "?????? ??????";
		
		redirectAttr.addFlashAttribute("msg", msg);
		
		if(member.getAccountType() == 1) {
			return "redirect:/member/memberView/"+member.getId();			
		} else {
			return "redirect:/member/shopView/"+member.getId();
		}
		
	};
	
	@PostMapping("/insertReview")
	public String insertReview(Board board, @RequestParam String reservationNo, @RequestParam int checkedVal,
			@RequestParam(value="upFile") MultipartFile[] upFiles, RedirectAttributes redirectAttr, @AuthenticationPrincipal Member member) {
		log.info("reservationNo = {}", reservationNo);
		log.info("checkedVal = {}", checkedVal);

		String[] picArr = new String[upFiles.length];
		String saveDirectory = application.getRealPath("/resources/upload/member/board");
		
		int i = 0;
		for(MultipartFile file : upFiles) {
			String ofn = file.getOriginalFilename();
			String rfn = HanaUtils.rename(ofn);
			File uploadImg = new File(saveDirectory, rfn);
			try {
				file.transferTo(uploadImg);
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage(), e);
			}
			picArr[i] = rfn;
			i++;
		};
		board.setPicture(picArr);
		
		Map<String, Object> map = new HashMap<>();
		map.put("board", board);
		map.put("reservationNo", reservationNo);
		map.put("checkedVal", checkedVal);
		
		int result = memberService.insertReview(map);
		String msg = result > 0 ? "???????????? ?????????????????????." : "?????? ??????";
		
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/member/memberSetting/myReservationList";		
	}
	

	@PostMapping("/profileUpdate")
	public String profileUpdate(@RequestParam MultipartFile upFile, RedirectAttributes redirectAttr, @AuthenticationPrincipal Member member) {
		String memberId = member.getId();
		
		log.info("member oldpic = {}", member.getPicture());
        
		String saveDirectory = application.getRealPath("/resources/upload/member/profile");
		File file = new	File(saveDirectory, member.getPicture());
		file.delete();
		  
		String renamedFilename = HanaUtils.rename(upFile.getOriginalFilename());
		File regFile = new File(saveDirectory, renamedFilename);
		  
		try {
			upFile.transferTo(regFile);
		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage(), e);
		}
		  
		member.setPicture(renamedFilename);	
		
		int result = memberService.updateMemberProfile(member);
		
		redirectAttr.addFlashAttribute("msg", result > 0 ? "?????????????????? ???????????? ???????????????." : "????????? ?????? ???????????? ??????");
		
		if(member.getAccountType() == 1) {
			return "redirect:/member/memberView/"+memberId;			
		} else {
			return "redirect:/member/shopView/"+memberId;
		}
	}
	
	
	//???????????? ????????????
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
				String msg = result > 0 ? "??????????????? ?????????????????????." : "???????????? ????????? ??????????????????.";
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
				String msg = "?????? ??????????????? ???????????? ????????????.";
				model.addAttribute("msg",msg);
				return "/member/memberSetting/updatePassword";	
			}
	}
	
	
	//????????? ????????????
	@GetMapping("/memberBoardDetail/{no}")
	public ResponseEntity<Map<String,Object>> boardDetail(@ModelAttribute Member member,
				@AuthenticationPrincipal Member loginMember, @PathVariable int no, Model model) { 
	
	//????????? ??????
	Board  boardDetail = memberService.selectOneBoard(no);
	log.info("boardDetail = {}", boardDetail);
	
	//???????????????
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
	
	//????????? ????????????
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
	
	 //?????????????????????
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
	    		
	    		resultMap.put("msg","????????? ?????? ??????");
	    		resultMap.put("result",result);
	    	}catch(Exception e) {
	    		log.error(e.getMessage(),e);
	    		resultMap.put("msg","????????? ?????? ??????");
	    	}
	    	
	    	return ResponseEntity.ok(resultMap);
	    	
	    }
	//????????????
	@PostMapping("/enrollBoardComment")
	@ResponseBody
	public Map<String,Object> enrollBoardComment(@RequestBody BoardComment boardComment){
		log.info("boardComment = {}",boardComment);
		int result = memberService.enrollBoardComment(boardComment);
		
		Map<String,Object> map = new HashMap<>();
		map.put("msg", "?????? ?????? ??????");
		map.put("result",result);
		return map;
	}
	
	//??????????????? ????????????
	@GetMapping("/getCommentList/{boardNo}")
	public ResponseEntity<List<BoardComment>> getCommentList(@PathVariable int boardNo){
		log.info("?????????!!!!!!!boardNo = {}",boardNo);
		List<BoardComment> list = memberService.selectBoardCommentList(boardNo);
		log.info("list = {}",list);
		return ResponseEntity.ok(list);
	}
	
	//?????? ????????????
	@DeleteMapping("/boardCommentDelete/{no}")
	public ResponseEntity<Map<String,Object>> boardCommentDelete(@PathVariable int no) {
		Map<String, Object> map = new HashMap<>();
		try{
			log.info("??????????????????.no = {}",no);
			int result = memberService.deleteBoardComment(no);
			log.info("result = {}",result);
			map.put("msg", "?????? ??????!");
			map.put("result",result);
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			map.put("msg", "?????? ??????, ??????????????? ??????");
		}
		return ResponseEntity.ok(map);
	}	
	
	//?????????
	@PostMapping("/like")
	public ResponseEntity<Map<String,Object>> like(@RequestParam int no, @AuthenticationPrincipal Member member){
		Map<String,Object> map = new HashMap<>();
		
		try {
			log.info("????????? no = {}",no);
			log.info("????????? member = {}",member);
			Map<String,Object> param = new HashMap<>();
			param.put("memberId",member.getId());
			param.put("boardNo",no);
			int result = memberService.insertLikeLog(param);
			
			map.put("msg", "like ??????");
			map.put("result", result);
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			map.put("result", "like ??????");
		}
		
		
		return ResponseEntity.ok(map);
	}
	
	//?????????
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
			
			map.put("msg", "unlike ??????");
			map.put("result", result);
		}catch(Exception e) {
			log.error(e.getMessage(),e);
			map.put("result", "unlike ??????");
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
	
	
	//?????? ?????????
	@PostMapping("/accountPrivate")
	 public String checkAccountPrivate(@RequestParam String id, @RequestParam (defaultValue ="1")int publicProfile, Model model, Member member,RedirectAttributes redirectAttr){
    	
    	try{
    		log.info("checkAccountPrivate.member.id = {}",id);
    		log.info("checkAccountPrivate.publicProfile = {}",publicProfile);
    		
    		Map<String,Object> map = new HashMap<>();
    		map.put("id",id);
    		map.put("publicProfile",publicProfile);
    		map.put("member",member);
    		
    		int result = memberService.checkAccountPrivate(map);
    		
    		redirectAttr.addFlashAttribute("msg", result > 0 ? "?????????????????????." : "????????? ??????????????????.");
    		model.addAttribute("publicProfile",publicProfile);
    		
    	}catch(Exception e) {
    		log.error(e.getMessage(),e);
       	}
    	return "redirect:/member/memberSetting/accountPrivate";
    	
    }
	 
	
	//????????? ??????
		@PostMapping("/requestFollowing")
		 public String requestFollowing(@RequestParam String myId, @RequestParam String friendId, @RequestParam String status,RedirectAttributes redirectAttr){
	    	
	    	try{
	    		log.info("requestFollowing.myId = {}",myId);
	    		log.info("requestFollowing.friendId = {}",friendId);
	    		log.info("requestFollowing.status = {}",status);
	    		
	    		Map<String,Object> map = new HashMap<>();
	    		map.put("myId",myId);
	    		map.put("friendId",friendId);
	    		map.put("status",status);
	    		
	    		int result = memberService.requestFollowing(map);
	    	 
	    		redirectAttr.addFlashAttribute("msg", result > 0 ? "???????????? ??????????????????." : "????????? ????????? ??????????????????.");
	    	
	    	}catch(Exception e) {
	    		log.error(e.getMessage(),e);
	       	}
	    	return "redirect:/member/memberView/" + friendId;
	    	
	    }
	
		@PostMapping("/reportUser")
		public ResponseEntity<?> reportUser(@RequestParam String reportUser, @RequestParam String reportedUser, @RequestParam String content) {
			Map<String, Object> map = new HashMap<>();
			map.put("reportUser", reportUser);
			map.put("reportedUser", reportedUser);
			map.put("content", content);
			
			int result = memberService.insertReport(map);
			
			return ResponseEntity.ok(result);
		}
	
		@GetMapping("/selectRestrictionData")
		public ResponseEntity<?> selectRestrictionData(@RequestParam String id){
			log.info("id = {}", id);
			
			Map<String, Object> data = memberService.selectRestrictionData(id);
			log.info("data = {}", data);
			
			return ResponseEntity.ok(data);
		}
	
		@PostMapping("/appealMyDistriction")
		public ResponseEntity<?> appealMyDistriction(@RequestParam String id){
			int result = memberService.appealMyDistriction(id);
			
			return ResponseEntity.ok(result);
		}

}
