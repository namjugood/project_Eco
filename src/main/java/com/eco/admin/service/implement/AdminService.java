package com.eco.admin.service.implement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eco.admin.dao.IAdminDao;
import com.eco.admin.service.IAdminService;

@Service
public class AdminService implements IAdminService {

	@Autowired
	IAdminDao adao;

	@Override
	public int adminCheck(String adminId, String adminPw) {
		String pw = adao.adminCheck(adminId);
		int result=0;
		if(adminPw==null) result=-1;
		else if(adminPw.equals(pw)) result=1;
		else if(!adminPw.equals(pw)) result=0;
		return result;
	}

}
