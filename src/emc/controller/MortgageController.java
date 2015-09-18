package emc.controller;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.CacheEvict;

import emc.service.*;
import emc.arm.ArmOutputObject;
import emc.beans.*;
import emc.frm.FrmOutputObject;

@Controller
public class MortgageController {
	
	private MortgageService ms;
	
	public MortgageService getMs() {
		return ms;
	}

	public void setMs(MortgageService ms) {
		this.ms = ms;
	}

	@RequestMapping(value = "/calculate_simple",method = RequestMethod.POST)
	@ResponseBody
	@Cacheable("calculate_simple")
	public FrmOutputObject calculateSimple(
			@RequestParam(value="amount",defaultValue="200000") double amount,
			@RequestParam(value="down",defaultValue="20000") double down,
			@RequestParam(value="term",defaultValue="5") int term,
			@RequestParam(value="isARM") boolean isARM,
			@RequestParam(value="initPeriod") int initPeriod,
			@RequestParam(value="addtionPay") double addtionPay,
			@RequestParam(value="additionMonth") int additionMonth,
	        @RequestParam(value="credit") int credit){
		
		double percent=1;
		switch(credit){
		case 1:percent=1.10;
		break;
		case 2:percent=1;
		break;
		case 3:percent=0.95;
		break;
		case 4:percent=0.9;
		default:
		}

		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(amount+" "+down+" "+term+" "+isARM+" "+initPeriod+" "+addtionPay+" "+additionMonth);
		
		FrmOutputObject result = ms.calculateSimple(amount, down, term,addtionPay,additionMonth,percent);
		return result;
	}
	
	@RequestMapping(value = "/calculate_arm",method = RequestMethod.POST)
	@ResponseBody
	@Cacheable("calculate_simple")
	public ArmOutputObject calculateARM(
			@RequestParam(value="amount",defaultValue="200000") double amount,
			@RequestParam(value="down",defaultValue="20000") double down,
			@RequestParam(value="term",defaultValue="5") int term,
			@RequestParam(value="isARM") boolean isARM,
			@RequestParam(value="initPeriod") int initPeriod,
			@RequestParam(value="addtionPay") double addtionPay,
			@RequestParam(value="additionMonth") int additionMonth,
			@RequestParam(value="credit") int credit){

		double percent=1;
		switch(credit){
		case 1:percent=1.10;
		break;
		case 2:percent=1;
		break;
		case 3:percent=0.95;
		break;
		case 4:percent=0.9;
		default:
		}
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(amount+" "+down+" "+term+" "+isARM+" "+initPeriod+" "+addtionPay+" "+additionMonth);
		
		ArmOutputObject result = ms.calculateARM(amount, down, term,addtionPay,additionMonth,initPeriod,percent);
		return result;
	}
}
