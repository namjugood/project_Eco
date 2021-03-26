package com.eco.admin.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

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

import com.eco.admin.service.IMusicManageService;
import com.eco.admin.service.implement.TCGService;
import com.eco.admin.valid.ChartValidator;
import com.eco.admin.valid.GenreValidator;
import com.eco.admin.valid.ThemeValidator;
import com.eco.dao.ICountDao;
import com.eco.dto.ChartVO;
import com.eco.dto.GenreVO;
import com.eco.dto.MusicVO;
import com.eco.dto.Paging;
import com.eco.dto.ThemeVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class TCGController {
	
	@Autowired
	IMusicManageService musicManageService;
	
	@Autowired
	TCGService tcgs;

    @Autowired
	ICountDao countDao;

	@RequestMapping("chartDelete")
	public String chartDelete(Model model, HttpServletRequest request,
			@RequestParam("cseq") String cseq){
		
		// ex : "3"
		List<MusicVO> musicList = tcgs.listMusic(cseq); // "1|2|3"
		
		for(MusicVO music : musicList){
			String chartByTable = music.getChart(); // "1|2|3";
			String [] charts = chartByTable.split("\\|");
			ArrayList<String> chartList = new ArrayList<>(Arrays.asList(charts)); // ["1", "2", "3"] 
			
			if(chartList.contains(cseq)) {
				chartList.remove(cseq); // ["1", "2", "3"] -> ["1", "2"]
				String chart = String.join("|", chartList); // "1|2"
				music.setChart(chart);
				tcgs.musicUpdateChart(music);
			}
		}
		
		tcgs.chartDelete(cseq);	
		
		return "redirect:/ChartManage";
	}
	
	
	
	@RequestMapping(value="genreDelete", method = RequestMethod.POST)
	public String genreDelete(Model model, HttpServletRequest request,
			@RequestParam("gseq") String gseq) {
		HttpSession session = request.getSession();
		String adminId = (String) session.getAttribute("adminId");
		if (adminId == null) {
			return "redirect:/admin";
		}
		try {
			tcgs.genreDelete(gseq);
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "해당 장르와 관련하여 다른 데이터가 존재하므로 삭제가 불가합니다.");
			return this.adminGenreDetail(request, model, gseq);
		}
		return "redirect:/GenreManage";
	}
	
	
	
	@RequestMapping("themeDelete")
	public String themeDelete(Model model, HttpServletRequest request,
			@RequestParam("tseq") String tseq) {
		
		List<MusicVO> musicList = tcgs.listMusic1(tseq);
		
		for(MusicVO music : musicList){
			String themeByTable = music.getTheme();
			String [] themes = themeByTable.split("\\|");
			ArrayList<String> themeList = new ArrayList<>(Arrays.asList(themes));
			
			if(themeList.contains(tseq)) {
				themeList.remove(tseq);
				String theme = String.join("|", themeList);
				music.setTheme(theme);
				tcgs.musicUpdateTheme(music);
			}
		}
		tcgs.themeDelete(tseq);
		
		return "redirect:/ThemeManage";
	}
	
	
	
	@RequestMapping("chartUpdate")
	public String chartUpdate(@ModelAttribute("dto") @Valid ChartVO chartvo,
			BindingResult result, Model model , HttpServletRequest request) {
		try {
			String path = ResourceUtils.getFile("classpath:static/upload/").toPath().toString();
			MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*10,
					"UTF-8", new DefaultFileRenamePolicy());
			chartvo.setCseq(Integer.parseInt(multi.getParameter("cseq")));
			chartvo.setTitle(multi.getParameter("title"));
			String file = multi.getFilesystemName("filename");
			String oldimage = multi.getParameter("oldimage");
			if(file!=null) chartvo.setImg(file);
			else if(oldimage!=null)chartvo.setImg(oldimage);
			else chartvo.setImg(null);
		} catch (IOException e) {e.printStackTrace();}
		tcgs.chartUpdate(chartvo);
		return "redirect:/ChartManage";
	}
	
	
	
	@RequestMapping("/chartUpdateForm")
	public String chartUpdateForm(Model model, HttpServletRequest request,
			@RequestParam("cseq") String cseq) {
		String url = "admin/chartUpdateForm";
		model.addAttribute("chart", tcgs.getChart(cseq));
		return url;
	}
	
	
	
	@RequestMapping("adminChartDetail")
	public ModelAndView adminChartDetail(HttpServletRequest request, 
			@RequestParam("cseq") String cseq) {
		
		ModelAndView mav = new ModelAndView();
		ChartVO cvo = tcgs.getChart(cseq);
		mav.addObject("ChartVO", cvo);
		mav.setViewName("admin/adminChartDetail");
		return mav;
	}
	
	
	
	@RequestMapping("genreUpdate")
	public String genreUpdate(@ModelAttribute("dto") @Valid GenreVO genrevo,
			BindingResult result, Model model , HttpServletRequest request) {
		try {
			String path = ResourceUtils.getFile("classpath:static/upload/").toPath().toString();
			MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*10,
					"UTF-8", new DefaultFileRenamePolicy());
			genrevo.setGseq(Integer.parseInt(multi.getParameter("gseq")));
			genrevo.setTitle(multi.getParameter("title"));
			String file = multi.getFilesystemName("filename");
			String oldimage = multi.getParameter("oldimage");
			if(file!=null) genrevo.setImg(file);
			else if(oldimage!=null)genrevo.setImg(oldimage);
			else genrevo.setImg(null);
		} catch (IOException e) {e.printStackTrace();}
		tcgs.genreUpdate(genrevo);
		return "redirect:/GenreManage";
	}
	
	
	@RequestMapping("/genreUpdateForm")
	public String genreUpdateForm(Model model, HttpServletRequest request,
			@RequestParam("gseq") String gseq) {
		String url = "admin/genreUpdateForm";
		model.addAttribute("genre", tcgs.getGenre(gseq));
		return url;
	}
	


	@RequestMapping("adminGenreDetail")
	public String adminGenreDetail(HttpServletRequest request, 
			Model model, @RequestParam("gseq") String gseq) {
		GenreVO gvo = tcgs.getGenre(gseq);
		model.addAttribute("GenreVO", gvo);
		return "admin/adminGenreDetail";
	}
	
	
	@RequestMapping("themeUpdate")
	public String themeUpdate(@ModelAttribute("dto") @Valid ThemeVO themevo,
			BindingResult result, Model model , HttpServletRequest request) {
		try {
			String path = ResourceUtils.getFile("classpath:static/upload/").toPath().toString();
			MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*10,
					"UTF-8", new DefaultFileRenamePolicy());
			themevo.setTseq(Integer.parseInt(multi.getParameter("tseq")));
			themevo.setTitle(multi.getParameter("title"));
			String file = multi.getFilesystemName("filename");
			themevo.setImg(file);
			String oldimage = multi.getParameter("oldimage");
			if(file!=null) themevo.setImg(file);
			else if(oldimage!=null)themevo.setImg(oldimage);
			else themevo.setImg(null);
		} catch (IOException e) {e.printStackTrace();}
		tcgs.themeUpdate(themevo);
		return "redirect:/ThemeManage";
	}
	
	
	
	@RequestMapping("/themeUpdateForm")
	public String themeUpdateForm(Model model, HttpServletRequest request,
			@RequestParam("tseq") String tseq) {
		String url = "admin/themeUpdateForm";
		model.addAttribute("theme", tcgs.getTheme(tseq));
		return url;
	}
	
	
	
	@RequestMapping("adminThemeDetail")
	public ModelAndView adminThemeDetail(HttpServletRequest request, 
			@RequestParam("tseq") String tseq) {
		
		ModelAndView mav = new ModelAndView();
		ThemeVO tvo = tcgs.getTheme(tseq);
		mav.addObject("ThemeVO", tvo);
		mav.setViewName("admin/adminThemeDetail");
		return mav;
	}
	
	
	
	@RequestMapping("genreInsert")
	public String genreInsert(@ModelAttribute("dto") @Valid GenreVO genrevo,
			BindingResult result, Model model , HttpServletRequest request) {
		try {
			String path = ResourceUtils.getFile("classpath:static/upload/").toPath().toString();
			MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*10,
					"UTF-8", new DefaultFileRenamePolicy());
			genrevo.setTitle(multi.getParameter("title"));
			String file = multi.getFilesystemName("filename");
			
			if (file != null) {
				genrevo.setImg(file);
			}
			
			GenreValidator validator = new GenreValidator();
			validator.validate(genrevo, result);
			if(result.hasErrors()) {
				if(result.getFieldError("title")!=null) 
					model.addAttribute("message", "제목을 입력하세요");
				return "admin/genreInsertForm";
			}
		} catch (IOException e) {e.printStackTrace();}
		tcgs.genreInsert(genrevo);
		return "redirect:/GenreManage";
	}
	
	
	@RequestMapping("/genreInsertForm")
	public String genreInsertForm(Model model, HttpServletRequest request) {
		String url = "admin/genreInsertForm";
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("adminId");
		if(session.getAttribute("adminId") == null) url="adminLogin";
		return url;
	}
	
	
	@RequestMapping("GenreManage")
	public ModelAndView GenreManage(HttpServletRequest request) {
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
			} else if( session.getAttribute("page")!= null  ) {
				page = (int) session.getAttribute("page");
			} else {
				page = 1;
				session.removeAttribute("page");
			}
			Paging paging = new Paging();
			paging.setPage(page);
			int count = countDao.getAllCount("genre", "title", key);
			paging.setTotalCount(count);
			paging.paging();
			List<GenreVO> genreList = tcgs.listGenre(paging, key);
			mav.addObject("paging", paging);
			mav.addObject("key", key);
			mav.addObject("genreList", genreList);
			mav.setViewName("admin/GenreManage");
		}
		return mav;
	}
	
	
	
	@RequestMapping("chartInsert")
	public String chartInsert(@ModelAttribute("dto") @Valid ChartVO chartvo,
			BindingResult result, Model model , HttpServletRequest request) {
		try {
			String path = ResourceUtils.getFile("classpath:static/upload/").toPath().toString();
			MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*10,
					"UTF-8", new DefaultFileRenamePolicy());
			chartvo.setTitle(multi.getParameter("title"));
			String file = multi.getFilesystemName("filename");
			
			if (file != null) {
				chartvo.setImg(file);
			}
			
			ChartValidator validator = new ChartValidator();
			validator.validate(chartvo, result);
			if(result.hasErrors()) {
				if(result.getFieldError("title")!=null) 
					model.addAttribute("message", "제목을 입력하세요");
				return "admin/chartInsertForm";
			}
		} catch (IOException e) {e.printStackTrace();}
		tcgs.chartInsert(chartvo);
		return "redirect:/ChartManage";
	}
	
	
	@RequestMapping("/chartInsertForm")
	public String chartInsertForm(Model model, HttpServletRequest request) {
		String url = "admin/chartInsertForm";
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("adminId");
		if(session.getAttribute("adminId") == null) url="adminLogin";
		return url;
	}
	
	
	@RequestMapping("ChartManage")
	public ModelAndView ChartManage(HttpServletRequest request) {
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
			} else if( session.getAttribute("page")!= null  ) {
				page = (int) session.getAttribute("page");
			} else {
				page = 1;
				session.removeAttribute("page");
			}
			Paging paging = new Paging();
			paging.setPage(page);
			int count = countDao.getAllCount("chart", "title", key);
			paging.setTotalCount(count);
			paging.paging();
			List<ChartVO> chartList = tcgs.listChart(paging, key);
			mav.addObject("paging", paging);
			mav.addObject("key", key);
			mav.addObject("chartList", chartList);
			mav.setViewName("admin/ChartManage");
		}
		return mav;
	}
	
	

	@RequestMapping("themeInsert")
	public String themeInsert(@ModelAttribute("dto") @Valid ThemeVO themevo,
			BindingResult result, Model model , HttpServletRequest request) {
		try {
			String path = ResourceUtils.getFile("classpath:static/upload/").toPath().toString();
			MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*10,
					"UTF-8", new DefaultFileRenamePolicy());
			themevo.setTitle(multi.getParameter("title"));
			String file = multi.getFilesystemName("filename");
			
			if (file != null) {
				themevo.setImg(file);
			}
			
			ThemeValidator validator = new ThemeValidator();
			validator.validate(themevo, result);
			if(result.hasErrors()) {
				if(result.getFieldError("title")!=null) 
					model.addAttribute("message", "제목을 입력하세요");
				return "admin/themeInsertForm";
			}
		} catch (IOException e) {e.printStackTrace();}
		tcgs.themeInsert(themevo);
		return "redirect:/ThemeManage";
	}
	
	
	@RequestMapping("/themeInsertForm")
	public String themeInsertForm(Model model, HttpServletRequest request) {
		String url = "admin/themeInsertForm";
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("adminId");
		if(session.getAttribute("adminId") == null) url="adminLogin";
		return url;
	}
	
	
	@RequestMapping("ThemeManage")
	public ModelAndView ThemeManage(HttpServletRequest request) {
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
			} else if( session.getAttribute("page")!= null  ) {
				page = (int) session.getAttribute("page");
			} else {
				page = 1;
				session.removeAttribute("page");
			}
			Paging paging = new Paging();
			paging.setPage(page);
			int count = countDao.getAllCount("theme", "title", key);
			paging.setTotalCount(count);
			paging.paging();
			List<ThemeVO> themeList = tcgs.listTheme(paging, key);
			mav.addObject("paging", paging);
			mav.addObject("key", key);
			mav.addObject("themeList", themeList);
			mav.setViewName("admin/ThemeManage");
		}
		return mav;
	}
}
