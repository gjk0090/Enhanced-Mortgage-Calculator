package emc.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import emc.service.*;
import emc.dao.*;

@Controller
public class LoginController {
	
	private RateDao rd;
	private UserService us;
	
	public RateDao getRd() {
		return rd;
	}

	public void setRd(RateDao rd) {
		this.rd = rd;
	}
	
	public UserService getUs() {
		return us;
	}

	public void setUs(UserService us) {
		this.us = us;
	}

	
	
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		mav.addObject("lists",rd.getTerms());
		return mav;
	}
	
	
	@RequestMapping(value="/main", method = RequestMethod.GET)
	public ModelAndView mainPage(HttpServletRequest request) {
		
		String userName = request.getUserPrincipal().getName();
		//or
		//String userName = request.getRemoteUser();
		//Equivalently in JSP EL:
		//${pageContext.request.userPrincipal.name}
		//or
		//${pageContext.request.remoteUser}
		//more: http://www.baeldung.com/get-user-in-spring-security
				
		ModelAndView mav = new ModelAndView();
		mav.setViewName("main");
		mav.addObject("nickname", us.findUserByUserName(userName).getNickName());
		mav.addObject("userrole", us.findUserByUserName(userName).getRole());
		mav.addObject("userid", us.findUserByUserName(userName).getUserId());
		mav.addObject("lists", rd.getTerms());
		return mav;
	}
	@RequestMapping(value="/try",method=RequestMethod.GET)
	public ModelAndView tryPage(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("try");
		mav.addObject("lists",rd.getTerms());
		return mav;
	}
}
