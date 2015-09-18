package emc.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import emc.service.UserActService;
import emc.service.UserService;


import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class UserActController {
	
	private UserActService uas;
	private UserService us;
	public UserService getUs() {
		return us;
	}

	public void setUs(UserService us) {
		this.us = us;
	}

	public UserActService getUas() {
		return uas;
	}

	public void setUas(UserActService uas) {
		this.uas = uas;
	}
	

	@RequestMapping(value = "/add_act",method = RequestMethod.POST)
	@ResponseBody
	public void addUserAct(
			@RequestParam(value="timeStay") int timeStay,
			@RequestParam(value="userId") int userId
			){
		System.out.println(userId+" "+timeStay);
		uas.addNewAct(userId, timeStay);
	}
	

	
	

}
