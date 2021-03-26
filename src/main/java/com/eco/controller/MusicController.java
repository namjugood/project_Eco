package com.eco.controller;

import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eco.dao.ICountDao;
import com.eco.dto.AlbumVO;
import com.eco.dto.ArtistVO;
import com.eco.dto.BundleVO;
import com.eco.dto.MemberVO;
import com.eco.dto.MusicVO;
import com.eco.dto.Paging;
import com.eco.dto.search.SearchDTO;
import com.eco.service.BundleService;
import com.eco.service.MusicService;

@Controller
public class MusicController {
	
	
	@Autowired
	MusicService ms;
	
	@Autowired
	BundleService bundleService;
	
	@Autowired
	ICountDao c;

	@RequestMapping(value = "/browse", method = RequestMethod.GET)
	public String browse(Model model, HttpServletRequest request
			, @RequestParam(name = "selectedType", required = false, defaultValue = "chart") String selectedType
			, @RequestParam(name = "selectedSeq", required = false, defaultValue = "1") int selectedSeq
			, @ModelAttribute("search") SearchDTO search
			, Paging searchPaging
			) {
		// search에 기본값이 없으면 RequestParam으로 search에 defaultValue값 적용
		if (search.getSelectedType().equals("")) {
			search.setSelectedType(selectedType);
			search.setSelectedSeq(selectedSeq);
		}
		
		// 검색조건에 의한 갯수조회
		search.setSearchTable("music_view"); // 검색조건 테이블 저장
		int count = c.count(search);
		
		// 페이징
		Paging paging = new Paging();
		paging.setPage(1); // 항상 1페이지부
		paging.setTotalCount(count);
		paging.paging();
		paging.setDisplayRow(search.getPage() * 100); // 행의 갯수 : 페이지 * 100개
		search.setPaging(paging);

		// 선택한 타입과 선택한 시퀀스값으로 music_view 조회
		List<MusicVO> musicList = null;
		musicList = ms.musicListAtBrowse(search);

		MemberVO loginUser = (MemberVO) request.getSession().getAttribute("loginUser");
		
		if (loginUser != null) {
			List<BundleVO> bundleList = bundleService.listBundle(loginUser.getUseq());
			for (BundleVO b : bundleList) {
				List<MusicVO> musicListByBundle = ms.musicListByBundle(b.getBmseq());
				b.setMusicList(musicListByBundle);
			}
			model.addAttribute("bundleList", bundleList);

			// 로그인유저의 무시목록건 뺀 뮤직목록으로 
			musicList = ms.ignoreBanList(musicList, loginUser.getUseq());

			// 좋아요한 곡의 시퀀스 목록
			model.addAttribute("likeMusicList", ms.likeMusicListByUseq(loginUser.getUseq()));
		}
		
		model.addAttribute("chartList", ms.chartList());
		
		model.addAttribute("genreList", ms.genreList());
		
		model.addAttribute("musicList", musicList);

		return "music/browse";
	}
	
	@RequestMapping(value = "/albumView", method = RequestMethod.GET)
	public String albumView(Model model, HttpServletRequest request
			, @RequestParam("abseq") int abseq) {
		AlbumVO album = ms.getAlbum(abseq);
		List<MusicVO> musicListByAlbum = ms.musicListByAlbum(abseq);
		
		MemberVO loginUser = (MemberVO) request.getSession().getAttribute("loginUser");
		
		if (loginUser != null) {
			List<BundleVO> bundleList = bundleService.listBundle(loginUser.getUseq());
			for (BundleVO b : bundleList) {
				List<MusicVO> musicListByBundle = ms.musicListByBundle(b.getBmseq());
				b.setMusicList(musicListByBundle);
			}
			model.addAttribute("bundleList", bundleList);

			// 로그인유저의 무시목록건 뺀 뮤직목록으로 
			musicListByAlbum = ms.ignoreBanList(musicListByAlbum, loginUser.getUseq());

			// 좋아요한 곡의 시퀀스 목록
			model.addAttribute("likeMusicList", ms.likeMusicListByUseq(loginUser.getUseq()));
			
			// 좋아요한 앨범의 시퀀스 목록
			model.addAttribute("likeAlbumList", ms.likeAlbumListByUseq(loginUser.getUseq()));
		}
		
		
		model.addAttribute("album", album);
		
		
		model.addAttribute("musicList", musicListByAlbum);
		
		return "music/albumView";
	}

	@RequestMapping(value = "/artistView", method = RequestMethod.GET)
	public String artistView(Model model, HttpServletRequest request
			, @RequestParam(name = "selectedTab", required = false, defaultValue = "track") String selectedTab
			, @RequestParam(name = "selectedSeq", required = false, defaultValue = "1") int selectedSeq
			, @ModelAttribute("search") ArtistVO search) {
		// search에 기본값이 없으면 RequestParam으로 search에 defaultValue값 적용
		if (search.getSelectedTab().equals("")) {
			search.setSelectedTab(selectedTab);
			search.setSelectedSeq(selectedSeq);
		}
		
		ArtistVO artist = ms.getArtist(search.getAtseq());
		
		if (search.getSelectedTab().equals("track")) {
			List<MusicVO> musicListByArtist = ms.musicListByArtist(search);
			model.addAttribute("musicList", musicListByArtist);
		} else {
			List<AlbumVO> albumListByArtist = ms.albumListByArtist(search);
			for (AlbumVO album : albumListByArtist) {
				album.setMusicList(ms.musicListByAlbum(album.getAbseq()));
			}
			model.addAttribute("albumList", albumListByArtist);		
		}
		
		MemberVO loginUser = (MemberVO) request.getSession().getAttribute("loginUser");
		
		if (loginUser != null) {
			List<BundleVO> bundleList = bundleService.listBundle(loginUser.getUseq());
			for (BundleVO b : bundleList) {
				List<MusicVO> musicListByBundle = ms.musicListByBundle(b.getBmseq());
				b.setMusicList(musicListByBundle);
			}
			
			// 로그인한 유저의 내 리스트
			model.addAttribute("bundleList", bundleList);

			// 좋아요한 곡의 시퀀스 목록
			model.addAttribute("likeMusicList", ms.likeMusicListByUseq(loginUser.getUseq()));
			
			// 좋아요한 앨범의 시퀀스 목록
			model.addAttribute("likeAlbumList", ms.likeAlbumListByUseq(loginUser.getUseq()));

			// 좋아요한 아티스트의 시퀀스 목록
			model.addAttribute("likeArtistList", ms.likeArtistListByUseq(loginUser.getUseq()));
		}
		
		model.addAttribute("artist", artist);
		
		return "music/artistView";
	}
	


	@RequestMapping(value = "/musicView", method = RequestMethod.GET)
	public String musicView(Model model, HttpServletRequest request
			, @RequestParam("mseq") int mseq) {

		MusicVO music = ms.getMusic(mseq);

		// 유사곡 = 장르가 같은 곡(대신 상세로 들어온 곡과 다른 곡만 취급 -> 자바단에서 해보자...)
		List<MusicVO> musicListByGenre = ms.musicListByGenre(music.getGseq());
		musicListByGenre = musicListByGenre.stream().filter(m -> {
			return m.getMseq() != music.getMseq(); // 다른것만 추출
		}).collect(Collectors.toList());
		
		MemberVO loginUser = (MemberVO) request.getSession().getAttribute("loginUser");
		
		if (loginUser != null) {
			List<BundleVO> bundleList = bundleService.listBundle(loginUser.getUseq());
			for (BundleVO b : bundleList) {
				List<MusicVO> musicListByBundle = ms.musicListByBundle(b.getBmseq());
				b.setMusicList(musicListByBundle);
			}

			model.addAttribute("bundleList", bundleList);

			// 로그인유저의 무시목록건 뺀 뮤직목록으로 
			musicListByGenre = ms.ignoreBanList(musicListByGenre, loginUser.getUseq());

			// 좋아요한 곡의 시퀀스 목록
			model.addAttribute("likeMusicList", ms.likeMusicListByUseq(loginUser.getUseq()));

			// 무시한 곡의 시퀀스 목록
			model.addAttribute("banMusicList", ms.banMusicListByUseq(loginUser.getUseq()));
		}
		
		model.addAttribute("music", music);
		
		model.addAttribute("musicList", musicListByGenre);
		
		return "music/musicView";
	}
	
	@RequestMapping(value = "/like", method = RequestMethod.POST)
	public @ResponseBody boolean like(Model model, HttpServletRequest request
			, @RequestBody MusicVO music
		) {
		// 세션에서 유저값
		MemberVO loginUser = (MemberVO) request.getSession().getAttribute("loginUser");
		
		if (loginUser == null) {

			return false;
		} else {
			// 넘어온 값에 따라 like에 insert 다만, mseq일경우 ban에서 제거하고 insert
			if (music.getAtseq() != 0) {
				ms.likeArtist(loginUser.getUseq(), music.getAtseq());
			} else if (music.getAbseq() != 0) {
				ms.likeAlbum(loginUser.getUseq(), music.getAbseq());
			} else if (music.getMseq() != 0) {
				ms.likeMusic(loginUser.getUseq(), music.getMseq());
				loginUser.setLikeList(ms.likeMusicListByUseq(loginUser.getUseq()));
				request.getSession().setAttribute("loginUser", loginUser);
			}

			return true;
		}
	}
	
	@RequestMapping(value = "/unlike", method = RequestMethod.POST)
	public @ResponseBody boolean unlike(Model model, HttpServletRequest request
			, @RequestBody MusicVO music
		) {
		// 세션에서 유저값
		MemberVO loginUser = (MemberVO) request.getSession().getAttribute("loginUser");
		
		if (loginUser == null) {

			return false;
		} else {
			// 넘어온 값에 따라 like에 insert 다만, mseq일경우 ban에서 제거하고 insert
			if (music.getAtseq() != 0) {
				ms.unlikeArtist(loginUser.getUseq(), music.getAtseq());
			} else if (music.getAbseq() != 0) {
				ms.unlikeAlbum(loginUser.getUseq(), music.getAbseq());
			} else if (music.getMseq() != 0) {
				ms.unlikeMusic(loginUser.getUseq(), music.getMseq());
				loginUser.setLikeList(ms.likeMusicListByUseq(loginUser.getUseq()));
				request.getSession().setAttribute("loginUser", loginUser);
			}

			return true;
		}
	}
	
	@RequestMapping(value = "/ban", method = RequestMethod.POST)
	public @ResponseBody boolean ban(Model model, HttpServletRequest request
			, @RequestBody int mseq
			) {
		// 세션에서 유저값
		MemberVO loginUser = (MemberVO) request.getSession().getAttribute("loginUser");
		if (loginUser == null) {
			return false;
		} else {
			ms.banMusic(loginUser.getUseq(), mseq);
			return true;
		}		
	}

	@RequestMapping(value = "/unban", method = RequestMethod.POST)
	public @ResponseBody boolean unban(Model model, HttpServletRequest request
			, @RequestBody int mseq
			) {
		// 세션에서 유저값
		MemberVO loginUser = (MemberVO) request.getSession().getAttribute("loginUser");
		if (loginUser == null) {
			return false;
		} else {
			ms.unbanMusic(loginUser.getUseq(), mseq);
			return true;
		}		
	}
}
