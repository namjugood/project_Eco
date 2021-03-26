package com.eco.dto;

import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Positive;
import javax.validation.constraints.Size;

import com.eco.dto.search.SearchDTO;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = false)
@ToString(callSuper = true) // callSuper를 해야 부모의 값도 같이 출력(=> 좀더 쉬운 디버깅)
public class ArtistVO extends SearchDTO {
	private static final long serialVersionUID = 4053409233581166283L;

	private int atseq;
	
	@NotBlank(message="이름은 필수입니다.")
	private String name;
	
	@NotBlank(message = "그룹여부를 선택하세요.")
	@Size(min=1, max=1, message = "그룹여부를 선택하세요.")
	private String groupyn;
	
	@NotBlank(message = "성별을 선택하세요.")
	@Size(min=1, max=1, message = "성별을 선택하세요.")
	private String gender;
	
	@Positive(message = "장르는 필수입니다.")
	private int gseq;
	
	private String img;
	private String oldimg;
	private String imglink;
	private String description;
	
	private int rank;
	private int likecount;

	private String atgenre;

	private List<AlbumVO> albumList;
	private int abcount; // 앨범수
	private int mucount; // 곡수
}
