package com.eco.admin.controller;

import java.util.List;

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
import org.springframework.web.servlet.ModelAndView;

import com.eco.admin.service.IBoardManageService;
import com.eco.admin.service.implement.BoardManageService;
import com.eco.dao.ICountDao;
import com.eco.dto.BoardVO;
import com.eco.dto.Paging;
import com.eco.service.BoardService;

@Controller
public class BoardManageController {

	/*
	 * @Autowired IBoardManageService BoardManageService;
	 */
	@Autowired
	IBoardManageService ibms;
	
	@Autowired
	BoardManageService bms;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	ICountDao countDao;
	
	@Autowired
	ICountDao c;
	
	@RequestMapping("noticeManageList")
	public ModelAndView noticeManageList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("adminId");
		
		String table = "notice";
		String field = "title";
		String order = "nseq";
		
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
			int count = countDao.getAllCount(table, field, key);
			System.out.println(count);
			paging.setTotalCount(count);
			paging.paging();
			System.out.println(paging);
			
			System.out.println(table + ", " + order + ", " + key + ", " + paging.getStartNum() + ", " + paging.getEndNum() + ", 끗 ");
			List<BoardVO> boardList = boardService.boardListSearch(table, order, key, paging.getStartNum(), paging.getEndNum());
			
			System.out.println("123"+boardList);
			mav.addObject("paging", paging);
			mav.addObject("key", key);
				
			mav.addObject("boardList", boardList);
			mav.setViewName("admin/noticeManageList");
		}
		return mav;
	}

	@RequestMapping("qnaManageList")
	public ModelAndView qnaManageList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("adminId");
		
		String table = "qna_view";
		String field = "title";
		String order = "replycontent";
		
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
			int count = countDao.getAllCount(table, field, key);
			System.out.println(count);
			paging.setTotalCount(count);
			paging.paging();
			System.out.println(paging);
			
			System.out.println(table + ", " + order + ", " + key + ", " + paging.getStartNum() + ", " + paging.getEndNum() + ", 끗 ");
			List<BoardVO> boardList = boardService.boardListSearch(table, order, key, paging.getStartNum(), paging.getEndNum());
			
			System.out.println("123"+boardList);
			mav.addObject("paging", paging);
			mav.addObject("key", key);
				
			mav.addObject("boardList", boardList);
			mav.setViewName("admin/qnaManageList");
		}
		return mav;
	}
	
	@RequestMapping("noticeInsertForm")
	public String noticeInsertForm(Model model, HttpServletRequest request) {
		return "admin/noticeInsertForm";
	}
	
	@RequestMapping("qnaInsertForm")
	public String qnaInsertForm(Model model, HttpServletRequest request) {
		return "admin/qnaInsertForm";
	}
	@RequestMapping(value = "adqnaInsert", method = RequestMethod.POST)
	public String adqnaInsert(@ModelAttribute("bvo") @Valid BoardVO boardVo,
			BindingResult result, Model model, HttpServletRequest request) {
		System.out.println("nI 시작"+boardVo);
		if(result.getFieldError("title")!=null) {
			model.addAttribute("message", "제목을 입력하세요");
			System.out.println("nI 제목");
			return "admin/qnaInsertForm";
		}else if(result.getFieldError("content")!=null) {
			model.addAttribute("message", "내용을 입력하세요");
			System.out.println("nI 내용");
			return "admin/qnaInsertForm";
		}
		System.out.println("nI 끝"+boardVo);
		bms.adqnaInsert(boardVo);
		return "redirect:/adqnaManageList";
	}
	
	@RequestMapping(value = "noticeInsert", method = RequestMethod.POST)
	public String noticeInsert(@ModelAttribute("bvo") @Valid BoardVO boardVo,
			BindingResult result, Model model, HttpServletRequest request) {
		System.out.println("nI 시작"+boardVo);
		if(result.getFieldError("ntitle")!=null) {
			model.addAttribute("message", "제목을 입력하세요");
			System.out.println("nI 제목");
			return "admin/noticeInsertForm";
		}else if(result.getFieldError("ncontent")!=null) {
			model.addAttribute("message", "내용을 입력하세요");
			System.out.println("nI 내용");
			return "admin/noticeInsertForm";
		}
		System.out.println("nI 끝"+boardVo);
		bms.noticeInsert(boardVo);
		return "redirect:/noticeManageList";
	}
	@RequestMapping(value = "searchOn", method = RequestMethod.GET)
	public ModelAndView searchOn(Model model, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		int page=1;
		
		String table = request.getParameter("tablename");
		String field = request.getParameter("fieldname");
		String order = request.getParameter("ordername");
		String key = request.getParameter("key");
		if( request.getParameter("first")!=null ) {
			session.removeAttribute("page");
			session.removeAttribute("key");
		}
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
		} else if( session.getAttribute("page")!= null  ) {
			page = (int) session.getAttribute("page");
		} else {
			page = 1;
			session.removeAttribute("page");
		}
		Paging paging = new Paging();
		paging.setPage(page);
		int count = c.getAllCount(table, field, key);
		System.out.println(count);
		paging.setTotalCount(count);
		paging.paging();
		System.out.println(paging);
		
		List<BoardVO> boardList = boardService.boardListSearch(table, order, key, paging.getStartNum(), paging.getEndNum());
		System.out.println(boardList);
		mav.addObject("paging", paging);
		
		model.addAttribute("searchYN", "searchY");
		model.addAttribute("boardList", boardList);
		mav.setViewName("admin/"+request.getParameter("url"));
		
		return mav;
	}
	
	@RequestMapping(value = "updateForm", method =  RequestMethod.GET)
	public ModelAndView updateForm(ModelAndView modelAndView, HttpServletRequest request) {
		
		String table = request.getParameter("tablename");
		String field = request.getParameter("fieldname");
		String key = request.getParameter("key");
		
		System.out.println(table+", "+ field + ", "+ key+". end");
		BoardVO bvoList = new BoardVO();
		
		bvoList = boardService.updateForm(table, field, key);
		modelAndView.addObject("bvoList", bvoList);
		System.out.println("업뎃폼 : " +bvoList);
		System.out.println("admin/"+request.getParameter("url"));
		modelAndView.setViewName("admin/"+request.getParameter("url"));
		return modelAndView;
	}
	@RequestMapping(value = "noticeUpdate", method = RequestMethod.POST)
	public String noticeUpdate(@ModelAttribute("bvoList") @Valid BoardVO boardVo,
			BindingResult result, Model model, HttpServletRequest request) {

		System.out.println("업뎃boardVo : "+boardVo);
		
		if(result.getFieldError("title")!=null) {
			model.addAttribute("message", "제목을 입력하세요");
			return "admin/noticeUpdateForm";
		}else if(result.getFieldError("content")!=null) {
			model.addAttribute("message", "내용을 입력하세요");
			return "admin/noticeUpdateForm";
		}
		
		bms.noticeUpdate(boardVo);
		return "redirect:noticeManageList";
	}
	
	@RequestMapping(value = "myqnaA", method = RequestMethod.POST)
	public String myqnaA(@ModelAttribute("bvoList") @Valid BoardVO boardVo,
			BindingResult result, Model model, HttpServletRequest request) {

		System.out.println("업뎃boardVo : "+boardVo);
		
		if(result.getFieldError("title")!=null) {
			model.addAttribute("message", "제목을 입력하세요");
			return "admin/myqnaAForm";
		}else if(result.getFieldError("content")!=null) {
			model.addAttribute("message", "내용을 입력하세요");
			return "admin/myqnaAeForm";
		}else if(result.getFieldError("replycontent")!=null) {
			model.addAttribute("message", "내용을 입력하세요");
			return "admin/myqnaAForm";
		}
		bms.myqnaA(boardVo);
		return "redirect:qnaManageList";
	}
	@RequestMapping("adqnaManageList")
	public ModelAndView adqnaManageList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("adminId");
		
		String table = "adminQna";
		String field = "title";
		String order = "adqseq";
		
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
			int count = countDao.getAllCount(table, field, key);
			System.out.println(count);
			paging.setTotalCount(count);
			paging.paging();
			System.out.println(paging);
			
			System.out.println(table + ", " + order + ", " + key + ", " + paging.getStartNum() + ", " + paging.getEndNum() + ", 끗 ");
			List<BoardVO> boardList = boardService.boardListSearch(table, order, key, paging.getStartNum(), paging.getEndNum());
			
			System.out.println("123"+boardList);
			mav.addObject("paging", paging);
			mav.addObject("key", key);
				
			mav.addObject("boardList", boardList);
			mav.setViewName("admin/adqnaManageList");
		}
		return mav;
	}
	
	@RequestMapping("adqnaInsertForm")
	public String adqnaInsertForm(Model model, HttpServletRequest request) {
		return "admin/adqnaInsertForm";
	}
	
	@RequestMapping(value = "adqnaUpdate", method = RequestMethod.POST)
	public String adqnaUpdate(@ModelAttribute("bvoList") @Valid BoardVO boardVo,
			BindingResult result, Model model, HttpServletRequest request) {

		System.out.println("업뎃boardVo : "+boardVo);
		
		if(result.getFieldError("title")!=null) {
			model.addAttribute("message", "제목을 입력하세요");
			return "admin/adqnaUpdateForm";
		}else if(result.getFieldError("content")!=null) {
			model.addAttribute("message", "내용을 입력하세요");
			return "admin/adqnaUpdateForm";
		}
		bms.adqnaUpdate(boardVo);
		return "redirect:adqnaManageList";
	}
	
}
