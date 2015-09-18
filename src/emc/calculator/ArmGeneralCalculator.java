package emc.calculator;

import java.util.ArrayList;
import java.util.List;

import emc.arm.*;

public class ArmGeneralCalculator {
	
	public  static ArmOutputObject  generalCalculator(double amount,double down,int term,double rate,int initPeriod){
		ArmResult rResult=new ArmResult();
		List<ArmResultObject> result=new ArrayList<ArmResultObject>();
		ArmInput armInput=new ArmInput(amount,down,term,rate,0,0,initPeriod);
		ArmOutputObject realResult;
		double savedMoney=0;	
		result=rResult.result(armInput).getResult();
		realResult=new ArmOutputObject(result,savedMoney);
		return realResult;
		
	}

}
