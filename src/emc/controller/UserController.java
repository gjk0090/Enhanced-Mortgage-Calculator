package emc.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import emc.beans.User;
import emc.service.*;

@Controller
public class UserController {
		
	private UserService us;	

	public UserService getUs() {
		return us;
	}

	public void setUs(UserService us) {
		this.us = us;
	}
	
	private JavaMailService js;

	
	public JavaMailService getJs() {
		return js;
	}

	public void setJs(JavaMailService js) {
		this.js = js;
	}

	@RequestMapping(value = "/email_exist",method = RequestMethod.POST)
	@ResponseBody
	public int validateEmail(@RequestParam(value="email") String email){
		System.out.println("email");
		System.out.println(email);
		if(us.emailExist(email)){return 1;}else{return 0;}
	}
	
	@RequestMapping(value = "/register_user",method = RequestMethod.POST)
	@ResponseBody
	public String registerUser(
			@RequestParam(value="username") String username,
			@RequestParam(value="password") String password,
			@RequestParam(value="nickname") String nickname
			){
		System.out.println(username+" "+password+" "+nickname);
		us.registerNewUser(username, password, nickname);
		js.sendEmail(username,"Welcome to EMC!","Hello "+nickname+"!");
		return "registered";
	}
	
	@RequestMapping(value = "/forgot_password",method = RequestMethod.POST)
	@ResponseBody
	public int forgotPassword(@RequestParam(value="email") String email){
		System.out.println(email);
		if(us.emailExist(email)){
			String pass = us.resetPass(email,this.randomString(10));
			js.sendEmail(email, "Your new password", "Your new password is : "+pass+". Please change it after logged in!");
			return 1;
		}else{return 0;}
	}
	
	public String randomString(int length) {  
	    String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";  
	    Random random = new Random();  
	    StringBuffer buf = new StringBuffer();  
	    for (int i = 0; i < length; i++) {  
	        int num = random.nextInt(62);  
	        buf.append(str.charAt(num));  
	    }  
	    return buf.toString();  
	}  
	
	@RequestMapping(value = "/get_user",method = RequestMethod.POST)
	@ResponseBody
	public User getUser(HttpServletRequest request){
		String userName = request.getUserPrincipal().getName();
		return us.findUserByUserName(userName);
	}
	
	@RequestMapping(value = "/edit_user",method = RequestMethod.POST)
	@ResponseBody
	public int editUser(
			@RequestParam(value="nickname") String nickName,
			@RequestParam(value="password") String password,
			HttpServletRequest request){
		
		String userName = request.getUserPrincipal().getName();
		
		return us.editUser(userName,password,nickName);
		//return "redirect:"+"j_spring_security_logout";
	}
}
