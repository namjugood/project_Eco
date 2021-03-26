package com.eco.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eco.dto.AlbumVO;
import com.eco.dto.ArtistVO;
import com.eco.dto.BoardVO;
import com.eco.dto.MemberVO;
import com.eco.dto.MusicVO;
import com.eco.dto.Paging;

@Mapper
public interface IBoardDao {

	public List<BoardVO> boardList(String table,String orderName,int startNum, int endNum);
	public List<BoardVO> boardListSearch(String table,String orderName, String keyward, int startNum, int endNum );
	public void qnaInsert(BoardVO boardVo);
	public List<BoardVO> myboardList(String table,String orderName,int startNum, int endNum, int useq);
	public void myQnaUpdate(BoardVO bvoList);
	public void myQnaDelete(String useq);
	public BoardVO myQnaUpdateForm (String qseq);
	public BoardVO updateForm(String table, String field, String key);
	public void boardDelete(String table, String field, String key);
	public List<ArtistVO> getRecommendArtistList();
	
	public List<MusicVO> msearchSite(String table, String selected, String keyward);
	public List<ArtistVO> atsearchSite(String table, String selected, String keyward);
	public List<AlbumVO> alsearchSite(String table, String selected, String keyward);
	public List<MusicVO> lysearchSite(String table, String selected, String keyward);
	public List<BoardVO> adsearchSite(String table,String orderName, String keyward);
	public List<BoardVO> nosearchSite(String table, String selected, String keyward);
}
