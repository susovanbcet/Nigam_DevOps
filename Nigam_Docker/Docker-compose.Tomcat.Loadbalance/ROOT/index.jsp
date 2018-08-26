<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.net.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
      <FONT size = 4 COLOR="#0000FF">
        <h5> </h5>
        <h3> Server Info from TomcatServer1 : </h3>
        Serving from: <FONT COLOR="red"> <%=InetAddress.getLocalHost()%></FONT><br/>
        Server Running: <b>'<%=System.getProperty("os.name")%>'</b> Operating System<br/>
        Server Container By: <b><%=getServletConfig().getServletContext().getServerInfo()%> </b> <br/>
        Server Java Version: <b> <%= System.getProperty("java.version") %> </b> <br/>
        Server JSP Version: <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %> <br/>
        Server Servlet Version: <%=session.getServletContext().getMajorVersion()%>.<%=session.getServletContext().getMinorVersion() %> <br/>

        User principal: <%=request.getLocale()%><br>
        WebServer/Cluster Name: <FONT COLOR="black"> <%=request.getServerName()%> </FONT> <br>
        WebServer/Cluster Port: <%=request.getServerPort()%><br>
        <h3> JAVA Details: </h3>
        java.version: <b>'<%=System.getProperty("java.version")%>'</b><br/>
        java.vendor: <b>'<%=System.getProperty("java.vendor")%>'</b><br/>
        java.vendor.url: <b>'<%=System.getProperty("java.vendor.url")%>'</b><br/>
        java.home: <b>'<%=System.getProperty("java.home")%>'</b><br/>
        java.class.path: <b>'<%=System.getProperty("java.class.path")%>'</b><br/>


        <h3> User Info: </h3>
        user.name: <b>'<%=System.getProperty("user.name")%>'</b><br/>
        user.home: <b>'<%=System.getProperty("user.home")%>'</b><br/>

        <h3> OS Info: </h3>
        os.arch: <b>'<%=System.getProperty("os.arch")%>'</b><br/>
        os.version: <b>'<%=System.getProperty("os.version")%>'</b><br/>

      </FONT>
        <hr/>
        <FONT size = 6 COLOR="#CC0000">
        <br/>
        Session Id: <%=request.getSession().getId()%> <br/>
        Is it New Session: <%=request.getSession().isNew()%><br/>
        Session Creation Date: <%=new Date(request.getSession().getCreationTime())%><br/>
        Session Access Date: <%=new Date(request.getSession().getLastAccessedTime())%><br/><br/>
        </FONT>
        <b>Cart List </b><br/>
        <hr/>

        <ul>
        <%
              String bookName = request.getParameter("bookName");
              List<String> listOfBooks = (List<String>) request.getSession().getAttribute("Books");
              if (listOfBooks == null) {
                  listOfBooks = new ArrayList<String>();
                  request.getSession().setAttribute("Books", listOfBooks);
              }
              if (bookName != null) {
                  listOfBooks.add(bookName);
		              request.getSession().setAttribute("Books", listOfBooks);
              }
              for (String book : listOfBooks) {
                  out.println("<li>"+book + "</li><br/>");
              }
        %>
        </ul>
        <hr/>
        <form action="index.jsp" method="post">
            Book Name <input type="text" name="bookName" />
            <input type="submit" value="Add to Cart"/>
        </form>
        <hr/>
    </body>
</html>
