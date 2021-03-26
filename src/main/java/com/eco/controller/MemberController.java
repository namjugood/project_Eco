package com.eco.controller;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eco.dto.MemberVO;
import com.eco.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService ms;
	
	@RequestMapping("/loginForm")
	public String login_form(Model model, HttpServletRequest request) {
		return "member/login";
	}
	
	@RequestMapping(value="/login", method= {RequestMethod.GET,RequestMethod.POST})
	public String login(@ModelAttribute("dto") @Valid MemberVO membervo, 
			BindingResult result, Model model, RedirectAttributes redirect, HttpServletRequest request) {
		MemberVO mvo = ms.getMember(membervo.getId());
		if(result.getFieldError("id")!=null) {
			model.addAttribute("message", result.getFieldError("id").getDefaultMessage());
			return "member/login";
		}else if(result.getFieldError("pw")!=null) {
			model.addAttribute("message", result.getFieldError("pw").getDefaultMessage());
			return "member/login";
		}else if(mvo!=null) {	// 아이디가 입력된 경우
			if(mvo.getPw()!=null) {	// 비밀번호가 입력된 경우
				if(mvo.getPw().equals(membervo.getPw())) {	// 비밀번호가 일치하는 경우
					HttpSession session = request.getSession();
					session.setAttribute("loginUser", mvo);
					// 멤버십 검사
					Date today = new Date();
					System.out.println(today);
					System.out.println(today.getTime());
					System.out.println(mvo.getEdate().getTime());
					System.out.println(today.getTime() - mvo.getEdate().getTime());
					if(mvo.getMembership().equals("N") || today.getTime() - mvo.getEdate().getTime() >= 0) {
						// 멤버쉽이 N이거나 만료
						model.addAttribute("message", "12"); // 이용권 구매하세요
						System.out.println("이용권 구매 안했을때 : "+mvo.getMembership());
						ms.membershipExpire(mvo);
						return "member/membershipForm";
					} else {
						redirect.addFlashAttribute("message", "10"); // 이용권이 이미 구매됨
						session.setAttribute("membership", "Y");
						return "redirect:/";
					}
				}else {
					model.addAttribute("message", "1");
					return "member/login";
				}
			}else {
				model.addAttribute("message", "2");
				return "member/login";
			}
		}else {
			model.addAttribute("message", "3");
			return "member/login";
		}
	}
	
	@RequestMapping("logout")
	public String logout(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("contract")
	public String contract(Model model, HttpServletRequest request) {
		return "member/contract";
	}
	
	@RequestMapping(value="joinForm", method=RequestMethod.POST)
	public String joinForm(Model model, HttpServletRequest request) {
		return "member/joinForm";
	}
	
	@RequestMapping("idCheckForm")
	public String id_check_form(Model model, HttpServletRequest request,
			@RequestParam("id") String id) {
		MemberVO mvo = ms.getMember(id);
		int result = 0;
		if(mvo==null)	result=-1;
		else result=1;
		
		model.addAttribute("result", result);
		model.addAttribute("id", id);
		return "member/idCheck";
	}
	
	
	@RequestMapping(value="join", method= {RequestMethod.GET,RequestMethod.POST})
	public String join(@ModelAttribute("dto") @Valid MemberVO membervo,
			BindingResult result, Model model, HttpServletRequest request) {
		
		int duplicatedPhoneUserCount = ms.getDuplicatedPhoneUserCount(membervo.getPhone()); 
		System.out.println("duplicatedPhoneUserCount");
		System.out.println(duplicatedPhoneUserCount);
		
		if(result.getFieldError("id")!=null) {
			model.addAttribute("message1", result.getFieldError("id").getDefaultMessage());
			model.addAttribute("reid", request.getParameter("reid"));
			return "member/joinForm";
		}else if(result.getFieldError("pw")!=null) {
			model.addAttribute("message2", "비밀번호를 입력하세요");
			model.addAttribute("reid", request.getParameter("reid"));
			return "member/joinForm";
		}else if(result.getFieldError("name")!=null) {
			model.addAttribute("message3", result.getFieldError("name").getDefaultMessage());
			model.addAttribute("reid", request.getParameter("reid"));
			return "member/joinForm";
		}else if(result.getFieldError("phone")!=null) {
			model.addAttribute("message4", result.getFieldError("phone").getDefaultMessage());
			model.addAttribute("reid", request.getParameter("reid"));
			return "member/joinForm";
		}else if(!request.getParameter("reid").equals(membervo.getId())) {
			model.addAttribute("message5", "아이디 중복검사를 실행해주세요");
			//model.addAttribute("reid", request.getParameter("reid"));
			return "member/joinForm";
		}else if(!request.getParameter("pwCheck").equals(membervo.getPw())){
			model.addAttribute("message6", "입력하신 비밀번호가 일치하지 않습니다");
			model.addAttribute("reid", request.getParameter("reid"));
			return "member/joinForm";
		}else if(duplicatedPhoneUserCount > 0) {
			model.addAttribute("message4", "이미 등록된 전화번호가 있습니다");
			return "member/joinForm";	
		}
		ms.insertMember(membervo);
		return "member/login";
	}
	
	
	@RequestMapping("resetPw")
	public String certificationNum(@ModelAttribute("dto") @Valid MemberVO membervo,
			BindingResult result, Model model, HttpServletRequest request,
			@RequestParam("pwd_chk") String pwd_chk) {
		System.out.println("System.out.println(membervo);");
		System.out.println(membervo);
		
		if(result.getFieldError("pw")!=null) {
			model.addAttribute("msg", "비밀번호를 입력해주세요"); //"비밀번호를 입력해주세요"
			return "member/resetPassword";
		}else if(!membervo.getPw().equals(pwd_chk)) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다"); // 비밀번호가 일치하지 않습니다
			return "member/resetPassword";
		}else {
			ms.resetPw(membervo);
			return "member/resetPwComplete";
		}
	}
	
	
	// 아이디찾기 인증번호 확인
	@RequestMapping("findIdCertificationNum")
	public String certificationNum(Model model, HttpServletRequest request,
			@RequestParam("name") String name, @RequestParam("phone") String phone,
			@RequestParam("id") String id, @RequestParam("inputNum") String inputNum) {
		
		MemberVO mvo = new MemberVO();
		mvo.setId(id);
		mvo.setName(name);
		mvo.setPhone(phone);
		model.addAttribute("member", mvo);
		if(inputNum.equals("0000")) {			
			return "member/viewId";
		}else {
			model.addAttribute("msg", "인증번호를 확인해주세요");
			return "member/findId_CertificationNumber";
		}
	}
	
	// 비밀번호 찾기 인증번호 확인
	@RequestMapping("findPwCertificationNum")
	public String findPwCertificationNum(Model model, HttpServletRequest request,
			@RequestParam("name") String name, @RequestParam("phone") String phone,
			@RequestParam("id") String id, @RequestParam("inputNum") String inputNum) {
		
		MemberVO mvo = new MemberVO();
		mvo.setId(id);
		mvo.setName(name);
		mvo.setPhone(phone);
		model.addAttribute("member", mvo);
		if(inputNum.equals("0000")) 
			return "member/resetPassword";
		else 
			model.addAttribute("msg", "인증번호를 확인해주세요");
			return "member/findPw_CertificationNumber";
	}
	
	//아이디 찾기_이름 전화번호 검색
	@RequestMapping("lookupNamePhone")
	public String lookupNamePhone(Model model, HttpServletRequest request,
			@RequestParam("name") String name, @RequestParam("phone") String phone ) {
		MemberVO mvo = ms.confirmNamePhone(name, phone);
		if(mvo==null) {
			model.addAttribute("msg", "이름과 전화번호가 일치하는 회원이 없습니다");
			model.addAttribute("name", name);
			model.addAttribute("phone", phone);
			return "member/findIdForm";
		}else {
			model.addAttribute("member", mvo);
			return "member/findId_CertificationNumber";
		}
		
	}
	//비밀번호 찾기_아이디, 이름 전화번호 검색
	@RequestMapping("lookupIdNamePhone")
	public String lookupIdNamePhone(Model model, HttpServletRequest request,
			@RequestParam("name") String name, @RequestParam("phone") String phone,
			@RequestParam("id") String id) {
		MemberVO mvo = ms.confirmIdNamePhone(id, name, phone);
		if(mvo==null) {
			model.addAttribute("msg", "아이디 이름 전화번호가 일치하는 회원이 없습니다");
			model.addAttribute("id", id);
			model.addAttribute("name", name);
			model.addAttribute("phone", phone);
			return "member/findPwForm";
		}else {
			model.addAttribute("member", mvo);
			return "member/findPw_CertificationNumber";
		}
	}
	
	
	
	// 아이디 찾기_이름, 전화번호 입력창으로 이동
	@RequestMapping("findIdForm")
	public String find_id_form(Model model, HttpServletRequest request) {
		return "member/findIdForm";
	}
	
	// 비번 찾기_아이디, 이름, 전화번호 입력창으로 이동
	@RequestMapping("findPwForm")
	public String findPwForm(Model model, HttpServletRequest request) {
		return "member/findPwForm";
	}
	
		
	// 팝업창 최초
	@RequestMapping("findIdPw")
	public String find_id_pw(Model model, HttpServletRequest request) {
		return "member/findIdPwForm";
	}
	
	@RequestMapping("pwChecking")
	public String pw_checking(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session!=null) {
			session.setAttribute("id", session);
			session.setAttribute("pw", session);
			return "member/pwChecking";
		}else {
			return "redirect:/";
		}
	}
	
	// 회원정보 수정 전 비밀번호 recheck
	@RequestMapping("pwRechecking")
	public String pw_Rechecking(@RequestParam("pw") String pw,
			Model model, HttpServletRequest request) {	
		MemberVO mvo = (MemberVO) request.getSession().getAttribute("loginUser");
		System.out.println("System.out.println(mvo);");
		System.out.println(mvo);
		if (mvo != null) {
			if(!pw.isEmpty()) {
				if(pw.equals(mvo.getPw())) {
					// 멤버쉽 만료일 연산
					Timestamp today = new Timestamp(0);
					if(mvo.getEdate().getTime() - today.getTime() >0) {
						model.addAttribute("endDate", "1");	// 기간표시
					}else {
						model.addAttribute("endDate", "2"); // 기간표시 X
					}
					return "member/memberUpdateForm";
				}else {
					model.addAttribute("message", "비밀번호가 일치하지 않습니다");
					return "member/pwChecking";
				}	
			}else {
				model.addAttribute("message", "비밀번호를 입력하세요");
				return "member/pwChecking";
			}	
		} else {
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="memberUpdate", method= {RequestMethod.GET,RequestMethod.POST})
	public String member_update(@ModelAttribute("member") @Valid MemberVO membervo,
			BindingResult result, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		// 멤버쉽 기간 표시
		
		if(result.getFieldError("pw")!=null) {
			model.addAttribute("message2", "비밀번호를 입력하세요");
			return "member/memberUpdateForm";
		}else if(result.getFieldError("name")!=null) {
			model.addAttribute("message3", result.getFieldError("name").getDefaultMessage());
			return "member/memberUpdateForm";
		}else if(result.getFieldError("phone")!=null) {
			model.addAttribute("message4", result.getFieldError("phone").getDefaultMessage());
			return "member/memberUpdateForm";
		}else if(!request.getParameter("pwCheck").equals(membervo.getPw())){
			model.addAttribute("message6", "입력하신 비밀번호가 일치하지 않습니다");
			return "member/memberUpdateForm";
		}	
		
		ms.updateMember(membervo);
		MemberVO modifiedMember = ms.getMember(membervo.getId());
		session.setAttribute("loginUser", modifiedMember);
		return "redirect:/";
	}
	
	// 멤버쉽 페이지 이동 
	@RequestMapping("/membership")
	public String membership(Model model, HttpServletRequest request) {
		return "member/membershipForm";
	}
	
	// 이용권 구매 시 멤버쉽 부여
	@RequestMapping(value="/buying", method = {RequestMethod.GET,RequestMethod.POST})
	public String Buying(@ModelAttribute("dto") @Valid MemberVO membervo,
			BindingResult result, Model model, RedirectAttributes redirect, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser"); 
		if( mvo==null ) { 		// 로그인되어 있지 않으면
			//System.out.println("1 : "+mvo.getMembership());
			// membership 상태확인 }
			model.addAttribute("message", "10");
			//System.out.println("구매페이지에서 로그인 안되어있으면 : "+mvo.getMembership());
			return "member/login"; 
		}else if(mvo!=null){  // 로그인 되어있으면
			mvo = ms.getMember(mvo.getId());	// 로그인 후 mvo 내용 재조회
			System.out.println("구매페이지 로그인되어있을때 : "+mvo.getMembership());
			//System.out.println("3-2 : "+request.getParameter("membership"));
			if(mvo.getMembership().equals("Y")) {		//이용권 구매가 되어있으면	
				System.out.println("이미 구매되어있으면 Y : "+mvo.getMembership());
				redirect.addFlashAttribute("message", "11");	// 이미 구매되어있음
				//System.out.println("param2 : "+request.getSession().toString());
				return "redirect:/";
			}else if(mvo.getMembership().equals("N")){		// 이용권 구매가 안되어있으면
				System.out.println("구매 안되어있으면  N : "+mvo.getMembership());
				if( request.getParameter("membership").equals("1")){	//30일 구매시
					ms.buyMembership30(mvo);		// DB에 값변경(getMembership -> buyMembership)
					System.out.println("30일 구매후 : "+mvo.getEdate());
				}else if(request.getParameter("membership").equals("2")){	// 7일 구매시
					ms.buyMembership7(mvo);
					System.out.println("7일 구매후 : "+mvo.getEdate());
				}else if( request.getParameter("membership").equals("3")){	// 1일 구매시
					ms.buyMembership1(mvo);
					System.out.println("1일 구매후 : "+mvo.getEdate());
				}	
				mvo = ms.getMember(mvo.getId()); // DB에서 변경내용 조회
				session.setAttribute("membership", "Y");
				System.out.println("구매후 흔적 : "+mvo.getEdate());
			}
			session.setAttribute("loginUser", mvo);
			redirect.addFlashAttribute("message", "12");
			System.out.println("구매결과 : "+mvo.getMembership());
			//System.out.println("param3 : "+request.getSession().toString());
		}
		return "redirect:/";
	}
	
	
	
}	

