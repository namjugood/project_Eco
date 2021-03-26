package com.eco.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eco.dto.BundleVO;
import com.eco.dto.BundleDetailVO;

@Mapper
public interface IBundleDao {
	
	List<BundleVO> listBundleForMain();

	List<BundleVO> listBundleByUser(int useq);

	int addBundleMaster(BundleVO bundle);

	int addBundleDetail(BundleDetailVO bundleDetail);
}
