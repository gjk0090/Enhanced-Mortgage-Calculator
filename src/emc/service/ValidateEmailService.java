package emc.service;

import javax.xml.soap.*;

public class ValidateEmailService {
	public String validateEmail(String emailAddr) {
		String validCode = "9"; //3 for valid
		try {
			// Create SOAP Message
			SOAPConnectionFactory soapConnectionFactory = SOAPConnectionFactory.newInstance();
			SOAPConnection soapConnection = soapConnectionFactory.createConnection();
			
			// Send SOAP Message to SOAP Server
			String url = "http://ws.cdyne.com/emailverify/Emailvernotestemail.asmx";
			SOAPMessage soapResponse = soapConnection.call(createSOAPRequest(emailAddr), url);
			soapConnection.close();
			Node response = (Node) soapResponse.getSOAPBody().getFirstChild().getFirstChild().getFirstChild();
			validCode = response.getNextSibling().getTextContent();
			System.out.println(response.getNodeName() +": " + response.getTextContent() + ", " + response.getNextSibling().getNodeName() +": " + response.getNextSibling().getTextContent());
		} catch (Exception e) {
			System.out.println("Error occurred while sending SOAP Request to Server");
			e.printStackTrace();
		}
		return validCode;
	}
	public static void main(String[] args) {
		ValidateEmailService s =  new ValidateEmailService();
		System.out.println(s.validateEmail("xiangke.cao@gmail.com"));
	}
	
	private static SOAPMessage createSOAPRequest(String emailAddr) throws Exception {
		MessageFactory messageFactory = MessageFactory.newInstance();
		SOAPMessage soapMessage = messageFactory.createMessage();
		SOAPPart soapPart = soapMessage.getSOAPPart();
		
		String serverURI = "http://ws.cdyne.com/";
		
		// SOAP Envelop
		SOAPEnvelope envelope = soapPart.getEnvelope();
		envelope.addNamespaceDeclaration("example", serverURI);
		
		/*
		Constructed SOAP Request Message
		<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
			xmlns:example="http://ws.cdyne.com/">
			<SOAP-ENV:Header>
			<SOAP-ENV:Body>
				<example:VerifyEmail>
					<example:email>mutantninja@gmail.com</example:email>
					<example:LicenseKey>123</example:LicenseKey>
				</example:VerifyEmail>
			</SOAP-ENV:Body>
		</SOAP-ENV:Envelope>
		*/
		
		// SOAP Body
		SOAPBody soapBody = envelope.getBody();
		SOAPElement soapBodyElem = soapBody.addChildElement("VerifyEmail", "example");
		SOAPElement soapBodyElem1 = soapBody.addChildElement("email", "example");
		soapBodyElem1.addTextNode(emailAddr);
		SOAPElement soapBodyElem2 = soapBody.addChildElement("LicenseKey", "example");
		soapBodyElem2.addTextNode("123456789");
		soapBodyElem.addChildElement(soapBodyElem1);
		soapBodyElem.addChildElement(soapBodyElem2);
		
		MimeHeaders headers = soapMessage.getMimeHeaders();
		headers.addHeader("SOAPAction", serverURI + "VerifyEmail");
		
		soapMessage.saveChanges();
		
/*		// Print the request message 
		System.out.println("Request SOAP Message = ");
		soapMessage.writeTo(System.out);
		System.out.println();*/
		
		return soapMessage;
	}
	
/*	private static void printSOAPResponse(SOAPMessage soapMessage) throws Exception {
		TransformerFactory transformerFactory = TransformerFactory.newInstance();
		Transformer transformer = transformerFactory.newTransformer();
		Source sourceContent = soapMessage.getSOAPPart().getContent();
		System.out.println("\nResponse SOAP Message = ");
		StreamResult result = new StreamResult(System.out);
		transformer.transform(sourceContent, result);
		Node x = (Node) soapMessage.getSOAPBody().getFirstChild().getFirstChild();
		System.out.println("\n" + x.getFirstChild().getNextSibling().getNodeName());
		System.out.println(x.getFirstChild().getNextSibling().getTextContent());
	}*/	
}
/*	private static void printSOAPResponse(SOAPMessage soapMessage) throws Exception {
		//TransformerFactory transformerFactory = TransformerFactory.newInstance();
		//Transformer transformer = transformerFactory.newTransformer();
		//Source sourceContent = soapMessage.getSOAPPart().getContent();
		System.out.println("\nResponse SOAP Message = ");
		SOAPBody sb = soapMessage.getSOAPBody();
		String x = sb.getAttribute("ResponseCode");
		System.out.println("*********");
		System.out.println(x);
		System.out.println("*********");
		java.util.Iterator iterator = sb.getAllAttributes();
		while (iterator.hasNext()) {
	        SOAPBodyElement bodyElement = (SOAPBodyElement) iterator.next();
	        String val = bodyElement.getValue();
	        System.out.println("The Value is:" + val);
	      }
		System.out.println("*********");
		System.out.println(sb.getAttribute("VerifyEmailResponse"));
	
		System.out.println(sourceContent);
		StreamResult result = new StreamResult(System.out);
		transformer.transform(sourceContent, result);
		
		//String x = (String) transformer.getParameter("ResponseCode");
		//Properties x = transformer.getOutputProperties();
		//System.out.println(x);
	}
}*/