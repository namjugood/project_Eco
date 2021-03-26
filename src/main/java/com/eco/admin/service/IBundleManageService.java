package com.eco.admin.service;

import java.util.List;

import com.eco.dto.BundleVO;

public interface IBundleManageService {

	List<BundleVO> list(BundleVO search);

	int insert(BundleVO bundle);

	int delete(int mseq);

	int update(BundleVO bundle);

	int detailSave(int bmseq, String[] parameterValues);

}