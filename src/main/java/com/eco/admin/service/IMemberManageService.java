package com.eco.admin.service;

import java.util.List;

import com.eco.dto.MemberVO;
import com.eco.dto.Paging;

public interface IMemberManageService {
	
	MemberVO getMember(String useq);
	
	List<MemberVO> listMember(Paging paging, String key);
}
