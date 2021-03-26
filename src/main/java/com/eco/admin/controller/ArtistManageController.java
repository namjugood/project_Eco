package com.eco.admin.controller;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eco.admin.service.IArtistManageService;
import com.eco.admin.valid.ArtistValidator;
import com.eco.dao.ICountDao;
import com.eco.dao.IMusicDao;
import com.eco.dto.ArtistVO;
import com.eco.dto.Paging;
import com.eco.util.MultiToObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class ArtistManageController {
	
	@Autowired
	IArtistManageService artistManageService;

	@Autowired
	IMusicDao musicDao;
	
	@Autowired
	ICountDao c;
	
	@RequestMapping("artistManageList")
	public String artistManageList(HttpServletRequest request, Model model
			, @ModelAttribute("search") ArtistVO search
			, Paging searchPaging
			) {
		
		// 세션 체크
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}

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
		
		return "admin/artistManageList";
	}

	
	@RequestMapping(value = "artistManageInsertForm", method = RequestMethod.GET)
	public String artistManageInsertForm(HttpServletRequest request, Model model
			, @ModelAttribute("artist") ArtistVO artist
			) {
		model.addAttribute("genreList", musicDao.genreList());
		return "admin/artistManageInsertForm";
	}
	
	@RequestMapping(value = "artistManageInsert", method = RequestMethod.POST)
	public String artistManageInsert(HttpServletRequest request, Model model
			, @ModelAttribute("artist") ArtistVO artist
			, BindingResult result
			, RedirectAttributes redirect
			) {
		// 세션 체크
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}
		
		model.addAttribute("genreList", musicDao.genreList());
		
		try {
			MultipartRequest multi = new MultipartRequest(
					request
					, ResourceUtils.getFile("classpath:static/upload/").toPath().toString()
					, 1024 * 1024 * 10
					, "UTF-8"
					, new DefaultFileRenamePolicy()
			);
			
			MultiToObject.copy(multi, artist); // multi.getParameter("");노가다 대체
			result = MultiToObject.valid(artist, result, ArtistValidator.class);

	        if (result.hasErrors()) {
				model.addAttribute("message", result.getAllErrors().stream().map(error -> {
					return error.getDefaultMessage();
				}).collect(Collectors.toList()));
	        	model.addAttribute("errors", result.getAllErrors());
	        	return "admin/artistManageInsertForm";
	        }
			
			artist.setImglink(multi.getParameter("imglink"));
			String img = multi.getFilesystemName("img");
			if (artist.getImglink() != null && !artist.getImglink().equals("")) {
				img = artist.getImglink();
			} /*else if (img == null || img.equals("")) {
				img = artist.getOldimg();
			} */
			else if (img != null) {
				img = "/upload/" + img;
			} else {
				img = null;
			}
			artist.setImg(img);
			
		} catch (IOException e) {e.printStackTrace();}
		
		int res = artistManageService.insert(artist);
		if (res > 0) {
			redirect.addFlashAttribute("message", "저장되었습니다.");
			return "redirect:/artistManageUpdateForm?atseq=" + artist.getAtseq();
		} else {
			return "admin/artistManageInsertForm";
		}
	}
	
	@RequestMapping(value = "artistManageUpdateForm", method = RequestMethod.GET)
	public String artistManageUpdateForm(HttpServletRequest request, Model model
			, @RequestParam("atseq") int atseq
			) {
		model.addAttribute("genreList", musicDao.genreList());
		model.addAttribute("artist", musicDao.getArtist(atseq));
		return "admin/artistManageUpdateForm";
	}
	
	@RequestMapping(value = "artistManageUpdate", method = RequestMethod.POST)
	public String artistManageUpdate(HttpServletRequest request, Model model
			, @ModelAttribute("artist") ArtistVO artist
			, BindingResult result
			) {
		
		// 세션 체크
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}
				
		try {
			MultipartRequest multi = new MultipartRequest(
					request
					, ResourceUtils.getFile("classpath:static/upload/").toPath().toString()
					, 1024 * 1024 * 10
					, "UTF-8"
					, new DefaultFileRenamePolicy()
			);

			MultiToObject.copy(multi, artist); // multi.getParameter("");노가다 대체
			MultiToObject.valid(artist, result, ArtistValidator.class);

	        if (result.hasErrors()) {
	        	model.addAttribute("message", result.getAllErrors().stream().map(error -> {
					return error.getDefaultMessage();
				}).collect(Collectors.toList()));
	        	model.addAttribute("errors", result.getAllErrors());
	        	model.addAttribute("genreList", musicDao.genreList());
	    		model.addAttribute("artist", musicDao.getArtist(artist.getAtseq()));
	    		return "admin/artistManageUpdateForm";
	        } else {
	        	String img = multi.getFilesystemName("img");
				if (artist.getImglink() != null && !artist.getImglink().equals("")) {
					img = artist.getImglink();
				} else if (img == null || img.equals("")) {
					img = artist.getOldimg();
				} else {
					img = "/upload/" + img;
				}
				artist.setImg(img);
				

				int res = artistManageService.update(artist);
				
				if (res > 0) {
					model.addAttribute("message", "저장되었습니다.");
				}
	        }
	        
	        model.addAttribute("genreList", musicDao.genreList());
			model.addAttribute("artist", musicDao.getArtist(artist.getAtseq()));
			
			return "admin/artistManageUpdateForm";
			
		} catch (IOException e) {e.printStackTrace();}
		return "admin/artistManageUpdateForm";
	}
	
	@RequestMapping(value = "artistManageDelete", method = RequestMethod.POST)
	public String artistManageDelete(HttpServletRequest request, Model model
			, @RequestParam("atseq") int atseq
			) {
		// 세션 체크
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}
		
		
		try {
			artistManageService.delete(atseq);
		} catch(Exception e) {
			model.addAttribute("message", "이미 앨범 또는 곡이 있으므로 해당 아티스트는 삭제가 불가능합니다.");
			return this.artistManageUpdateForm(request, model, atseq);
		}
		
		
		return "redirect:/artistManageList";
	}
}
