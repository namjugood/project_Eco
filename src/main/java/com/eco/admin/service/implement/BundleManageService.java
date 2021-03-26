package com.eco.admin.service.implement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import com.eco.admin.dao.IBundleManageDao;
import com.eco.admin.service.IBundleManageService;
import com.eco.dto.BundleVO;

@Service
public class BundleManageService implements IBundleManageService{
	
	@Autowired
	IBundleManageDao bundleManageDao;

	@Autowired
	TransactionTemplate transactionTemplate;

	@Override
	public List<BundleVO> list(BundleVO search) {
		return bundleManageDao.list(search);
	}

	@Override
	public int insert(BundleVO bundle) {
		return bundleManageDao.insert(bundle);
	}

	@Override
	public int delete(int mseq) {
		int result = 0;
		try {
			transactionTemplate.execute(
				new TransactionCallbackWithoutResult() {
					@Override
					protected void doInTransactionWithoutResult(TransactionStatus status) {
						bundleManageDao.detailClear(mseq);
						bundleManageDao.delete(mseq);
					}
				}
			);
			result = 1;
		} catch (Exception e) {
			result = 0;
		}

		return result;
	}

	@Override
	public int update(BundleVO bundle) {
		return bundleManageDao.update(bundle);
	}

	@Override
	public int detailSave(int bmseq, String[] mseq) {
		int result = 0;
		try {
			transactionTemplate.execute(
				new TransactionCallbackWithoutResult() {
					@Override
					protected void doInTransactionWithoutResult(TransactionStatus status) {
						bundleManageDao.detailClear(bmseq);
						
						if (mseq != null) {
							for(String m : mseq) {
								bundleManageDao.detailAdd(bmseq, Integer.parseInt(m));
							}							
						}
					}
				}
			);
			
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
			result = 0;
		}

		return result;
	}

}