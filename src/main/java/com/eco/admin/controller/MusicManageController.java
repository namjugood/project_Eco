package com.eco.admin.controller;

import java.util.Arrays;
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

import com.eco.admin.service.IAlbumManageService;
import com.eco.admin.service.IArtistManageService;
import com.eco.admin.service.IMusicManageService;
import com.eco.dao.ICountDao;
import com.eco.dao.IMusicDao;
import com.eco.dto.AlbumVO;
import com.eco.dto.ArtistVO;
import com.eco.dto.MusicVO;
import com.eco.dto.Paging;

@Controller
public class MusicManageController {
	
	@Autowired
	IArtistManageService artistManageService;
	
	@Autowired
	IAlbumManageService albumManageService;
	
	@Autowired
	IMusicManageService musicManageService;
	
	@Autowired
	IMusicDao musicDao;
	
	@Autowired
	ICountDao c;
	
	@RequestMapping(value = "musicManageList", method = RequestMethod.GET)
	public String musicManageList(HttpServletRequest request, Model model
			, @ModelAttribute("search") MusicVO search
			, Paging searchPaging
			) {
		
		// 세션 체크
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}
		
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
		
		return "admin/musicManageList";
	}

	@RequestMapping(value = "musicManageInsertForm", method = RequestMethod.GET)
	public String musicManageInsertForm(HttpServletRequest request, Model model
			, @ModelAttribute("music") MusicVO music
			) {
	
		model.addAttribute("themeList", musicDao.themeList());
		model.addAttribute("chartList", musicDao.chartList());
		model.addAttribute("genreList", musicDao.genreList());
		return "admin/musicManageInsertForm";
	}

	@RequestMapping(value = "musicManageInsert", method = RequestMethod.POST)
	public String musicManageInsert(HttpServletRequest request, Model model
			, @ModelAttribute("music") @Valid MusicVO music
			, BindingResult result
			, RedirectAttributes redirect
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
			return this.musicManageInsertForm(request, model, music); 
		}

		int res = musicManageService.insert(music);
		if (res > 0) {
			redirect.addFlashAttribute("message", "저장되었습니다.");
			return "redirect:/musicManageUpdateForm?mseq=" + music.getMseq();
		} else {
			return "admin/musicManageInsertForm";
		}
	}

	@RequestMapping(value = "musicManageUpdateForm", method = RequestMethod.GET)
	public String musicManageUpdateForm(HttpServletRequest request, Model model
			, @RequestParam("mseq") int mseq
			) {
		
		MusicVO music = musicDao.getMusic(mseq);
		
		String theme = music.getTheme() == null ? "" : music.getTheme();
		music.setTseqs(Arrays.asList(theme.split("\\|")));
		
		String chart = music.getChart() == null ? "" : music.getChart();
		music.setCseqs(Arrays.asList(chart.split("\\|")));
		
		model.addAttribute("themeList", musicDao.themeList());
		model.addAttribute("chartList", musicDao.chartList());
		model.addAttribute("genreList", musicDao.genreList());
		model.addAttribute("music", music);
		return "admin/musicManageUpdateForm";
	}

	@RequestMapping(value = "musicManageUpdate", method = RequestMethod.POST)
	public String musicManageUpdate(HttpServletRequest request, Model model
			, @ModelAttribute("music") @Valid MusicVO music
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
			return this.musicManageUpdateForm(request, model, music.getMseq()); 
		}

		int res = musicManageService.update(music);
		if (res > 0) {
			model.addAttribute("message", "저장되었습니다.");
		}
		return this.musicManageUpdateForm(request, model, music.getMseq());
	}

	@RequestMapping(value = "musicManageDelete", method = RequestMethod.POST)
	public String musicManageDelete(HttpServletRequest request, Model model
			, @RequestParam("mseq") int mseq
			) {
		// 세션 체크
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}
		
		try {
			musicManageService.delete(mseq);	
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "해당 곡과 관련하여 다른 데이터가 존재하므로 삭제가 불가합니다.");
			return this.musicManageUpdateForm(request, model, mseq);
		}
		
		return "redirect:/musicManageList";
	}
	
	@RequestMapping(value = "findArtist", method = RequestMethod.GET)
	public String findArtist(HttpServletRequest request, Model model
			, @ModelAttribute("search") ArtistVO search
			, Paging searchPaging
			) {
		
		// 검색조건에 의한 갯수조회
		search.setSearchTable("artist_view"); // 검색조건 테이블 저장
		int count = c.count(search);
		
		// 페이징
		Paging paging = new Paging();
		paging.setPage(search.getPage());
		paging.setDisplayRow(searchPaging.getDisplayRow());
		paging.setTotalCount(count);
		paging.paging();
		search.setPaging(paging);

		model.addAttribute("groupynList", musicDao.groupynListByArtist());

		model.addAttribute("genderList", musicDao.genderListByArtist());
		
		model.addAttribute("genreListIncludedArtist", musicDao.genreListIncludedArtist());

		// 페이징과 검색조건에 의한 조회 그리고 저장
		model.addAttribute("artistList", artistManageService.list(search));
		
		return "admin/findArtist";
	}
	
	@RequestMapping(value = "findAlbum", method = RequestMethod.GET)
	public String findAlbum(HttpServletRequest request, Model model
			, @ModelAttribute("search") AlbumVO search
			, Paging searchPaging
			) {
		
		// 검색조건에 의한 갯수조회
		search.setSearchTable("album_view"); // 검색조건 테이블 저장
		int count = c.count(search);

		// 페이징
		Paging paging = new Paging();
		paging.setPage(search.getPage());
		paging.setDisplayRow(searchPaging.getDisplayRow());
		paging.setTotalCount(count);
		paging.paging();
		search.setPaging(paging);

		model.addAttribute("genreListByAlbum", musicDao.genreListByAlbum());

		model.addAttribute("abtypeListByAlbum", musicDao.abtypeListByAlbum());
		
		// 페이징과 검색조건에 의한 조회 그리고 저장
		model.addAttribute("albumList", albumManageService.list4find(search));

		return "admin/findAlbum";
	}
	
}
