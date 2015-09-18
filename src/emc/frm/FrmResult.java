package emc.frm;

import java.util.ArrayList;
import java.util.List;


public class FrmResult {
	
	List<FrmResultObject> result1=new ArrayList<FrmResultObject>();
	List<FrmResultObject> result3=new ArrayList<FrmResultObject>();

	private FrmOutputObject outputObject;
	private double totalInterest;
	private double savedMoney;
	public FrmOutputObject result(FrmInput input){
		
			FrmCalculator calculator1=new FrmCalculator();
			result1=calculator1.generalFrm(input);	
			FrmCalculator calculator2=new FrmCalculator();
			//FrmCalculator calculator3=new FrmCalculator();
			//result2=calculator2.generalFrm(input);	
			result3=calculator2.additionFrm(input);	
			if(input.getAddition()==0){
				totalInterest=calculator1.getTotalInterest();
				savedMoney=0;	
				outputObject=new FrmOutputObject(result1,savedMoney);
				return outputObject;
				
			}
			else{
				totalInterest=calculator2.getTotalInterest();
				savedMoney=calculator1.getTotalInterest()-calculator2.getTotalInterest();
				savedMoney=Math.round(savedMoney*100)/100.00;
				outputObject=new FrmOutputObject(result3,savedMoney);
				return outputObject;
			}
			
		
		
	}
	public double getTotalInterest() {
		return totalInterest;
	}
	public void setTotalInterest(double totalInterest) {
		this.totalInterest = totalInterest;
	}
	public double getSavedMoney() {
		return savedMoney;
	}
	public void setSavedMoney(double savedMoney) {
		this.savedMoney = savedMoney;
	}
	
}
