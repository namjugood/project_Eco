package com.eco.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eco.dao.IMypageDao;
import com.eco.dto.AlbumVO;
import com.eco.dto.ArtistVO;
import com.eco.dto.BundleVO;
import com.eco.dto.MusicVO;

@Service
public class MypageService {
	@Autowired
	IMypageDao mpdao;

	public List<BundleVO> listBundle(int useq, int bmseq) {
		return mpdao.listBundle(useq, bmseq);
	}
	
	public List<MusicVO> listBundleDetail(int useq){
		return mpdao.listBundleDetail(useq);
	}
	
	public List<AlbumVO> getAlbum(int useq){
		return mpdao.getAlbum(useq);
	}
	
	public List<ArtistVO> getArtist(int useq){
		return mpdao.getArtist(useq);
	}
	
	
	public List<MusicVO> getMusic(int useq){
		return mpdao.getMusic(useq);
	}
	
	public void BDMDelete(String bdseq) {
		mpdao.BDMDelete(bdseq);
	}
}
