package com.eco.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eco.dao.IMusicDao;
import com.eco.dto.AlbumVO;
import com.eco.dto.ArtistVO;
import com.eco.dto.ChartVO;
import com.eco.dto.GenreVO;
import com.eco.dto.MusicVO;
import com.eco.dto.search.SearchDTO;

@Service
public class MusicService {
	
	@Autowired
	IMusicDao md;
	
	public List<ChartVO> chartList() {
		return md.chartList();
	}
	
	public List<GenreVO> genreList() {
		return md.genreList();
	}

	public List<MusicVO> musicListByAlbum(int abseq) {
		return md.musicListByAlbum(abseq);
	}

	public List<MusicVO> musicListByChart(int cseq) {
		return md.musicListByChart(cseq);
	}

	public List<MusicVO> musicListByGenre(int gseq) {
		return md.musicListByGenre(gseq);
	}
	
	public List<MusicVO> musicListByTheme(int tseq) {
		return md.musicListByTheme(tseq);
	}

	public List<MusicVO> musicListByBundle(int bmseq) {
		return md.musicListByBundle(bmseq);
	}
	
	public List<MusicVO> musicListByArtist(int atseq) {
		return md.musicListByArtist(atseq);
	}
	
	public List<AlbumVO> albumListByArtist(int atseq) {
		return md.albumListByArtist(atseq);
	}

	public List<MusicVO> getNewList() {
		return md.getNewList();
	}
	public List<MusicVO> getRecommendMusic() {
		return md.getRecommendMusic();
	}

	public MusicVO getMusic(int mseq) {
		return md.getMusic(mseq);
	}

	public AlbumVO getAlbum(int abseq) {
		return md.getAlbum(abseq);
	}
	
	public ArtistVO getArtist(int atseq) {
		return md.getArtist(atseq);
	}

	public void likeArtist(int useq, int mseq) {
		md.likeArtist(useq, mseq);
	}

	public void likeAlbum(int useq, int mseq) {
		md.likeAlbum(useq, mseq);
	}

	public void likeMusic(int useq, int mseq) {
		this.unbanMusic(useq, mseq); // music은 곡 무시하기가 있으므로 제거 후 좋아요등록
		md.likeMusic(useq, mseq);
	}
	
	public void unlikeArtist(int useq, int mseq) {
		md.unlikeArtist(useq, mseq);
	}

	public void unlikeAlbum(int useq, int mseq) {
		md.unlikeAlbum(useq, mseq);
	}

	public void unlikeMusic(int useq, int mseq) {
		md.unlikeMusic(useq, mseq);
	}
	
	public void banMusic(int useq, int mseq) {
		this.unlikeMusic(useq, mseq); // 곡을 무시할경우, 좋아요 취소
		md.banMusic(useq, mseq);
	}
	
	public void unbanMusic(int useq, int mseq) {
		md.unbanMusic(useq, mseq);
	}

	public List<Integer> banMusicListByUseq(int useq) {
		return md.banListByUseq(useq);
	}

	public List<MusicVO> ignoreBanList(List<MusicVO> musicList, int useq) {
		// 유저의 ban 목록
		List<Integer> banMseqList = md.banListByUseq(useq);
		
		// 원래목록에서 차단되지않은 목록만 저장하고 반환
		musicList = musicList.stream().filter(music -> {
			return !banMseqList.contains(music.getMseq());
		}).collect(Collectors.toList());

		return musicList;
	}

	public List<Integer> likeMusicListByUseq(int useq) {
		return md.likeMusicListByUseq(useq);
	}

	public List<Integer> likeAlbumListByUseq(int useq) {
		return md.likeAlbumListByUseq(useq);
	}

	public List<Integer> likeArtistListByUseq(int useq) {
		return md.likeArtistListByUseq(useq);
	}
	
	public List<AlbumVO> albumListByArtist(SearchDTO searchDTO) {
		return md.albumListByArtistUseSearchDTO(searchDTO);
	}

	public List<MusicVO> musicListByArtist(SearchDTO searchDTO) {
		return md.musicListByArtistUseSearchDTO(searchDTO);
	}

	public List<MusicVO> musicListAtBrowse(SearchDTO search) {
		return md.musicListAtBrowse(search);
	}

}
