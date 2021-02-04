<%-- 
    Document   : logout1
    Created on : 15 Jan, 2021, 2:22:10 AM
    Author     : Yash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
   Cookie c[]=request.getCookies();
            String email=null;
            for(int i=0;i<c.length;i++){
                if(c[i].getName().equals("users")){
                    email=c[i].getValue();
                    break;
                }
                }
             Cookie ct = new Cookie("users",null);
                       ct.setMaxAge(0);
                       response.addCookie(ct);
                       session.removeAttribute(email);
                       response.sendRedirect("login.jsp?newuser");
%>