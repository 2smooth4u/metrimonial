<%-- 
    Document   : update
    Created on : 15 Jan, 2021, 1:38:11 AM
    Author     : Yash
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%

     try  {
            Cookie c[]=request.getCookies();
            String email=null;
            for(int i=0;i<c.length;i++){
                if(c[i].getName().equals("users")){
                    email=c[i].getValue();
                    break;
                }
                }
            if(email!=null && session.getAttribute(email)!=null){
      
    try{    
        
                           String fname=request.getParameter("fname");
                             String lname=request.getParameter("lname");
                             int day=Integer.parseInt(request.getParameter("day"));
                             int month=Integer.parseInt(request.getParameter("month"));
                            int year=Integer.parseInt(request.getParameter("year"));
                             String caste=request.getParameter("caste");
                                String religion=request.getParameter("religion");
                                 Class.forName("com.mysql.jdbc.Driver");
                               Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/wedding","root","");
                                 PreparedStatement ps=cn.prepareStatement("update users set fname=? ,lname=? ,day=? ,month=? ,year=? ,caste=? ,religion=? where email=?");
                            ps.setString(1,fname);
                                  ps.setString(2,lname);
                                    ps.setInt(3,day);
                                  ps.setInt(4,month);
                                    ps.setInt(5,year);
                                   ps.setString(6,caste);
                                ps.setString(7,religion);
                                ps.setString(8,email);
                                   
                              
                                if(ps.executeUpdate()>0){
                                    response.sendRedirect("profile.jsp?succ=1");
                                }
                                else{
                                    response.sendRedirect("edit_email.jsp?err=1");
                                }
                                 cn.close();
     }
    catch(Exception e){
    out.println(e.getMessage());
    }
      }
            else{
                response.sendRedirect("index.jsp");
            }
        }
             catch(Exception e){
            out.println(e.getMessage());
        }    
%>
