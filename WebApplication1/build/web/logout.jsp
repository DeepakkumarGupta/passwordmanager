<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Invalidate the current session (log out the user)
    HttpSession userSession = request.getSession(false);
    if (session != null) {
        session.invalidate();
    }

    // Redirect to the login page
    response.sendRedirect("login.jsp");
%>
