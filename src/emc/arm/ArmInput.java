package emc.arm;

public class ArmInput {
	
	private int monthTerm;
	private double monthRate;
	private double addition=0;
	private int month=0;
	private double loan;
	private int fixedYear;
	public ArmInput(double amount,double down,int term,double rate,double addition,int month,int fixedYear){
		this.loan=amount-down;
		this.monthTerm=term*12;
		this.monthRate=rate/1200;
		this.addition=addition;
		this.month=month;
		this.fixedYear=fixedYear;
	}
	public int getMonthTerm() {
		return monthTerm;
	}
	public void setMonthTerm(int monthTerm) {
		this.monthTerm = monthTerm;
	}
	public double getMonthRate() {
		return monthRate;
	}
	public void setMonthRate(double monthRate) {
		this.monthRate = monthRate;
	}
	public double getAddition() {
		return addition;
	}
	public void setAddition(double addition) {
		this.addition = addition;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public double getLoan() {
		return loan;
	}
	public void setLoan(double loan) {
		this.loan = loan;
	}
	public int getFixedYear() {
		return fixedYear;
	}
	public void setFixedYear(int fixedYear) {
		this.fixedYear = fixedYear;
	}
	

}
