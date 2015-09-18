package emc.service;

import emc.beans.Ad;
import emc.beans.User;
import emc.dao.AdDao;

public class AdService {
	
	private AdDao add;
	

	public AdDao getAdd() {
		return add;
	}


	public void setAdd(AdDao add) {
		this.add = add;
	}


	public Ad findAdByAdId(int adId){
		return add.getAdById(adId);
	}
	
	
	public int editAd(int adId){

		Ad ad = new Ad();
		
		ad.setAdId(adId);
		ad.setCount(1);
		
		add.updateAd(ad);
		return 1;
	}
}
