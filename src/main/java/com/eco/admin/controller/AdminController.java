package com.eco.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.eco.admin.service.IAdminService;

@Controller
public class AdminController {

	@Autowired
	IAdminService as;
	
	@RequestMapping("/admin")
	public String adminIndex(Model model, HttpServletRequest request) {
		String adminId = (String) request.getSession().getAttribute("adminId");
		if (adminId != null && !adminId.equals("")) {
			return "redirect:/AIndex"; // 이미 어드민의 세션정보가 있는 경우, 굳이 재로그인할 필요없이 메인으로 이동케
		} else {
			return "admin/adminLogin";	
		}
	}
	
	@RequestMapping("/adminLogout")
	public String adminLogout(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("adminId");
		return "admin/adminLogin";	
	}
	
	@RequestMapping("/AIndex")
	public String AIndex(Model model) {
		return "admin/AIndex";
	}
	
	@RequestMapping("adminLogin")
	public ModelAndView admin_login(Model model, HttpServletRequest request,
			@RequestParam("adminId") String adminId, 
			@RequestParam("adminPw") String adminPw){
		ModelAndView mav = new ModelAndView();
		int result = as.adminCheck(adminId, adminPw);
		if(result==1) {
			HttpSession session=request.getSession();
			session.setAttribute("adminId", adminId);
			mav.setViewName("admin/AIndex");
		}else if(result==0) {
			mav.addObject("message", "비밀번호를 확인하세요");
			mav.setViewName("admin/adminLogin");
		}else if(result==-1) {
			mav.addObject("message", "아이디를 확인하세요");
			mav.setViewName("admin/adminLogin");
		}
		return mav;
	}
}
