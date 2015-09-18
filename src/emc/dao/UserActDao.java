package emc.dao;


import java.util.List;

import emc.beans.UserAct;

public interface UserActDao {
	
	public UserAct getActById(int logId);
	public void updateAct(UserAct ua);
	public void addAct(UserAct ua);
	public void deleteAct(UserAct ua);
	public List<UserAct> queryAll();

}
