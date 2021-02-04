<%-- 
    Document   : logout
    Created on : 15 Jan, 2021, 2:20:55 AM
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
            session.removeAttribute(email);
            response.sendRedirect("index.jsp?logout=1");
            %>
