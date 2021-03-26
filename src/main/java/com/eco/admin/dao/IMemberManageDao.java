package com.eco.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.eco.dto.MemberVO;
import com.eco.dto.Paging;

@Mapper
public interface IMemberManageDao {

	MemberVO getMember(String useq);

	List<MemberVO> listMember(Paging paging, String key);

}