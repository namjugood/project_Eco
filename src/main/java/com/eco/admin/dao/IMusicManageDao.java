package com.eco.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eco.dto.MusicVO;
import com.eco.dto.search.SearchDTO;

@Mapper
public interface IMusicManageDao {

	List<MusicVO> list(SearchDTO search);

	int insert(MusicVO music);

	int update(MusicVO music);

	void delete(int mseq);
	
}
