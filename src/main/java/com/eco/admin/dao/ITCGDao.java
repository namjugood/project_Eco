package com.eco.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eco.dto.ChartVO;
import com.eco.dto.GenreVO;
import com.eco.dto.MusicVO;
import com.eco.dto.Paging;
import com.eco.dto.ThemeVO;

@Mapper
public interface ITCGDao {
	public List<ThemeVO> listTheme(Paging paging, String key);
	public void themeInsert(ThemeVO themevo);
	public void chartInsert(ChartVO chartvo);
	public List<ChartVO> listChart(Paging paging, String key);
	public void genreInsert(GenreVO genrevo);
	public List<GenreVO> listGenre(Paging paging, String key);
	public ThemeVO getTheme(String tseq);
	public void themeUpdate(ThemeVO themevo);
	public GenreVO getGenre(String gseq);
	public void genreUpdate(GenreVO genrevo);
	public void chartUpdate(ChartVO genrevo);
	public ChartVO getChart(String cseq);
	public void themeDelete(String tseq);
	public void genreDelete(String gseq);
	public void chartDelete(String cseq);
	public int musicUpdateTheme(MusicVO music);
	public int musicUpdateChart(MusicVO music);
	public List<MusicVO> listMusic(String cseq);
	public List<MusicVO> listMusic1(String tseq);
}
