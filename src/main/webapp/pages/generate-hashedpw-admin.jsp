<%@ page import="com.medicalims.util.HashPw" %>

<%
    String hash = HashPw.hashedPwd("admin3");
    out.println(hash);
%>