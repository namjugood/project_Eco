package com.eco.admin.service;

import java.util.List;

import javax.validation.Valid;

import com.eco.dto.MusicVO;
import com.eco.dto.search.SearchDTO;

public interface IMusicManageService {

	List<MusicVO> list(SearchDTO search);

	int insert(MusicVO music);

	int update(@Valid MusicVO music);

	void delete(int mseq);
	
}