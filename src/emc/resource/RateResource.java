package emc.resource;
import java.util.List;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import emc.context.SpringContext;
import emc.dao.*;
import emc.beans.*;

@Path("/")
public class RateResource {
	
	private RateDao rd = (RateDao) SpringContext.getBean("rateDao");;
	
	@GET
	@Path("get_rate/{term}")
	@Produces({MediaType.APPLICATION_JSON})
	public Rate execute(@PathParam("term") int term) {
		Rate rate = rd.getRateByTerm(term);
		return rate;
	}
	
	@GET
	@Path("get_all_rate")
	@Produces({MediaType.APPLICATION_JSON})
	public List<Rate> getAllRate() {
		
		return rd.queryAll();
	}
	
	@GET
	@Path("edit_rate/{term}:{rate}:{min}")
	@Produces({MediaType.APPLICATION_JSON})
	public int editRate(@PathParam("term") int term,@PathParam("rate") double rate,@PathParam("min") int min) {
		System.out.println(term+" "+rate+" "+min);
		Rate newRate=new Rate();
		newRate.setMin(min);
		newRate.setRate(rate);
		newRate.setTerm(term);
		rd.updateRate(newRate);
		return 1;
	}
}
