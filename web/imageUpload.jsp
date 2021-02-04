<%-- 
    Document   : imageUpload
    Created on : 30 Jan, 2021, 3:56:35 AM
    Author     : Yash
--%>

<%@page contentType="text/html" import="java.util.*,java.sql.*,java.io.FileOutputStream,java.io.FileInputStream,java.io.*" pageEncoding="UTF-8"%>

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
               String code="";
                try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/wedding","root","");
                Statement st=cn.createStatement();
                ResultSet rs= st.executeQuery("select code from users where email='"+email+"'");
				if(rs.next()){
				code=rs.getString(1);
				}
				cn.close();
				}
				catch(Exception e){
            out.println(e.getMessage());
        }
		String contentType = request.getContentType();
		String imageSave =null;
		String saveFile=null;
		if((contentType!=null) && (contentType.indexOf("multipath/form-data") >=0)){
		DataInputStream in = new DataInputStream(request.getInputStream());
		int formDataLength=request.getContentLength();
		byte dataBytes[] = new byte[formDataLength];
		int byteRead=0;
		int totalBytesRead=0;
		while(totalBytesRead<formDataLength){
		byteRead = in.read(dataBytes,totalBytesRead,formDataLength);
		totalBytesRead +=  byteRead;
		}
		String file = new String(dataBytes);
		saveFile=code+".jpg";
		int lastIndex=contentType.lastIndexOf("-");
		String boundary = contentType.substring(lastIndex+1,contentType.length());
                int pos;
pos=file.indexOf("filename=\"");
pos=file.indexOf("\n",pos)+1;
pos=file.indexOf("\n",pos)+1;
pos=file.indexOf("\n",pos)+1;
int boundaryLocation= file.indexOf(boundary,pos)-4;
int startPos= (file.substring(0,pos).getBytes()).length;
int endPos= (file.substring(0,boundaryLocation).getBytes()).length;
try{
FileOutputStream fileOut=new FileOutputStream(request.getRealPath("/")+"/profile/"+saveFile);
fileOut.write(dataBytes,startPos,(endPos-startPos));
fileOut.flush();
fileOut.close();
imageSave="Success";
}
catch(Exception e){
imageSave="Failure";
}
}

response.sendRedirect("profile.jsp?uploaded");
}
else{
response.sendRedirect("login.jsp");
}
}
     catch(Exception e){
            out.println(e.getMessage());
        }  

%>