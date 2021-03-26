package com.eco.admin.controller;

import java.util.List;
import java.util.stream.Collectors;

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

import com.eco.admin.dao.IBundleManageDao;
import com.eco.admin.service.IBundleManageService;
import com.eco.admin.service.IMusicManageService;
import com.eco.dao.ICountDao;
import com.eco.dao.IMusicDao;
import com.eco.dto.BundleVO;
import com.eco.dto.MusicVO;
import com.eco.dto.Paging;

@Controller
public class BundleManageController {
	
	@Autowired
	IMusicManageService musicManageService;
	
	@Autowired
	IBundleManageService bundleManageService;
	
	@Autowired
	IMusicDao musicDao;
	
	@Autowired
	IBundleManageDao bundleDao;
	
	@Autowired
	ICountDao c;
	
	@RequestMapping(value = "bundleManageList", method = RequestMethod.GET)
	public String bundleManageList(HttpServletRequest request, Model model
			, @ModelAttribute("search") BundleVO search
			, Paging searchPaging
			) {
		
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}
		
		search.setSearchTable("bundle_view");
		int count = c.count(search);
		
		// 페이징
		Paging paging = new Paging();
		paging.setPage(search.getPage());
		paging.setDisplayRow(searchPaging.getDisplayRow());
		paging.setTotalCount(count);
		paging.paging();
		search.setPaging(paging);

		// 페이징과 검색조건에 의한 조회 그리고 저장
		model.addAttribute("bundleList", bundleManageService.list(search));
		
		return "admin/bundleManageList";
	}

	@RequestMapping(value = "bundleManageInsertForm", method = RequestMethod.GET)
	public String bundleManageInsertForm(HttpServletRequest request, Model model
			, @ModelAttribute("bundle") BundleVO bundle
			) {
	
		return "admin/bundleManageInsertForm";
	}

	@RequestMapping(value = "bundleManageInsert", method = RequestMethod.POST)
	public String bundleManageInsert(HttpServletRequest request, Model model
			, @ModelAttribute("bundle") @Valid BundleVO bundle
			, BindingResult result
			, RedirectAttributes redirect
			) {
		
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}
		
		if (result.hasErrors()) {
			model.addAttribute("message", result.getAllErrors().stream().map(error -> {
				return error.getDefaultMessage();
			}).collect(Collectors.toList()));
			model.addAttribute("errors", result.getAllErrors());
			return this.bundleManageInsertForm(request, model, bundle);
		}
		
		int res = bundleManageService.insert(bundle);
		
		if (res > 0) {
			redirect.addFlashAttribute("message", "저장되었습니다.");
			return "redirect:/bundleManageUpdateForm?bmseq=" + bundle.getBmseq();
		} else {
			return "admin/bundleManageInsertForm";
		}
	}

	@RequestMapping(value = "bundleManageUpdateForm", method = RequestMethod.GET)
	public String bundleManageUpdateForm(HttpServletRequest request, Model model
			, @RequestParam("bmseq") int bmseq
			) {
		
		BundleVO bundle = bundleDao.getBundle(bmseq);
		
		List<MusicVO> detailMusicList = musicDao.musicListByBundle(bmseq);
		
		model.addAttribute("bundle", bundle);
		model.addAttribute("detailList", detailMusicList);
		
		return "admin/bundleManageUpdateForm";
	}
	
	@RequestMapping(value = "bundleManageDetailSave", method = RequestMethod.POST)
	public String bundleManageDetailSave(HttpServletRequest request, Model model
			, @RequestParam("bmseq") int bmseq
			) {

		int result = bundleManageService.detailSave(bmseq, request.getParameterValues("mseq"));
		
		if (result > 0) {
			model.addAttribute("message", "정상적으로 저장되었습니다.");
		} else {
			model.addAttribute("message", "저장중에 실패했습니다. 다시 시도하여주시기바랍니다.");
		}
		
		return this.bundleManageUpdateForm(request, model, bmseq);
	}

	@RequestMapping(value = "bundleManageUpdate", method = RequestMethod.POST)
	public String bundleManageUpdate(HttpServletRequest request, Model model
			, @ModelAttribute("bundle") @Valid BundleVO bundle
			, BindingResult result
			) {
		// 세션 체크
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}
		
		if (result.hasErrors()) {
			model.addAttribute("message", result.getAllErrors().stream().map(error -> {
				return error.getDefaultMessage();
			}).collect(Collectors.toList()));
			model.addAttribute("errors", result.getAllErrors());
			return this.bundleManageUpdateForm(request, model, bundle.getBmseq()); 
		}

		int res = bundleManageService.update(bundle);
		if (res > 0) {
			model.addAttribute("message", "저장되었습니다.");
		}
		return this.bundleManageUpdateForm(request, model, bundle.getBmseq());
	}

	@RequestMapping(value = "bundleManageDelete", method = RequestMethod.POST)
	public String bundleManageDelete(HttpServletRequest request, Model model
			, @RequestParam("bmseq") int bmseq
			) {
		// 세션 체크
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}
		
		bundleManageService.delete(bmseq);
		
		return "redirect:/bundleManageList";
	}
	
	@RequestMapping(value = "findMusic", method = RequestMethod.GET)
	public String findMusic(HttpServletRequest request, Model model
			, @ModelAttribute("search") BundleVO search
			, Paging searchPaging
			) {
		// 검색조건에 의한 갯수조회
		search.setSearchTable("music_view"); // 검색조건 테이블 저장
		int count = c.count(search);
		
		// 페이징
		Paging paging = new Paging();
		paging.setPage(search.getPage());
		paging.setDisplayRow(searchPaging.getDisplayRow());
		paging.setTotalCount(count);
		paging.paging();
		search.setPaging(paging);

		model.addAttribute("themeListIncludedMusic", musicDao.themeListIncludedMusic()); 
		model.addAttribute("chartListIncludedMusic", musicDao.chartListIncludedMusic()); 
		model.addAttribute("genreListIncludedMusic", musicDao.genreListIncludedMusic()); 

		// 페이징과 검색조건에 의한 조회 그리고 저장
		model.addAttribute("musicList", musicManageService.list(search));
		
		return "admin/findMusic";
	}
	
}
