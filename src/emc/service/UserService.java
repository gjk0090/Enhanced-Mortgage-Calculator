package emc.service;
import java.util.Random;

import emc.beans.*;
import emc.dao.UserDao;

public class UserService {
	private UserDao ud;

	public UserDao getUd() {
		return ud;
	}

	public void setUd(UserDao ud) {
		this.ud = ud;
	}
	
	
	
	public User findUserByUserName(String userName){
		return ud.findByUserName(userName);
	}
	
	public boolean emailExist(String email){
		User u = ud.findByUserName(email);
		if(u==null){return false;}else{return true;}
	}
	
	public void registerNewUser(String username, String password, String nickname){
		User user = new User();
		user.setUserName(username);
		user.setPassword(password);
		user.setNickName(nickname);
		user.setEnabled(1);
		user.setRole("ROLE_USER");
		ud.save(user);
	}
	
	public String resetPass(String email,String password){
		String pass = password;
		ud.resetPass(email, pass);
		return pass;
	}
	
	public int editUser(String userName, String password, String nickName){

		User user = new User();
		user.setNickName(nickName);
		user.setPassword(password);
		user.setUserName(userName);
		
		ud.update(user);
		return 1;
	}
	

}
