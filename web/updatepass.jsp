<%-- 
    Document   : updatepass
    Created on : 15 Jan, 2021, 2:08:23 AM
    Author     : Yash
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
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
                            String cp=request.getParameter("cp");
                            String np=request.getParameter("np");
                             String rp=request.getParameter("rp");
                             if(np.equals(rp)){
                                  Class.forName("com.mysql.jdbc.Driver");
                                 Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/wedding","root","");
                                   Statement st=cn.createStatement();
			ResultSet rs=st.executeQuery("select * from users where email='"+email+"'");
                           if(rs.next()){
                               
			if(rs.getString("pass").equals(cp)){
		
	  PreparedStatement ps=cn.prepareStatement("update users set pass=? where email=?");
              ps.setString(1,np); 
                              ps.setString(2,email);
                                        
                                if(ps.executeUpdate()>0){
                                    response.sendRedirect("Profile?succ=1");
                                }
                                else{
                                    response.sendRedirect("Profile?err=1");
                                }
         
					
				}
				else{
					 response.sendRedirect("profile.jsp?invalidcurrentpass=1");
				}
			}
			else{
					 response.sendRedirect("logout.jsp");
				}
                           cn.close();
		}
                             else{
				 response.sendRedirect("changepass?Typecorrectvalue=1");;
			}
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

