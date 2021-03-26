package com.eco.admin.service.implement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eco.admin.dao.IBoardManageDao;
import com.eco.admin.service.IBoardManageService;
import com.eco.dto.BoardVO;

@Service
public class BoardManageService implements IBoardManageService{

	@Autowired
	IBoardManageDao bmdao;
	
	@Override
	public void noticeInsert(BoardVO boardVo) {
		bmdao.noticeInsert(boardVo);
	}
	@Override
	public void noticeUpdate(BoardVO boardVo) {
		bmdao.noticeUpdate(boardVo);
	}
	@Override
	public void myqnaA(BoardVO boardVo) {
		bmdao.myqnaA(boardVo);
	}
	@Override
	public void adqnaInsert(BoardVO boardVo) {
		bmdao.adqnaInsert(boardVo);
	}
	@Override
	public void adqnaUpdate(BoardVO boardVo) {
		bmdao.adqnaUpdate(boardVo);
	}
}
