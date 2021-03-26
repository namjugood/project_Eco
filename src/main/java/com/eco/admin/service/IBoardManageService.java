package com.eco.admin.service;

import org.springframework.stereotype.Service;

import com.eco.dto.BoardVO;

@Service
public interface IBoardManageService {
	
	void noticeInsert(BoardVO boardVo);
	void noticeUpdate(BoardVO boardVo);
	void myqnaA(BoardVO boardVo);
	void adqnaInsert(BoardVO boardVo);
	void adqnaUpdate(BoardVO boardVo);
}
