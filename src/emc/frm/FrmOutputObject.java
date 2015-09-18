package emc.frm;

import java.util.ArrayList;
import java.util.List;

//import com.mercury.arm.ArmResultObject;

public class FrmOutputObject {

	private List<FrmResultObject> result=new ArrayList<FrmResultObject>();
	private double savedMoney=0;
	public FrmOutputObject(List<FrmResultObject> result, double savedMoney) {
		//super();
		this.result = result;
		this.savedMoney = savedMoney;
	}
	public List<FrmResultObject> getResult() {
		return result;
	}
	public void setResult(List<FrmResultObject> result) {
		this.result = result;
	}
	public double getSavedMoney() {
		return savedMoney;
	}
	public void setSavedMoney(double savedMoney) {
		this.savedMoney = savedMoney;
	}
}
