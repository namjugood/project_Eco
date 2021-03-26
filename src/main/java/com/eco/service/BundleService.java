package com.eco.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eco.dao.IBundleDao;
import com.eco.dto.BundleVO;
import com.eco.dto.BundleDetailVO;

@Service
public class BundleService {
	
	@Autowired
	IBundleDao bd;

	
	public List<BundleVO> listBundle(int useq) {
		List<BundleVO> result = new ArrayList<BundleVO>();
		
		if (useq == 0) { // 시스템에서 생성한 리스트
			result = bd.listBundleForMain();
		} else { // 유저의 리스트
			result = bd.listBundleByUser(useq);
		}
		return result;
	}


	public int addBundleMaster(BundleVO bundle) {
		return bd.addBundleMaster(bundle);
	}

	public int addBundleDetail(BundleDetailVO bundleDetail) {
		return bd.addBundleDetail(bundleDetail);
	}

}
