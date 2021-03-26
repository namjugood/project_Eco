package com.eco.admin.valid;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.eco.dto.AlbumVO;

public class AlbumValidator implements Validator{
	@Override
	public void validate(Object target, Errors errors) {
		AlbumVO dto = (AlbumVO)target;
		System.out.println("System.out.println(dto);");
		System.out.println(dto);
		
		if (dto.getTitle() == null || dto.getTitle().trim().isEmpty()) errors.rejectValue("title", "title");
		if (dto.getAtseq() == 0) errors.rejectValue("atseq", "atseq");
		if (dto.getGseq() == 0) errors.rejectValue("gseq", "gseq");
		
		if (dto.getNewabtype() == null || dto.getNewabtype().trim().isEmpty()) {
			if (dto.getAbtype() == null || dto.getAbtype().trim().isEmpty()) {
				errors.rejectValue("abtype", "abtype radio");
			} else {
				errors.rejectValue("abtype", "abtype text");
			}
		}
		
		
		if (dto.getMode().equals("insert")) {
			if (dto.getInputpdate() == null || dto.getInputpdate().trim().isEmpty()) errors.rejectValue("pdate", "pdate");	
		} else {
			// do nothing...
		}
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return false;
	}

}
