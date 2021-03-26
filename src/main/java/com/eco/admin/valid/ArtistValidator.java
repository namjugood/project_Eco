package com.eco.admin.valid;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.eco.dto.ArtistVO;

public class ArtistValidator implements Validator{

	@Override
	public void validate(Object target, Errors errors) {
		ArtistVO dto = (ArtistVO)target;
		
		if (dto.getName() == null || dto.getName().trim().isEmpty()) errors.rejectValue("name", "name", "이름은 필수입니다.");
		if (dto.getGroupyn() == null || dto.getGroupyn().isEmpty()) errors.rejectValue("groupyn", "groupyn", "그룹여부를 선택하세요.");
		if (dto.getGender() == null || dto.getGender().isEmpty()) errors.rejectValue("gender", "gender", "성별을 선택하세요.");
		if (dto.getGseq() == 0) errors.rejectValue("gseq", "genre", "장르는 필수입니다.");
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return false;
	}

}
