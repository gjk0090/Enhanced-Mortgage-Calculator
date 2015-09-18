package emc.arm;

import java.util.ArrayList;
import java.util.List;

public class ArmResult {
	
	List<ArmResultObject> result1=new ArrayList<ArmResultObject>();
	List<ArmResultObject> result2=new ArrayList<ArmResultObject>();

	private ArmOutputObject outputObject;
	private double totalInterest;
	private double savedMoney;
	public ArmOutputObject result(ArmInput input){
		
			ArmCalculator calculator1=new ArmCalculator();
			result1=calculator1.generalArm(input);	
			ArmCalculator calculator2=new ArmCalculator();
			result2=calculator2.additionArm(input);	
			if(input.getAddition()==0){
				totalInterest=calculator1.getTotalInterest();
				savedMoney=0;	
				outputObject=new ArmOutputObject(result1,savedMoney);
				return outputObject;
			}
			else{
				totalInterest=calculator2.getTotalInterest();
				savedMoney=calculator1.getTotalInterest()-calculator2.getTotalInterest();
				savedMoney=Math.round(savedMoney*100)/100.00;
				outputObject=new ArmOutputObject(result2,savedMoney);
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
