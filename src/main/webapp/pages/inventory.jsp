<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.medicalims.model.Inventory" %>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String search = (String) request.getAttribute("search");
    if (search == null) {
        search = "";
    }

    List<Inventory> inventoryList =
            (List<Inventory>) request.getAttribute("inventoryList");

    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Inventory</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f8f9fa;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        h1 {
            margin: 0;
        }

        .back-link {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        .search-box {
            margin-bottom: 20px;
        }

        .search-box input[type="text"] {
            width: 320px;
            padding: 8px;
            font-size: 14px;
        }

        .search-box button {
            padding: 8px 12px;
            font-size: 14px;
            cursor: pointer;
        }

        .search-box a {
            margin-left: 10px;
            text-decoration: none;
            color: #007bff;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #343a40;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .no-data {
            text-align: center;
            padding: 20px;
        }
    </style>
</head>
<body>

    <div class="top-bar">
        <h1>Inventory</h1>
        <a class="back-link" href="dashboard.jsp">Back to Dashboard</a>
    </div>

    <div class="search-box">
        <form action="inventory" method="get">
            <input type="text" name="search"
                   placeholder="Search by item name, item ref #, lot #, or category"
                   value="<%= search %>">
            <button type="submit">Search</button>
            <a href="inventory">Reset</a>
        </form>
    </div>

    <% if (errorMessage != null) { %>
        <div class="error"><%= errorMessage %></div>
    <% } %>

    <table>
        <thead>
            <tr>
                <th>Item Ref #</th>
                <th>Item Name</th>
                <th>Category</th>
                <th>Lot #</th>
                <th>Expiration Date</th>
                <th>Quantity</th>
                <th>Location ID</th>
            </tr>
        </thead>
        <tbody>
            <% if (inventoryList != null && !inventoryList.isEmpty()) { %>
                <% for (Inventory item : inventoryList) { %>
                    <tr>
                        <td><%= item.getItemReferenceNumber() %></td>
                        <td><%= item.getItemName() %></td>
                        <td><%= item.getCategoryName() != null ? item.getCategoryName() : "" %></td>
                        <td><%= item.getLotNumber() != null ? item.getLotNumber() : "" %></td>
                        <td><%= item.getExpirationDate() != null ? item.getExpirationDate() : "" %></td>
                        <td><%= item.getQuantity() %></td>
                        <td><%= item.getLocationID() %></td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="7" class="no-data">No inventory items found.</td>
                </tr>
            <% } %>
        </tbody>
    </table>

</body>
</html>