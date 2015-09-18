package emc.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import emc.beans.Ad;
import emc.beans.User;
import emc.beans.UserAct;
import emc.util.HibernateUtil;

public class UserActDaoImpl implements UserActDao {

	@Override
	public UserAct getActById(int logId) {
		Session session = HibernateUtil.currentSession();
		Criteria c = session.createCriteria(UserAct.class);
		c.add(Restrictions.eq("logId", logId));
		return (UserAct)c.uniqueResult();
	}

	@Override
	public void updateAct(UserAct ua) {
		

	}

	@Override
	public void addAct(UserAct ua) {
		Session session = HibernateUtil.currentSession();
		session.save(ua);
		Transaction tx = session.beginTransaction();
		tx.commit();
		System.out.println(ua.getLogId()+ua.getUserId());

	}

	@Override
	public void deleteAct(UserAct ua) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<UserAct> queryAll() {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.currentSession();
		String hql = "from UserAct";
		Query query = session.createQuery(hql);
		return query.list();
	}

}
