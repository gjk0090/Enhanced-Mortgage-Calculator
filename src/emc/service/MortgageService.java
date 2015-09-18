package emc.service;

import emc.arm.ArmOutputObject;
import emc.calculator.AdditionalGeneralCalculator;
import emc.calculator.ArmAdditionalCalculator;
import emc.calculator.ArmGeneralCalculator;
import emc.calculator.SimpleGerenalCalculator;
import emc.dao.RateDao;
import emc.frm.FrmOutputObject;


public class MortgageService {

	private RateDao rd;

	public RateDao getRd() {
		return rd;
	}

	public void setRd(RateDao rd) {
		this.rd = rd;
	}

	public ArmOutputObject calculateARM(double amount, double down, int term,
			 double additionPay, int additionMonth,int initPeriod,double percent){
		
		if (additionPay == 0) {
			ArmOutputObject result = ArmGeneralCalculator.generalCalculator(amount, down, term,rd
					.getRateByTerm(term).getRate()*percent, initPeriod);
			return result;
		}
		else{
			
			ArmOutputObject result = ArmAdditionalCalculator.additionCalculator(amount, down, term,rd
					.getRateByTerm(term).getRate()*percent, initPeriod,additionPay,additionMonth);
			return result;
			
		}
		
	}
	public FrmOutputObject calculateSimple(double amount, double down, int term,
		 double additionPay, int additionMonth,double percent) {
	
			if (additionPay == 0) {
				FrmOutputObject result = SimpleGerenalCalculator
						.generalCalculator(amount, down, term, rd
								.getRateByTerm(term).getRate()*percent);
				return result;
			} else {
				FrmOutputObject result = AdditionalGeneralCalculator
						.additionCalculator(amount, down, term, rd
								.getRateByTerm(term).getRate()*percent, additionPay,
								additionMonth);
				return result;
			}
		
	}
}
