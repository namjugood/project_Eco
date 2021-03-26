package com.eco.admin.controller;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.eco.admin.service.IAdminService;
import com.eco.admin.service.IMemberManageService;
import com.eco.dao.ICountDao;
import com.eco.dto.MemberVO;
import com.eco.dto.Paging;

@Controller
public class MemberManageController {
	
	@Autowired
	IAdminService as;
	
	@Autowired
	IMemberManageService memberManageService;
	
	@Autowired
	ICountDao countDao;
	
	@RequestMapping("adminMemberDetail")
	public ModelAndView adminMemberDetail(HttpServletRequest request, 
			@RequestParam("useq") String useq) {
		ModelAndView mav = new ModelAndView();
		MemberVO mvo = memberManageService.getMember(useq);
		mav.addObject("memberVO", mvo);
		// 만료일 연산 및 송출
		Timestamp today = new Timestamp(0);
		if(mvo.getMembership().equals("Y")) {	// 멤버쉽이 Y면
			if(mvo.getEdate().getTime() - today.getTime() > 0) { // 만료일이 남았을 경우
				mav.addObject("endDate", "1"); // 이용권이 이미 구매됨
				System.out.println("만료일이 남았을 때 : "+mvo.getEdate());
			}else if(mvo.getEdate().getTime() - today.getTime() <=0) { // 만료일이거나 지날경우
				mav.addObject("endDate", "2"); // 이용권 구매하세요
				System.out.println("만료했을 때 : "+mvo.getEdate());
			}
		} else if(mvo.getMembership().equals("N")) {	// 멤버쉽이 N이면
			mav.addObject("endDate", "3"); // 이용권 구매하세요
			System.out.println("이용권 구매 안했을때 : "+mvo.getEdate());
		}
		mav.setViewName("admin/adminMemberDetail");
		return mav;
	}
	
	@RequestMapping("MemberManage")
	public ModelAndView MemberManage(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("adminId");
		
		int page=1;
		if(id==null)
			mav.setViewName("redirect:/admin");
		else {
			if( request.getParameter("first")!=null ) {
				session.removeAttribute("page");
				session.removeAttribute("key");
			}
			String key = "";
			if( request.getParameter("key") != null ) {
				key = request.getParameter("key");
				session.setAttribute("key", key);
			} else if( session.getAttribute("key")!= null ) {
				key = (String)session.getAttribute("key");
			} else {
				session.removeAttribute("key");
				key = "";
			} 
			if( request.getParameter("page") != null ) {
				page = Integer.parseInt(request.getParameter("page"));
				session.setAttribute("page", page);
			} else if( session.getAttribute("page")!= null) {
				page = (int) session.getAttribute("page");
			} else {
				page = 1;
				session.removeAttribute("page");
			}
			
			Paging paging = new Paging();
			paging.setPage(page);
			int count = countDao.getAllCount("member", "id", key);
			paging.setTotalCount(count);
			paging.paging();
			List<MemberVO> memberList = memberManageService.listMember(paging, key);
			mav.addObject("paging", paging);
			mav.addObject("key", key);
			mav.addObject("memberList", memberList);
			mav.setViewName("admin/MemberManage");
		}
		return mav;
	}
}
