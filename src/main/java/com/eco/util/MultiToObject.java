package com.eco.util;

import java.lang.reflect.InvocationTargetException;
import java.util.Enumeration;
import java.util.HashMap;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;

import com.oreilly.servlet.MultipartRequest;

public class MultiToObject {
	
	
	/**
	 * copy
	 * @param multi : MultipartRequest
	 * @param target : VO || DTO
	 * @return MultipartRequest multi의 파라미터값들로 적용된 target
	 */
	public static Object copy(MultipartRequest multi, Object target) {
		
		HashMap<String, Object> origin = new HashMap<String, Object>();
		
		@SuppressWarnings("unchecked") // Enumeration<String>이 확실하므로 체크 불필요
		Enumeration<String> parameterNames = multi.getParameterNames(); // MultipartRequest의 모든 파라미터 키값
		
		while(parameterNames.hasMoreElements()) {
			String key = (String) parameterNames.nextElement();
			Object value = multi.getParameter(key); // MultipartRequest의 한 키값에 대응하는 값 
			origin.put(key, value); // key:value 하나씩 저장
		}
		
		@SuppressWarnings("unchecked") // Enumeration<String>이 확실하므로 체크 불필요
		Enumeration<String> fileNames = multi.getFileNames(); // MultipartRequest의 모든 파일이름들
		
		while (fileNames.hasMoreElements()) {
			String key = (String) fileNames.nextElement();
			String value = multi.getFilesystemName(key); // 저장된 파일의 이름
			origin.put(key, value); // key:파일명 하나씩 저장
		}
		
		try {
			BeanUtils.populate(target, origin); // 차곡차곡 쌓은 값 원하는 VO로 자동 셋팅 
		} catch (IllegalAccessException e) {e.printStackTrace();
		} catch (InvocationTargetException e) {e.printStackTrace();} 
		
		return target;
	}
	
	/**
	 * valid
	 * @param target : 검증 대상 객체
	 * @param result : 에러 기록 객체(from Controller)
	 * @param validatorImpl : Validator 구현 클래스
	 * @return BindingResult result
	 */
	public static BindingResult valid(Object target, BindingResult result, Class<?> validatorImpl) {
		try {
			
			Validator validator = (Validator) validatorImpl.newInstance();
			validator.validate(target, result);
			
		} catch (InstantiationException e) {e.printStackTrace();
		} catch (IllegalAccessException e) {e.printStackTrace();}
		
		return result;
	}
	

}
