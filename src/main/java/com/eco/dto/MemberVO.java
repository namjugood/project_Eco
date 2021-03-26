package com.eco.dto;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class MemberVO {
	private int useq;
	@Email(message="알맞은 아이디(이메일) 형식이 아닙니다")
	@NotEmpty(message="아이디(이메일)를 입력하세요")
	private String id;
//	@Length(min=8, message="8자리 이상입력")
	@NotEmpty(message="비밀번호를 입력하세요")
	private String pw;
	@NotEmpty(message="이름(성명)을 입력하세요")
	private String name;
	@NotEmpty(message="전화번호를 입력하세요")
	private String phone;
	private String gender;
	private String membership; // 이용권 여부
	private Date sdate; // 이용권 시작일
	private Date edate; // 이용권 만료일
	private Date indate;
	
	private List<Integer> likeList;
}
