package emc.beans;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="rates")
public class Rate implements Serializable {
	

	private int term;
	private double rate;
	private int min;
	
	@Id
	@Column(name = "term")	
	public int getTerm() {
		return term;
	}
	public void setTerm(int term) {
		this.term = term;
	}
	
	@Column(name = "rate")
	public double getRate() {
		return rate;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}

	@Column(name = "min")
	public int getMin() {
		return min;
	}
	public void setMin(int min) {
		this.min = min;
	}

	
}
