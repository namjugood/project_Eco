package com.eco.dto;

import java.sql.Timestamp;
import java.util.List;

import com.eco.dto.search.SearchDTO;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = false)
@ToString(callSuper = true) // callSuper를 해야 부모의 값도 같이 출력(=> 좀더 쉬운 디버깅)
public class AlbumVO extends SearchDTO {
	private static final long serialVersionUID = -9130749831011288129L;
	
	private int abseq;
	private int atseq;
	private String title;
	private String img;
	private String content;
	private String abtype;
	private int gseq;
	private Timestamp pdate;
	private String inputpdate;
	private int rank;
	private int likecount;

	private String abgenre;
	private String name;
	private String groupyn;
	private String gender;
	private int atgseq;
	private String atgenre;
	private String atimg;
	private String description;
	
	private String newabtype;
	
	private String imglink;
	private String oldimg;
	
	private String mode;
	
	private int useq;

	private List<MusicVO> musicList;
	private int mucount; // 곡수
}
