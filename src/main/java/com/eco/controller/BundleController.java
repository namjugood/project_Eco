package com.eco.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eco.dto.BundleVO;
import com.eco.dto.BundleDetailVO;
import com.eco.dto.MemberVO;
import com.eco.service.BundleService;

@Controller
public class BundleController {
	
	@Autowired
	BundleService bundleService;

	@RequestMapping(value = "/bundle", method = RequestMethod.GET)
	public String bundle(Model model, HttpServletRequest request) {
		
		return "music/bundle";
	}
	@RequestMapping(value = "/addBundleMaster", method = RequestMethod.POST)
	public @ResponseBody BundleVO addBundleMaster(Model model, HttpServletRequest request
			, @RequestBody @Valid BundleVO bundle
			, BindingResult result
			) {
		
		MemberVO loginUser = (MemberVO) request.getSession().getAttribute("loginUser");
		if (loginUser == null) {
			return null;
		} else {
			bundle.setUseq(loginUser.getUseq());
			bundle.setUseyn("Y");
			
			if(result.getFieldError("title")!=null) {
				System.out.println(result.getFieldError("title"));
				return null;
			} else {
				bundleService.addBundleMaster(bundle);
				return bundle;
			}
		}
	}
	@RequestMapping(value = "/modBundle", method = RequestMethod.POST)
	public String modBundle(Model model, HttpServletRequest request) {
		String returnPath = "";
		return "redirect:/" + returnPath;
	}
	@RequestMapping(value = "/addBundleDetail", method = RequestMethod.POST)
	public @ResponseBody boolean addBundleDetail(Model model, HttpServletRequest request
			, @RequestBody List<BundleDetailVO> bundleDetailList
			) {
		System.out.println("System.out.println(bundleDetailList);");
		System.out.println(bundleDetailList);
		
		int insertCount = 0;
		for (BundleDetailVO bundleDetail : bundleDetailList) {
			System.out.println(bundleDetail);
			insertCount += bundleService.addBundleDetail(bundleDetail);
		}
		
		if (insertCount == bundleDetailList.size()) {
			return true;
		} else {
			return false;
		}
		
	}
	@RequestMapping(value = "/delBundleDetail", method = RequestMethod.POST)
	public String delBundleDetail(Model model, HttpServletRequest request) {
		String returnPath = "";
		return "redirect:/" + returnPath;
	}
}
