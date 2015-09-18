package emc.frm;

public class FrmResultObject {
	private int month;
	private double monthPayment;
	private double balance;
	private double interest;
	private double totalInterest;
	public FrmResultObject(int month, double monthPayment, double balance,
			double interest, double totalInterest) {
		//super();
		this.month = month;
		this.monthPayment = monthPayment;
		this.balance = balance;
		this.interest = interest;
		this.totalInterest = totalInterest;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public double getMonthPayment() {
		return monthPayment;
	}
	public void setMonthPayment(double monthPayment) {
		this.monthPayment = monthPayment;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public double getInterest() {
		return interest;
	}
	public void setInterest(double interest) {
		this.interest = interest;
	}
	public double getTotalInterest() {
		return totalInterest;
	}
	public void setTotalInterest(double totalInterest) {
		this.totalInterest = totalInterest;
	}
	

}
