package com.eco.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.eco.dto.AlbumVO;
import com.eco.dto.ArtistVO;
import com.eco.dto.BundleVO;
import com.eco.dto.MemberVO;
import com.eco.dto.MusicVO;
import com.eco.service.BundleService;
import com.eco.service.MusicService;
import com.eco.service.MypageService;

@Controller
public class MypageController {
	
	@Autowired
	MypageService mps;
	@Autowired
	BundleService bundleService;
	@Autowired
	MusicService musicService;
	
	@RequestMapping(value = "bundleDetailView", method = RequestMethod.GET)
	public String bundleDetailView(Model model, HttpServletRequest request,
			@RequestParam("bmseq") int bmseq) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if( mvo==null )return "mypage/loginplz";
		else{
			
			List<BundleVO> bundleList = mps.listBundle(mvo.getUseq(), bmseq);
			for (BundleVO b : bundleList) {
				List<MusicVO> musicList = musicService.musicListByBundle(bmseq);
				b.setMusicList(musicList);
			}
			System.out.println(bundleList);
			
			model.addAttribute("bundleList", bundleList);
			
					
			// 좋아요한 곡의 시퀀스 목록
			model.addAttribute("likeMusicList", musicService.likeMusicListByUseq(mvo.getUseq()));
			
			return "mypage/bundleDetailView";
		}
	}
	
	@RequestMapping(value = "storage", method = RequestMethod.GET)
	public String mybundle(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if( mvo==null )return "mypage/loginplz";
		else{
			List<BundleVO> bundleList = bundleService.listBundle(mvo.getUseq());
			for (BundleVO b : bundleList) {
				List<MusicVO> musicList = musicService.musicListByBundle(b.getBmseq());
				b.setMusicList(musicList);
			}
			System.out.println(bundleList);
			model.addAttribute("bundleList", bundleList);
			return "mypage/mybundle";
		}
	}
	
	@RequestMapping(value = "likealbum", method = RequestMethod.GET)
	public String likealbum(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if( mvo==null )return "mypage/loginplz";
		else{
			List<AlbumVO> getAlbum = mps.getAlbum(mvo.getUseq());
			System.out.println(getAlbum);
			model.addAttribute("albumList", getAlbum);
			
			List<BundleVO> bundleList = bundleService.listBundle(mvo.getUseq());
			for (BundleVO b : bundleList) {
				List<MusicVO> musicListByBundle = musicService.musicListByBundle(b.getBmseq());
				b.setMusicList(musicListByBundle);
			}
			model.addAttribute("bundleList", bundleList);
			
			return "mypage/likealbum";
		}
	}
	
	@RequestMapping(value = "likeartist", method = RequestMethod.GET)
	public String likeartist(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if( mvo==null )return "mypage/loginplz";
		else{
			List<ArtistVO> getArtist = mps.getArtist(mvo.getUseq());
			System.out.println(getArtist);
			model.addAttribute("artistList", getArtist);
			
			List<BundleVO> bundleList = bundleService.listBundle(mvo.getUseq());
			for (BundleVO b : bundleList) {
				List<MusicVO> musicListByBundle = musicService.musicListByBundle(b.getBmseq());
				b.setMusicList(musicListByBundle);
			}
			model.addAttribute("bundleList", bundleList);
			
			return "mypage/likeartist";
		}
	}
	
	@RequestMapping(value = "likemusic", method = RequestMethod.GET)
	public String likemusic(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if( mvo==null )return "mypage/loginplz";
		else{
			List<MusicVO> musicList = mps.getMusic(mvo.getUseq());
			System.out.println(musicList);
			model.addAttribute("musicList", musicList);
			
			List<BundleVO> bundleList = bundleService.listBundle(mvo.getUseq());
			for (BundleVO b : bundleList) {
				List<MusicVO> musicListByBundle = musicService.musicListByBundle(b.getBmseq());
				b.setMusicList(musicListByBundle);
			}
			model.addAttribute("bundleList", bundleList);
			
			// 로그인유저의 무시목록건 뺀 뮤직목록으로 
			musicList = musicService.ignoreBanList(musicList, mvo.getUseq());
			
			// 좋아요한 곡의 시퀀스 목록
			model.addAttribute("likeMusicList", musicService.likeMusicListByUseq(mvo.getUseq()));
			
			return "mypage/likemusic";
		}
	}

	@RequestMapping("BDMDelete")
	public String BDMDelete(Model model, @RequestParam("bdseq") String[] bdseqArr) {
		for( String bdseq : bdseqArr ) {
			mps.BDMDelete(bdseq);
		}
		return "redirect:/bundleDetailView";
	}
}
