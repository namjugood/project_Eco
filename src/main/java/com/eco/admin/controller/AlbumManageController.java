package com.eco.admin.controller;

import java.io.IOException;
import java.util.List;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eco.admin.service.IAlbumManageService;
import com.eco.admin.valid.AlbumValidator;
import com.eco.dao.ICountDao;
import com.eco.dao.IMusicDao;
import com.eco.dto.AlbumVO;
import com.eco.dto.Paging;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class AlbumManageController {
	
	@Autowired
	IAlbumManageService albumManageService;
	
	@Autowired
	IMusicDao musicDao;
	
	@Autowired
	ICountDao c;
	
	@RequestMapping("albumManageList")
	public ModelAndView albumManageList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("adminId");
		int page=1;
		String key = "";
		if(id==null)
			mav.setViewName("redirect:/admin");
		else {
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
				key = "";
				session.removeAttribute("key");
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
			int count = c.getAllCount("album_view", "title", key);
			paging.setTotalCount(count);
			paging.paging();
			List<AlbumVO> albumList = albumManageService.list(paging, key);
			mav.addObject("paging", paging);
			mav.addObject("key", key);
			mav.addObject("albumList", albumList);
			mav.setViewName("admin/album/albumManageList");
		}
		return mav;
	}
	

	//----------------------------------  albumManageInsertForm-------------------------------------------------------------
	@RequestMapping(value = "albumManageInsertForm", method = RequestMethod.GET)
	public String albumManageInsertForm(HttpServletRequest request, Model model
			, @ModelAttribute("AlbumVO") AlbumVO album
			) {
		model.addAttribute("ArtistList", albumManageService.getArtist());
		model.addAttribute("abtypeListByAlbum", musicDao.abtypeListByAlbum());
		model.addAttribute("genreList", musicDao.genreList());
		return "admin/album/albumManageInsertForm";
	}
	
	
	//-----------------------------------  albumManageInsert  -------------------------------------------------------------------
	@RequestMapping(value = "albumManageInsert", method = RequestMethod.POST)
	public String albumManageInsert(HttpServletRequest request, Model model
			, @ModelAttribute("album") AlbumVO album
			, BindingResult result , RedirectAttributes redirect
			) {

		// 세션 체크
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}
		
		model.addAttribute("ArtistList", albumManageService.getArtist());
		model.addAttribute("abtypeListByAlbum", musicDao.abtypeListByAlbum());
		model.addAttribute("genreList", musicDao.genreList());
		try {
			MultipartRequest multi = new MultipartRequest(
					request
					, ResourceUtils.getFile("classpath:static/upload/").toPath().toString()
					, 1024 * 1024 * 10
					, "UTF-8"
					, new DefaultFileRenamePolicy()
			);

			album.setTitle(multi.getParameter("title"));
			album.setAtseq(multi.getParameter("atseq") != null ? Integer.parseInt(multi.getParameter("atseq")) : 0);
			album.setGseq(multi.getParameter("gseq") != null ? Integer.parseInt(multi.getParameter("gseq")) : 0);
			album.setAbtype(multi.getParameter("abtype"));
			album.setNewabtype(multi.getParameter("newabtype"));
			album.setImg(multi.getParameter("img"));
			album.setImglink(multi.getParameter("imglink"));
			album.setContent(multi.getParameter("content"));
			album.setInputpdate(multi.getParameter("inputpdate"));
			album.setMode(multi.getParameter("mode"));
			
			AlbumValidator validator = new AlbumValidator();
			validator.validate(album, result);
	
			if (result.hasErrors()) {
				model.addAttribute("message", result.getFieldError().getField());
				return "admin/album/albumManageInsertForm";
			}
			
			// img
			album.setImglink(multi.getParameter("imglink"));
			String img = multi.getFilesystemName("img");
			if (album.getImglink() != null && !album.getImglink().equals("")) {
				img = album.getImglink();
			} else if (img != null) {
				img = "../upload/" + img;
			} else {
				img = null;
			}
			album.setImg(img);
			
			// abtype
			String abtype = null;
			if (album.getNewabtype() != null && !album.getNewabtype().equals("")) {
				abtype = album.getNewabtype();
			} else {
				abtype = album.getAbtype();
			}
			album.setAbtype(abtype);
					
		} catch (IOException e) {e.printStackTrace();}
		
		int res = albumManageService.insert(album);
		if (res > 0) {
			redirect.addFlashAttribute("message", "저장되었습니다.");
			return "redirect:/albumManageUpdateForm?abseq=" + album.getAbseq();
		} else {
			return "admin/album/albumManageInsertForm";
		}
	}
	
	
	//-----------------------------------  albumManageUpdateForm  -------------------------------------------------------------------
	@RequestMapping(value = "albumManageUpdateForm", method = RequestMethod.GET)
	public String albumManageUpdateForm(HttpServletRequest request, Model model
			, @RequestParam("abseq") int abseq
			) {
		model.addAttribute("ArtistList", albumManageService.getArtist());
		model.addAttribute("genreList", musicDao.genreList());
		model.addAttribute("abtypeListByAlbum", musicDao.abtypeListByAlbum());
		model.addAttribute("album", musicDao.getAlbum(abseq));
		return "admin/album/albumManageUpdateForm";
	}
	
	
	//-----------------------------------  albumManageUpdate  -------------------------------------------------------------------
	@RequestMapping(value = "albumManageUpdate", method = RequestMethod.POST)
	public String albumManageUpdate(HttpServletRequest request, Model model
			, @ModelAttribute("album") AlbumVO album
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

					album.setTitle(multi.getParameter("title"));
					album.setAtseq(multi.getParameter("atseq") != null ? Integer.parseInt(multi.getParameter("atseq")) : 0);
					album.setGseq(multi.getParameter("gseq") != null ? Integer.parseInt(multi.getParameter("gseq")) : 0);
					album.setAbtype(multi.getParameter("abtype"));
					album.setNewabtype(multi.getParameter("newabtype"));
					album.setImg(multi.getParameter("img"));
					album.setImglink(multi.getParameter("imglink"));
					album.setContent(multi.getParameter("content"));
					album.setMode(multi.getParameter("mode"));
					album.setAbseq(Integer.parseInt(multi.getParameter("abseq")));
					
					AlbumValidator validator = new AlbumValidator();
					validator.validate(album, result);

			        if (result.hasErrors()) {
			        	model.addAttribute("message", result.getFieldError().getField());
			        	model.addAttribute("ArtistList", albumManageService.getArtist());
			    		model.addAttribute("genreList", musicDao.genreList());
			    		model.addAttribute("abtypeListByAlbum", musicDao.abtypeListByAlbum());
			    		model.addAttribute("album", musicDao.getAlbum(album.getAbseq()));
			    		return this.albumManageUpdateForm(request, model, album.getAbseq());
			        } else {
			        	
			        	// img
			        	String img = multi.getFilesystemName("img");
						if (album.getImglink() != null && !album.getImglink().equals("")) {
							img = album.getImglink();
						} else if (img == null || img.equals("")) {
							img = album.getOldimg();
						} else {
							img = "/upload/" + img;
						}
						album.setImg(img);
						
						// abtype
						String abtype = null;
						if (album.getNewabtype() != null && !album.getNewabtype().equals("")) {
							abtype = album.getNewabtype();
						} else {
							abtype = album.getAbtype();
						}
						album.setAbtype(abtype);
						
						int res = albumManageService.update(album);
						
						if (res > 0) {
							model.addAttribute("message", "저장되었습니다.");
						}
			        }
			        
		        	model.addAttribute("ArtistList", albumManageService.getArtist());
		    		model.addAttribute("genreList", musicDao.genreList());
		    		model.addAttribute("abtypeListByAlbum", musicDao.abtypeListByAlbum());
		    		model.addAttribute("album", musicDao.getAlbum(album.getAbseq()));
					
					return "admin/album/albumManageUpdateForm";
					
				} catch (IOException e) {e.printStackTrace();}
		return "admin/album/albumManageUpdate";
	}
	
	
	//-----------------------------------  albumManageDelete  -------------------------------------------------------------------
	@RequestMapping(value = "albumManageDelete", method = RequestMethod.POST)
	public String albumManageDelete(HttpServletRequest request, Model model
			, @RequestParam("abseq") int abseq
			) {
		// 세션 체크
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}
		
		try {
			albumManageService.delete(abseq);
		} catch(Exception e) {
			model.addAttribute("message", "이미 앨범 곡이 있으므로 해당 앨범은 삭제가 불가능합니다.");
			return this.albumManageUpdateForm(request, model, abseq);
		}
		
		return "redirect:/albumManageList";
	}
	//----------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "AbtypeList", method = RequestMethod.GET)
	public String AbtypeList(HttpServletRequest request, Model model
			) {
		model.addAttribute("abtypeListByAlbum", musicDao.abtypeListByAlbum());
		return "admin/album/AbtypeList";
	}
	
}
