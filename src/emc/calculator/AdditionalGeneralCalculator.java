package emc.calculator;

import java.util.ArrayList;
import java.util.List;

import emc.frm.FrmInput;
import emc.frm.FrmOutputObject;
import emc.frm.FrmResult;
import emc.frm.FrmResultObject;

public class AdditionalGeneralCalculator {
	
	public  static FrmOutputObject  additionCalculator(double amount,double down,int term,double rate,double additionPay,int additionMonth){
		FrmResult rResult=new FrmResult();
		List<FrmResultObject> result=new ArrayList<FrmResultObject>();
		FrmInput frmInput=new FrmInput(amount,down,term,rate,additionPay,additionMonth);
		FrmOutputObject realResult;
		double savedMoney;
			
		result=rResult.result(frmInput).getResult();
		savedMoney=rResult.getSavedMoney();
		realResult=new FrmOutputObject(result,savedMoney);
		return realResult;
		
	}

}
