package com.eco.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eco.dto.BundleVO;

@Mapper
public interface IBundleManageDao {

	List<BundleVO> list(BundleVO search);

	int insert(BundleVO bundle);

	int update(BundleVO bundle);

	void delete(int bmseq);

	BundleVO getBundle(int bmseq);

	int detailClear(int bmseq);

	int detailAdd(int bmseq, int mseq);
	
}
