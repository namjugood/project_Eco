package com.eco.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eco.dto.AlbumVO;
import com.eco.dto.ArtistVO;
import com.eco.dto.ChartVO;
import com.eco.dto.GenreVO;
import com.eco.dto.MusicVO;
import com.eco.dto.ThemeVO;
import com.eco.dto.search.SearchDTO;

@Mapper
public interface IMusicDao {

	List<MusicVO> getNewList();
	
	List<MusicVO> getRecommendMusic();

	List<String> abtypeListByAlbum();

	List<String> groupynListByArtist();

	List<String> genderListByArtist();

	List<GenreVO> genreListByAlbum();
	
	List<ThemeVO> themeList();
	
	List<ChartVO> chartList();

	List<GenreVO> genreList();

	List<ThemeVO> themeListIncludedMusic();

	List<ChartVO> chartListIncludedMusic();

	List<GenreVO> genreListIncludedMusic();
	
	List<MusicVO> musicListByAlbum(int abseq);

	List<MusicVO> musicListByChart(int cseq);

	List<MusicVO> musicListByGenre(int gseq);

	List<MusicVO> musicListByTheme(int tseq);

	List<MusicVO> musicListByBundle(int bmseq);
	
	List<MusicVO> musicListByArtist(int atseq);
	
	List<AlbumVO> albumListByArtist(int atseq);

	MusicVO getMusic(int mseq);

	AlbumVO getAlbum(int abseq);
	
	ArtistVO getArtist(int atseq);

	void likeMusic(int useq, int mseq);

	void likeAlbum(int useq, int mseq);

	void likeArtist(int useq, int mseq);

	void unlikeArtist(int useq, int mseq);

	void unlikeAlbum(int useq, int mseq);

	void unlikeMusic(int useq, int mseq);

	void banMusic(int useq, int mseq);
	
	void unbanMusic(int useq, int mseq);
	
	List<Integer> banListByUseq(int useq);

	List<Integer> likeMusicListByUseq(int useq);
	
	List<Integer> likeAlbumListByUseq(int useq);
	
	List<Integer> likeArtistListByUseq(int useq);

	List<AlbumVO> albumListByArtistUseSearchDTO(SearchDTO searchDTO);

	List<MusicVO> musicListByArtistUseSearchDTO(SearchDTO searchDTO);

	List<MusicVO> musicListAtBrowse(SearchDTO search);

	List<GenreVO> genreListIncludedArtist();

}
