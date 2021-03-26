package com.eco.dto.search;

import java.io.Serializable;

import com.eco.dto.Paging;

import lombok.Data;

@Data
public class SearchDTO implements Serializable {
	
	private static final long serialVersionUID = 5427742420093436962L;
	
	private String selectedTab = ""; // 선택된 탭
	private String selectedType = ""; // 선택된 타입
	private int selectedSeq; // 선택된 시퀀스
	
	private String selectedTheme = "";
	private String selectedChart = "";
	private String selectedGenre = "";
	private int selectedGseq = 0;

	private String selectedGroupyn = "";
	private String selectedGender = "";
	private String selectedAbtype = "";

	
	private String searchTable = ""; // 검색할 테이블명
	
	private String searchFilter = ""; // ${fieldName}desc || ${fieldName}asc

	private String searchkeywordTarget = ""; // like 할때의 대상 컬럼
	private String searchKeyword = ""; // like 할때의 비교값

	private String searchUseyn = ""; // 사용여부

	private int page = 1;
	
	
	private Paging paging;
	private int rn;
}