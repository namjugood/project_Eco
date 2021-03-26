package com.eco.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eco.dto.AlbumVO;
import com.eco.dto.ArtistVO;
import com.eco.dto.BundleDetailVO;
import com.eco.dto.BundleVO;
import com.eco.dto.MusicVO;

@Mapper
public interface IMypageDao {
	public List<MusicVO> getMusic(int useq);
	public List<ArtistVO> getArtist(int useq);
	public List<AlbumVO> getAlbum(int useq);
	public List<MusicVO> listBundleDetail(int useq);
	public List<BundleVO> listBundle(int useq, int bmseq);
	public void BDMDelete(String bdseq);
}
