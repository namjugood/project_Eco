package com.eco.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eco.dao.IMemberDao;
import com.eco.dto.MemberVO;

@Service
public class MemberService {
	
	@Autowired
	IMemberDao mdao;
	
	public MemberVO getMember(String id) {
		return mdao.getMember(id);
	}

	public int insertMember(MemberVO mvo) {
		return mdao.insertMember(mvo);
	}
	public void resetPw(MemberVO membervo) {
		mdao.resetPw(membervo);
	}
	
	public MemberVO confirmIdNamePhone(String id, String name, String phone) {
		return mdao.confirmIdNamePhone( id, name,  phone);
	}
	public MemberVO confirmNamePhone(String name, String phone) {
		return mdao.confirmNamePhone( name,  phone); 
	}

	public int updateMember(MemberVO membervo) {
		return mdao.updateMember(membervo);
	}

	public int buyMembership30(MemberVO membervo) {
		return mdao.buyMembership30(membervo);
	}
	
	public int buyMembership7(MemberVO membervo) {
		return mdao.buyMembership7(membervo);
	}
	
	public int buyMembership1(MemberVO membervo) {
		return mdao.buyMembership1(membervo);
	}

	public int membershipExpire(MemberVO membervo) {
		return mdao.membershipExpire(membervo);
		
	}
	
	public int getDuplicatedPhoneUserCount(String phone) {
		return mdao.getDuplicatedPhoneUserCount(phone);
	}



}
