package emc.dao;

import java.util.List;

import emc.beans.Ad;

public interface AdDao {
	public Ad getAdById(int adId);
	public void updateAd(Ad ad);
	public void addAd(Ad ad);
	public void deleteAd(Ad ad);
	public List<Ad> queryAll();

}
