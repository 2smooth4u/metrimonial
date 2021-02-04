<%-- 
    Document   : check.jsp
    Created on : 15 Jan, 2021, 12:43:05 AM
    Author     : Yash
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
           String email=null;
           String pass=null;
           Cookie c[]=request.getCookies();
          
            for(int i=0;i<c.length;i++){
                if(c[i].getName().equals("users")){
                    email=c[i].getValue();
                    break;
                }
                }
            if(email==null){
                if(request.getParameter("email").trim().length()>0){
                    email=request.getParameter("email").trim();
                }
                else{
                    response.sendRedirect("index.jsp?null");
                }
            }
            if(request.getParameter("pass").trim().length()==0){
                response.sendRedirect("index.jsp?passnull");
            }
            else{
           
    try{
                pass=request.getParameter("pass");
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/wedding","root","");
                Statement st=cn.createStatement();
               
               
               ResultSet rs= st.executeQuery("select * from users where email='"+email+"'");
               if(rs.next()){
                   if(rs.getString("pass").equals(pass)){
                       Cookie ct = new Cookie("users",email);
                       ct.setMaxAge(3660);
                       response.addCookie(ct);
                       
                       session.setAttribute(email,pass);
                       session.setMaxInactiveInterval(2000);
                       
                       response.sendRedirect("profile.jsp");
                   }
                   else{
                       response.sendRedirect("login.jsp?invalid_pass=1");
                   }
               }
               else{
                   response.sendRedirect("login.jsp?invalid_email=1");
               }
               cn.close();
               }
               catch(Exception e){
    out.println(e.getMessage());
    }
            }
%>
