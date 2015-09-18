package emc.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class MyAuthenticationFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest arg0,
			HttpServletResponse arg1, AuthenticationException arg2)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpSession session = arg0.getSession(false);
		session.setAttribute("input_name", arg0.getParameter("j_username"));
		session.setAttribute("input_pass", arg0.getParameter("j_password"));
		arg1.sendRedirect("login.html?login_error=1");
		
	}

}
