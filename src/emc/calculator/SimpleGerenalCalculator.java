package emc.calculator;

import java.util.ArrayList;
import java.util.List;

import emc.frm.*;
public class SimpleGerenalCalculator {
	
	public  static FrmOutputObject  generalCalculator(double amount,double down,int term,double rate){
		FrmResult rResult=new FrmResult();
		List<FrmResultObject> result=new ArrayList<FrmResultObject>();
		FrmInput frmInput=new FrmInput(amount,down,term,rate,0,0);
		FrmOutputObject realResult;
		double savedMoney=0;	
		result=rResult.result(frmInput).getResult();
		realResult=new FrmOutputObject(result,savedMoney);
		return realResult;
		
	}

}
