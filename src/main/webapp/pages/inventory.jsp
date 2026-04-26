<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.medicalims.model.InventoryItem" %>
<%@ page import="com.medicalims.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        return;
    }

    String search = (String) request.getAttribute("search");
    if (search == null) {
        search = "";
    }

    String filterType = (String) request.getAttribute("filterType");
    if (filterType == null) {
        filterType = "";
    }

    String filterValue = (String) request.getAttribute("filterValue");
    if (filterValue == null) {
        filterValue = "";
    }

    List<InventoryItem> inventoryItems =
            (List<InventoryItem>) request.getAttribute("inventoryItems");

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

        .filter-box {
            margin-bottom: 20px;
        }

        .filter-box select {
            padding: 8px;
            font-size: 14px;
            margin-right: 10px;
        }

        .filter-box input[type="text"] {
            padding: 8px;
            font-size: 14px;
            margin-right: 10px;
        }

        .filter-box button {
            padding: 8px 12px;
            font-size: 14px;
            cursor: pointer;
        }

        .filter-box a {
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

        .expandable-row {
            display: none;
            background-color: #eef3f7;
        }

        .expandable-content {
            padding: 18px 12px;
            min-height: 70px;
        }

        .expandable-content input[type="number"] {
            padding: 6px;
            margin-left: 8px;
            margin-right: 10px;
            width: 80px;
        }

        .expandable-content button {
            padding: 6px 10px;
            cursor: pointer;
        }
    </style>

    <script>
        function updateFilterOptions() {
            const filterType = document.getElementById("filterType").value;
            const container = document.getElementById("filterValueContainer");
            const savedFilterValue = "<%= filterValue %>";

            if (filterType === "location") {
                container.innerHTML =
                    '<select name="filterValue" id="filterValue">' +
                    '<option value="">Select Location</option>' +
                    '<option value="1">B1-R101</option>' +
                    '<option value="2">B1-R102</option>' +
                    '<option value="3">B1-R103</option>' +
                    '<option value="4">B2-R201</option>' +
                    '<option value="5">B2-R202</option>' +
                    '<option value="6">B2-R203</option>' +
                    '<option value="7">B3-R301</option>' +
                    '<option value="8">B3-R302</option>' +
                    '<option value="9">B3-R303</option>' +
                    '<option value="10">B1-R100</option>' +
                    '</select>';

                document.getElementById("filterValue").value = savedFilterValue;
            } 
            else if (filterType === "lot") {
                container.innerHTML =
                    '<input type="text" name="filterValue" placeholder="Enter Lot Number" value="' + savedFilterValue + '">';
            } 
            else {
                container.innerHTML = '';
            }
        }

        function toggleRow(index) {
            const row = document.getElementById("expand-" + index);
            if (row.style.display === "table-row") {
                row.style.display = "none";
            } else {
                row.style.display = "table-row";
            }
        }

        window.onload = function() {
            updateFilterOptions();
        };
    </script>
</head>
<body>

    <div class="top-bar">
        <h1>Inventory</h1>
        <a class="back-link" href="<%= request.getContextPath() %>/user-dashboard">Back to Dashboard</a>
    </div>

    <div class="search-box">
        <form action="inventory" method="post">
            <input type="text" name="search"
                   placeholder="Search by item name, item ref #, or category name"
                   value="<%= search %>">
            <button type="submit">Search</button>
            <a href="inventory">Reset</a>
        </form>
    </div>

    <div class="filter-box">
        <form action="inventory" method="post">
            <select name="filterType" id="filterType" onchange="updateFilterOptions()">
                <option value="">Select Filter</option>
                <option value="location" <%= "location".equals(filterType) ? "selected" : "" %>>By Location</option>
                <option value="lot" <%= "lot".equals(filterType) ? "selected" : "" %>>By Lot Number</option>
                <option value="expiration" <%= "expiration".equals(filterType) ? "selected" : "" %>>Nearest Expiration Date</option>
            </select>

            <span id="filterValueContainer"></span>

            <button type="submit">Apply Filter</button>
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
                <th>Location</th>
            </tr>
        </thead>
        <tbody>
            <% if (inventoryItems != null && !inventoryItems.isEmpty()) { %>
                <% int i = 0; %>
                <% for (InventoryItem item : inventoryItems) { %>
                    <tr data-row-index="<%= i %>" onclick="toggleRow( this.dataset.rowIndex )" style="cursor:pointer;">
                        <td><%= item.getItemReferenceNumber() %></td>
                        <td><%= item.getItemName() %></td>
                        <td><%= item.getCategoryName() %></td>
                        <td><%= item.getLotNumber() %></td>
                        <td><%= item.getExpirationDate() != null ? item.getExpirationDate() : "" %></td>
                        <td><%= item.getStock() %></td>
                        <td><%= item.getLocation() %></td>
                    </tr>

                    <tr id="expand-<%= i %>" class="expandable-row">
                        <td colspan="7">
                            <div class="expandable-content">
                                <form action="inventory" method="post">
                                    <input type="hidden" name="action" value="withdraw">
                                    <input type="hidden" name="itemReferenceNumber" value="<%= item.getItemReferenceNumber() %>">
                                    <input type="hidden" name="locationID" value="<%= item.getLocationID() %>">

                                    Withdraw Qty:
                                    <input type="number" name="qty" min="1" required>

                                    <button type="submit">Withdraw</button>
                                </form>
                            </div>
                        </td>
                    </tr>

                    <% i++; %>
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