package emc.arm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import emc.dao.RateDao;
import emc.dao.RateDaoImpl;

public class ArmCalculator {
	
	private int month;
	private double monthPayment;
	private double balance;
	private double interest;
	private double principalPay;
	private double totalInterest;
	private double fixedMonth;
	
	List<ArmResultObject> result1=new ArrayList<ArmResultObject>();
	List<ArmResultObject> result2=new ArrayList<ArmResultObject>();
	
	
	public List<ArmResultObject> generalArm(ArmInput input){
		double fixedPayment=formula(input.getLoan(),input.getMonthRate(),input.getMonthTerm());
		fixedPayment=format(fixedPayment);
		balance=input.getLoan();
		fixedMonth=input.getFixedYear()*12;
		interest=0;
		totalInterest=0;
		principalPay=0;
		month=1;
		double floatRate;
		
		while(balance>0 && month<=input.getMonthTerm()){
			if(fixedMonth>0){
				monthPayment=fixedPayment;
				floatRate=input.getMonthRate();
			}
			
			else{
				//ArmInput newInput=new ArmInput(balance,0,month/12,input.getMonthRate(),0,0,0);
				floatRate=rateGenerator(input.getMonthTerm()-month);
				monthPayment=formula(balance,floatRate,input.getMonthTerm()-month+1);
				monthPayment=format(monthPayment);
			}			
			interest=balance*floatRate;
			interest=format(interest);
			totalInterest=totalInterest+interest;
			totalInterest=format(totalInterest);
			principalPay=monthPayment-interest;
			balance=balance-principalPay;
			balance=format(balance);
			if(balance<=0){
				monthPayment=monthPayment+balance;
				principalPay=monthPayment-interest;
				balance=0;
				
			}
			result1.add(new ArmResultObject(month,monthPayment,balance,interest,totalInterest));
			month++;	
			fixedMonth--;
		}
		
		return result1;
		
		
	}
	
	public List<ArmResultObject> additionArm(ArmInput input){
		monthPayment=formula(input.getLoan(),input.getMonthRate(),input.getMonthTerm())+input.getAddition();
		monthPayment=format(monthPayment);
		balance=input.getLoan();
		interest=0;
		fixedMonth=input.getFixedYear()*12;
		totalInterest=0;
		principalPay=0;
		month=1;
		double floatRate;
		int additionTerm=input.getMonth();
		while(balance>0 && month<=input.getMonthTerm()){
			if(fixedMonth>0){
				//monthPayment=monthPayment+input.getAddition();
				floatRate=input.getMonthRate();
			}
			else{
				floatRate=rateGenerator(input.getMonthTerm()-month);
				monthPayment=formula(balance,floatRate,input.getMonthTerm()-month+1);
				monthPayment=format(monthPayment);
			}	
			
			if(month<fixedMonth&&month==additionTerm+1)
				monthPayment=monthPayment-input.getAddition();
			interest=balance*floatRate;
			interest=format(interest);
			totalInterest=totalInterest+interest;
			totalInterest=format(totalInterest);
			principalPay=monthPayment-interest;
			balance=balance-principalPay;
			balance=format(balance);
			if(balance<=0){
				monthPayment=monthPayment+balance;
				principalPay=monthPayment-interest;
				balance=0;
				
			}
			result2.add(new ArmResultObject(month,monthPayment,balance,interest,totalInterest));
			month++;	
			fixedMonth--;
		}
		return result2;
		
	}
	
	
	public double formula(double loan,double monthRate,double monthTerm){
		double bridge;
		bridge=Math.pow((1+monthRate), monthTerm);
		return (loan*bridge)*monthRate/(bridge-1);
	}
	public static double format (double input){
		return Math.round(input*100)/100.00;
	}

	public double getTotalInterest() {
		return totalInterest;
	}

	public void setTotalInterest(double totalInterest) {
		this.totalInterest = totalInterest;
	}
	
	
	
	private static RateDao rd = new RateDaoImpl();
	private static  Map<Integer,Double> randomRate;
	static{
		randomRate=new HashMap<Integer,Double>();
		randomRate.put(30, rd.getRateByTerm(30).getRate());
		randomRate.put(20, rd.getRateByTerm(20).getRate());
		randomRate.put(15, rd.getRateByTerm(15).getRate());
		randomRate.put(10, rd.getRateByTerm(10).getRate());
		randomRate.put(5, rd.getRateByTerm(5).getRate());
		randomRate.put(3, rd.getRateByTerm(3).getRate());
		randomRate.put(2, rd.getRateByTerm(2).getRate());
		randomRate.put(1, rd.getRateByTerm(1).getRate());		
	}
	
	public static double rateGenerator(double fixedMonth){
		double baseRate;	
		if(fixedMonth<13)
			baseRate=randomRate.get(1);
		else if(fixedMonth>=13 && fixedMonth<25)
			baseRate=randomRate.get(2);
		else if(fixedMonth>=25 && fixedMonth<37)
			baseRate=randomRate.get(3);
		else if(fixedMonth>=37 && fixedMonth<61)
			baseRate=randomRate.get(5);
		else if(fixedMonth>=61 && fixedMonth<121)
			baseRate=randomRate.get(10);
		else if(fixedMonth>=121 && fixedMonth<181)
			baseRate=randomRate.get(15);
		else if(fixedMonth>=181 && fixedMonth<241)
			baseRate=randomRate.get(20);
		else
			baseRate=randomRate.get(30);
		

	double result;
	double minimum=baseRate-0.2;
	Random rand = new Random();
	int  n = rand.nextInt(400) + (int)minimum*1000;
	result=n/1000.000;
	return result/1200;
	
	}
	

}
