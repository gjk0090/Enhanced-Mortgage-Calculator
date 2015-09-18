package emc.calculator;

import java.util.ArrayList;
import java.util.List;

import emc.arm.ArmInput;
import emc.arm.ArmOutputObject;
import emc.arm.ArmResult;
import emc.arm.ArmResultObject;

public class ArmAdditionalCalculator {

	public static ArmOutputObject additionCalculator(double amount,
			double down, int term, double rate, int initPeriod,double additionPay,int additionMonth) {
		ArmResult rResult = new ArmResult();
		List<ArmResultObject> result = new ArrayList<ArmResultObject>();
		ArmInput armInput = new ArmInput(amount, down, term, rate, additionPay, additionMonth,
				initPeriod);
		ArmOutputObject realResult;
		double savedMoney ;
		result = rResult.result(armInput).getResult();
		savedMoney=rResult.getSavedMoney();
		realResult = new ArmOutputObject(result, savedMoney);
		return realResult;

	}
}
