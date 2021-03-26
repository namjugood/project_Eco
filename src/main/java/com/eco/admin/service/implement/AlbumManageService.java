package com.eco.admin.service.implement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eco.admin.dao.IAlbumManageDao;
import com.eco.admin.service.IAlbumManageService;
import com.eco.dto.AlbumVO;
import com.eco.dto.ArtistVO;
import com.eco.dto.Paging;
import com.eco.dto.search.SearchDTO;

@Service
public class AlbumManageService implements IAlbumManageService {

    @Autowired
	IAlbumManageDao albumManageDao;

    @Override
	//public List<AlbumVO> list(HashMap<String, Object> map) {return albumManageDao.list(map);}
    public List<AlbumVO> list(Paging paging, String key) {return albumManageDao.list(paging, key);}
    
    public List<ArtistVO> getArtist() {return albumManageDao.getArtist();}
    
    @Override
	public int insert(AlbumVO album) {
		return albumManageDao.insert(album);
	}

	@Override
	public List<AlbumVO> list4find(SearchDTO search) {
		return albumManageDao.list4find(search);
	}
	@Override
	public int update(AlbumVO album) {
		int res = albumManageDao.update(album);
		return res;
	}
	@Override
	public int delete(int abseq) {
		return albumManageDao.delete(abseq);		
	}
}