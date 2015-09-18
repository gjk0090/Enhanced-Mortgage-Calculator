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
@Path("/ad/")
public class AdResource {
	
	private AdDao add = (AdDao) SpringContext.getBean("adDao");
	
	@GET
	@Path("get_all_ad")
	@Produces({MediaType.APPLICATION_JSON})
	public List<Ad> getAllAd() {
		
		return add.queryAll();
	}

}
