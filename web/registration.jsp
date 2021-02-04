<%-- 
    Document   : registration
    Created on : 10 Jan, 2021, 11:52:44 AM
    Author     : Yash
--%>

<%@page contentType="text/html" import="java.util.*,java.sql.*"  pageEncoding="UTF-8"%>
<%
      try{    
        int sn=0;
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/wedding","root","");
                Statement st=cn.createStatement();
                ResultSet rs= st.executeQuery("select  * from users");
                  while(rs.next()){
                sn=rs.getInt(1);
                  }
                  sn++;
                
                  

                  
                                 ArrayList l=new ArrayList();
                                    for(char c='A';c<='Z';c++){
                                 l.add(c+"");
                                 }
                             for(char c='a';c<='z';c++){
                                    l.add(c+"");
                                  }
                         for(int i=0;i<=9;i++){
                          l.add(i+"");
                                 }
                    Collections.shuffle(l);
                         String code="";
                        for(int c=0;c<6;c++){
                             code=code+l.get(c);
                                 }
                          code=code+"_"+sn; 
                           out.println(code);
                            String fname=request.getParameter("fname");
                             String lname=request.getParameter("lname");
                              String email=request.getParameter("email");
                               String pass=request.getParameter("pass");
                             int day=Integer.parseInt(request.getParameter("day"));
                             int month=Integer.parseInt(request.getParameter("month"));
                            int year=Integer.parseInt(request.getParameter("year"));
                             String gender=request.getParameter("gender");
                              String city=request.getParameter("city");
                               String caste=request.getParameter("caste");
                                String religion=request.getParameter("religion");
                                 Class.forName("com.mysql.jdbc.Driver");
                                 Connection cn1=DriverManager.getConnection("jdbc:mysql://localhost:3306/wedding","root","");
                                PreparedStatement ps=cn1.prepareStatement("insert into users values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
                                ps.setInt(1,sn);
                                 ps.setString(2,code);
                                ps.setString(3,fname);
                                  ps.setString(4,lname);
                                   ps.setString(5,email);
                                    ps.setString(6,pass);
                                ps.setInt(7,day);
                                  ps.setInt(8,month);
                                    ps.setInt(9,year);
                                ps.setString(10,gender);
                                ps.setString(11,city);
                                ps.setString(12,caste);
                                ps.setString(13,religion);
                                   
                             
                                if(ps.executeUpdate()>0){
                                    response.sendRedirect("login.jsp?succ=1");
                                }
                                else{
                                    response.sendRedirect("login.jsp?err=1");
                                }
                                 cn.close();
     }
    catch(Exception e){
    out.println(e.getMessage());
    }

%>
