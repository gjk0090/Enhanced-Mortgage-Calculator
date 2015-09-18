package emc.resource;

import javax.ws.rs.POST;
import javax.ws.rs.Path;

import emc.service.ValidateEmailService;


@Path("/validate_email")
public class ValidateEmail {
	ValidateEmailService ves = new ValidateEmailService();
	
	@POST
	public String postUserLog(String emailAddr) {
		System.out.println("validate email request (POST) received, address: " + emailAddr);
		return ves.validateEmail(emailAddr);
	}
}
