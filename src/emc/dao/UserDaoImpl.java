package emc.dao;

import java.util.List;
import org.hibernate.*;
import org.hibernate.criterion.Restrictions;

import emc.util.*;

import emc.beans.User;

public class UserDaoImpl implements UserDao {

	@Override
	public User findByUserName(String userName) {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.currentSession();
		Criteria c = session.createCriteria(User.class);
		c.add(Restrictions.eq("userName", userName));
		return (User)c.uniqueResult();
	}

	@Override
	public void save(User user) {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.currentSession();
		session.save(user);
		Transaction tx = session.beginTransaction();
		tx.commit();
		System.out.println(user.getUserId()+user.getNickName());
	}

	@Override
	public void update(User newUser) {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.currentSession();
		User user = this.findByUserName(newUser.getUserName());
		user.setPassword(newUser.getPassword());
		user.setNickName(newUser.getNickName());
		Transaction tx = session.beginTransaction();
		tx.commit();
	}

	@Override
	public void delete(User user) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<User> queryAll() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void resetPass(String userName, String password){
		Session session = HibernateUtil.currentSession();
		User user = this.findByUserName(userName);
		user.setPassword(password);
		Transaction tx = session.beginTransaction();
		tx.commit();
	}

}
