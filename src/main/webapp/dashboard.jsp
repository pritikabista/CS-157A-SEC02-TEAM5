<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
    <h1>Welcome, <%= username %>!</h1>
    <p>Role: <%= role %></p>

    <ul>
        <li><a href="inventory">View Inventory</a></li>
        <li><a href="purchaseOrders.jsp">Purchase Orders</a></li>
        <li><a href="logout.jsp">Logout</a></li>
    </ul>
</body>
</html>