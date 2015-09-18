package emc.service;

import java.util.Properties;
import java.util.Date;

import javax.activation.*;
import javax.mail.*;                  // Include Authenticator, Message, PasswordAuthentication, Session, Transport
import javax.mail.internet.*;     // Include InternetAddress, MimeMessage

public class JavaMailService {
	
	public void sendEmail(String address,String title, String content) {
        final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";  
        Properties prop = System.getProperties();
        prop.setProperty("mail.smtp.host", "smtp.gmail.com");   
        prop.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);   
        prop.setProperty("mail.smtp.socketFactory.fallback", "false");   
        prop.setProperty("mail.smtp.port", "465");   
        prop.setProperty("mail.smtp.socketFactory.port", "465");   
        prop.put("mail.smtp.auth", "true");   
        final String user = "javamailtestgjk@gmail.com";
        final String password = "javamailtest";
        
        Session session = Session.getDefaultInstance(prop, new Authenticator() {
        	@Override
            protected PasswordAuthentication getPasswordAuthentication() { 
            	return new PasswordAuthentication(user, password); 		
            } 
        });
        
        try {		
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(user));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(address));
            msg.setSubject(title); 
            msg.setSentDate(new Date());
            msg.setText("Hello!"); //not working
            
            Multipart multipart = new MimeMultipart();   
            
            //input content
            BodyPart contentPart = new MimeBodyPart();   
            contentPart.setText(content);   
            multipart. addBodyPart(contentPart);   
            
            //add attachment
            //BodyPart attachmentPart= new MimeBodyPart();   
            //DataSource source = new FileDataSource("status_20140613.doc");   
            //attachmentPart.setDataHandler(new DataHandler(source));   
            //attachmentPart.setFileName("status_20140613.doc");
            //multipart.addBodyPart(attachmentPart);   
               
            
            msg.setContent(multipart);  
            
            Transport.send(msg);
            
            System.out.println("Message sent successfully!");
        } catch (Exception e) { System.out.println(e); }
    }
}
