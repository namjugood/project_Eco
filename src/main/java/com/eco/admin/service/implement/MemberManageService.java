package com.eco.admin.service.implement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eco.admin.dao.IMemberManageDao;
import com.eco.admin.service.IMemberManageService;
import com.eco.dto.MemberVO;
import com.eco.dto.Paging;

@Service
public class MemberManageService implements IMemberManageService {
	
	@Autowired
	IMemberManageDao memberManageDao;

	@Override
	public MemberVO getMember(String useq) {
		return memberManageDao.getMember(useq);
	}
	
	@Override
	public List<MemberVO> listMember(Paging paging, String key){
		List<MemberVO> list = memberManageDao.listMember(paging, key);
		return list;
	}

}
