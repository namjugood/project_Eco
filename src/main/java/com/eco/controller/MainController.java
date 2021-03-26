package com.eco.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.eco.dto.ArtistVO;
import com.eco.dto.BundleVO;
import com.eco.dto.MusicVO;
import com.eco.service.BoardService;
import com.eco.service.BundleService;
import com.eco.service.MusicService;

@Controller
public class MainController {
	
	@Autowired
	BundleService bundleService;
	
	@Autowired
	MusicService musicService;
	
	@Autowired
	BoardService boardService;
	
	
	/*
	 * @Autowired MainService mainService;
	 */
	// 추가된 부분 끝
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main(Model model, HttpServletRequest request) {
		
		List<BundleVO> bundleList = bundleService.listBundle(0); // 메인에서 부를 번들은 유저없이 가므로 0을 보냄(참고로 시퀀스는 1부터)
		for (BundleVO b : bundleList) {
			List<MusicVO> musicList = musicService.musicListByBundle(b.getBmseq());
			b.setMusicList(musicList);
		}

		// List<ThemeVO> themeList = mu.themeList();
		// List<Chart> chartList = mu.chartList();

		// for (Music music : musicList) {
		// 	String theme = music.getTheme(); // "1 | 2"
		// 	String chart = music.get
		// 	[]String themeList = theme.split("|"); // ["1", "2"]

		// 	themeList.contains("");

		// 	music.setThemeLabel(/*순회하면서 매치된 테마 명*/);
		// }
		
		List<MusicVO> nmlist = musicService.getNewList();
		List<ArtistVO> rmatlist = boardService.getRecommendArtistList();

	
		model.addAttribute("newMusicList", nmlist);
		model.addAttribute("recommendArtistList", rmatlist);
		/* model.addAttribute("recommendMusicArtist", alist); */
		
		// 추가된 부분 끝
		
		model.addAttribute("bundleList", bundleList);
		return "index";
	}
	


}
