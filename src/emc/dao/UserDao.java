package emc.dao;
import emc.beans.*;
import java.util.*;
public interface UserDao {
	public User findByUserName(String userName);
	public void save(User user);
	public void update(User user);
	public void delete(User user);
	public List<User> queryAll();
	void resetPass(String username, String password);
}
