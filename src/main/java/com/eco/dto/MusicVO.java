package com.eco.dto;

import java.sql.Timestamp;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Positive;

import com.eco.dto.search.SearchDTO;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = false)
@ToString(callSuper = true) // callSuper를 해야 부모의 값도 같이 출력(=> 좀더 쉬운 디버깅)
public class MusicVO  extends SearchDTO{
	private static final long serialVersionUID = -2271523043459441308L;
	
	private int mseq;
	
	@NotBlank(message="제목은 필수입니다.")
	private String title;
	@Positive(message = "앨범을 선택하세요.")
	private int abseq;
	@Positive(message = "아티스트를 선택하세요.")
	private int atseq;
	@Positive(message = "장르를 선택하세요.")
	private int gseq;

	private String content;
	private String theme;
	private String chart;
	private String titleyn;	
	private String musicby;
	private String lyricsby;
	private String producingby;
	private String src;
	private int rank;
	private int likecount;

	private String abtitle;
	private String abimg;
	private String abcontent;
	private String abtype;
	private int abgseq;
	private Timestamp pdate;
	private String name;
	private String groupyn;
	private String gender;
	private int atgseq;
	private String atimg;
	private String description;
	private String gtitle;
	private int bdseq;
	private int bmseq;
	
	private int useq;

	private Paging paging;

	private List<String> tseqs;
	private List<String> cseqs;
}
