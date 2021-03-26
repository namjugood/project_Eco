package com.eco.dto;

import java.sql.Timestamp;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import com.eco.dto.search.SearchDTO;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = false)
@ToString(callSuper = true) // callSuper를 해야 부모의 값도 같이 출력(=> 좀더 쉬운 디버깅)
public class BundleVO extends SearchDTO {
	private static final long serialVersionUID = -4830113505738601158L;
	private int bmseq;
    private int useq;
    @NotEmpty(message = "제목을 입력하세요.")
    @NotBlank(message = "제목을 공백없이 입력하세요.")
    private String title;
    @NotEmpty(message = "사용여부를 체크해주세요")
    private String useyn;
    private Timestamp cdate;

    private List<MusicVO> musicList;
    private int mucount;
    private String mseqList; // ${mseq}|${mseq}|${mseq}... |로 구분된 mseq
}
