package emc.arm;

import java.util.ArrayList;
import java.util.List;

public class ArmOutputObject {
	private List<ArmResultObject> result=new ArrayList<ArmResultObject>();
	private double savedMoney=0;
	public ArmOutputObject(List<ArmResultObject> result, double savedMoney) {
		//super();
		this.result = result;
		this.savedMoney = savedMoney;
	}
	public List<ArmResultObject> getResult() {
		return result;
	}
	public void setResult(List<ArmResultObject> result) {
		this.result = result;
	}
	public double getSavedMoney() {
		return savedMoney;
	}
	public void setSavedMoney(double savedMoney) {
		this.savedMoney = savedMoney;
	}
	

}
