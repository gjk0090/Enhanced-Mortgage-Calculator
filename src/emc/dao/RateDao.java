package emc.dao;

import java.util.List;
import java.util.Map;

import emc.beans.Rate;

public interface RateDao {
	public Rate getRateByTerm(int term);
	public List<Rate> queryAll();
	public void updateRate(Rate rate);
	public void addRate(Rate rate);
	public void deleteRate(Rate rate);
	public List<Integer> getTerms();
}
