<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.onelogin.*,com.onelogin.saml.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SAML Assertion Page</title>
</head>
<body>
<%
  String cert =
       "MIICQDCCAakCBEeNB0swDQYJKoZIhvcNAQEEBQAwZzELMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNh"+
       "bGlmb3JuaWExFDASBgNVBAcTC1NhbnRhIENsYXJhMQwwCgYDVQQKEwNTdW4xEDAOBgNVBAsTB09w"+
       "ZW5TU08xDTALBgNVBAMTBHRlc3QwHhcNMDgwMTE1MTkxOTM5WhcNMTgwMTEyMTkxOTM5WjBnMQsw"+
       "CQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTEUMBIGA1UEBxMLU2FudGEgQ2xhcmExDDAK"+
       "BgNVBAoTA1N1bjEQMA4GA1UECxMHT3BlblNTTzENMAsGA1UEAxMEdGVzdDCBnzANBgkqhkiG9w0B"+
       "AQEFAAOBjQAwgYkCgYEArSQc/U75GB2AtKhbGS5piiLkmJzqEsp64rDxbMJ+xDrye0EN/q1U5Of+"+
       "RkDsaN/igkAvV1cuXEgTL6RlafFPcUX7QxDhZBhsYF9pbwtMzi4A4su9hnxIhURebGEmxKW9qJNY"+
       "Js0Vo5+IgjxuEWnjnnVgHTs1+mq5QYTA7E6ZyL8CAwEAATANBgkqhkiG9w0BAQQFAAOBgQB3Pw/U"+
       "QzPKTPTYi9upbFXlrAKMwtFf2OW4yvGWWvlcwcNSZJmTJ8ARvVYOMEVNbsT4OFcfu2/PeYoAdiDA"+
       "cGy/F2Zuj8XJJpuQRSE6PtQqBuDEHjjmOQJ0rV/r8mO1ZCtHRhpZ5zYRjhRC9eCbjx9VrFax0JDC"+
       "/FfwWigmrW0Y0Q==";

  // user account specific settings. Import the certificate here
  AccountSettings accountSettings = new AccountSettings();
  accountSettings.setCertificate(cert);

  Response samlResponse = new Response(accountSettings);
  samlResponse.loadXmlFromBase64(request.getParameter("SAMLResponse"));
  samlResponse.setDestinationUrl(request.getRequestURL().toString()); 

  if (samlResponse.isValid()) {

    // the signature of the SAML Response is valid. The source is trusted
  	java.io.PrintWriter writer = response.getWriter();
  	writer.write("OK!");
  	String nameId = samlResponse.getNameId();
  	writer.write(nameId);
  	writer.flush();
	
  } else {

    // the signature of the SAML Response is not valid
  	java.io.PrintWriter writer = response.getWriter();
  	writer.write("Failed");
  	writer.flush();

  }
%>
</body>
</html>