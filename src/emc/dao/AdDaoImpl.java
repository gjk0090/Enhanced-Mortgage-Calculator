package emc.dao;


import java.util.List;

import org.hibernate.*;
import org.springframework.cache.annotation.CacheEvict;
import emc.beans.Ad;
import emc.util.HibernateUtil;

public class AdDaoImpl implements AdDao{

	@Override
	public Ad getAdById(int adId) {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.currentSession();
		Ad ad = (Ad)session.get(Ad.class, adId);

		return ad;
	}

	@Override
	public void updateAd(Ad ad) {
		Session session = HibernateUtil.currentSession();
		//session.evict(rate);
		Ad oriAd = (Ad)session.get(Ad.class, ad.getAdId());
		oriAd.setCount(oriAd.getCount()+1);
		Transaction tx = session.beginTransaction();
		tx.commit();
	
		
	}

	@Override
	public void addAd(Ad ad) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteAd(Ad ad) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Ad> queryAll() {
		// TODO Auto-generated method stub
				Session session = HibernateUtil.currentSession();
				String hql = "from Ad";
				Query query = session.createQuery(hql);
				return query.list();
	}

}
