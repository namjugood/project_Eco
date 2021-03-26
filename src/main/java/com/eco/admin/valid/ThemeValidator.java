package com.eco.admin.valid;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.eco.dto.ThemeVO;

public class ThemeValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return false;
	}

	@Override
	public void validate(Object target, Errors errors) {
		ThemeVO dto = (ThemeVO)target;
		
		if(dto.getTitle()==null || dto.getTitle().trim().isEmpty())
			errors.rejectValue("title", "제목을 입력하세요");
		
	}

}
