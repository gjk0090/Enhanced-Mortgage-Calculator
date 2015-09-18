package emc.service;

import emc.beans.UserAct;
import emc.dao.UserActDao;

public class UserActService {
	
	private UserActDao uad;

	public UserActDao getUad() {
		return uad;
	}

	public void setUad(UserActDao uad) {
		this.uad = uad;
	}
	
	public void addNewAct(int userId, int timeStay){
		UserAct ua = new UserAct();
		ua.setUserId(userId);
		ua.setTimeStay(timeStay);
		uad.addAct(ua);
	}
	

}
