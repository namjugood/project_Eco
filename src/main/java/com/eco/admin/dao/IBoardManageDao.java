package com.eco.admin.dao;

import org.apache.ibatis.annotations.Mapper;

import com.eco.dto.BoardVO;

@Mapper
public interface IBoardManageDao {

	void noticeInsert(BoardVO boardVo);
	public void noticeUpdate(BoardVO boardVo);
	public void myqnaA(BoardVO boardVo);
	public void adqnaInsert(BoardVO boardVo);
	public void adqnaUpdate(BoardVO boardVo);
}
