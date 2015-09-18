package emc.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.*;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;

import emc.beans.Rate;
import emc.util.HibernateUtil;

public class RateDaoImpl implements RateDao {

	@Override
	//@Cacheable("get_rate")
	public Rate getRateByTerm(int term) {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.currentSession();
		Rate rate = (Rate)session.get(Rate.class, term);

		return rate;
	}

	@Override
	public List<Rate> queryAll() {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.currentSession();
		String hql = "from Rate";
		Query query = session.createQuery(hql);
		return query.list();
	}

	@Override
	@CacheEvict(value="calculate_simple",allEntries=true)	
	public void updateRate(Rate rate) {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.currentSession();
		//session.evict(rate);
		Rate oriRate = (Rate)session.get(Rate.class, rate.getTerm());
		oriRate.setMin(rate.getMin());
		oriRate.setRate(rate.getRate());
		Transaction tx = session.beginTransaction();
		tx.commit();
	}

	@Override
	public void addRate(Rate rate) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteRate(Rate rate) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<Integer> getTerms() {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.currentSession();
		Query query = session.createSQLQuery("select term from rates");
		return query.list();
	}
	

}
