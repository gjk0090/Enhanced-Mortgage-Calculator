package emc.frm;

import java.util.ArrayList;
import java.util.List;

public class FrmCalculator {
	
	private int month;
	private double monthPayment;
	private double balance;
	private double interest;
	private double principalPay;
	private double totalInterest;
	
	List<FrmResultObject> result1=new ArrayList<FrmResultObject>();
	List<FrmResultObject> result2=new ArrayList<FrmResultObject>();
	
	public List<FrmResultObject> generalFrm(FrmInput input){
		monthPayment=formula(input.getLoan(),input.getMonthRate(),input.getMonthTerm());
		monthPayment=Math.round(monthPayment*100)/100.00;
		balance=input.getLoan();
		interest=0;
		totalInterest=0;
		principalPay=0;
		month=1;
		while(balance>0 && month<=input.getMonthTerm()){
			interest=balance*input.getMonthRate();
			interest=format(interest);
			
			totalInterest=totalInterest+interest;
			totalInterest=format(totalInterest);
			principalPay=monthPayment-interest;
			balance=balance-principalPay;
			balance=format(balance);
			if(month==input.getMonthTerm()){
				interest=interest+balance;
				interest=format(interest);
				totalInterest=totalInterest+interest;
				totalInterest=Math.round(totalInterest*100)/100.00;
				 balance=0;
			}
			result1.add(new FrmResultObject(month,monthPayment,balance,interest,totalInterest));
			month++;			
		}

		return result1;
		
		
	}
	
	public List<FrmResultObject> additionFrm(FrmInput input){
		monthPayment=formula(input.getLoan(),input.getMonthRate(),input.getMonthTerm())+input.getAddition();
		monthPayment=format(monthPayment);
		balance=input.getLoan();
		interest=0;
		totalInterest=0;
		principalPay=0;
		month=1;
		int additionTerm=input.getMonth();
		while(balance>0 && month<=input.getMonthTerm()){
			if(month==additionTerm+1)
				monthPayment=monthPayment-input.getAddition();
			interest=balance*input.getMonthRate();
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
			result2.add(new FrmResultObject(month,monthPayment,balance,interest,totalInterest));
			month++;			
		}
		//setSavedMoney(totalInterest-previousInterest);
		return result2;
		
	}
	
	
	public double formula(double loan,double monthRate,double monthTerm){
		//double monthPayment;
		double bridge;
		bridge=Math.pow((1+monthRate), monthTerm);
		return (loan*bridge)*monthRate/(bridge-1);
	}
	
	public static double format (double input){
		return Math.round(input*100)/100.00;
	}
/*
	public double getSavedMoney() {
		return savedMoney;
	}

	public void setSavedMoney(double savedMoney) {
		this.savedMoney = savedMoney;
	}
	*/

	public double getTotalInterest() {
		return totalInterest;
	}

	public void setTotalInterest(double totalInterest) {
		this.totalInterest = totalInterest;
	}
	

}
