<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.medicalims.model.InventoryItem" %>
<%@ page import="com.medicalims.model.User" %>
<%@ page import="com.medicalims.model.Admin" %>

<%
    User user = (User) session.getAttribute("user");
    Admin admin = (Admin) session.getAttribute("admin");

    if (user == null && admin == null) {
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MedIMS Inventory</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <style>
        .inventory-page {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .topbar-links {
            display: flex;
            gap: 15px;
        }

        .topbar-links a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 18px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.2s ease, color 0.2s ease, transform 0.2s ease;
        }

        .topbar-links .primary-btn {
            background-color: #0f766e;
            color: #ffffff;
            border: 1px solid #0f766e;
        }

        .topbar-links .primary-btn:hover {
            background-color: #0b5e57;
            border-color: #0b5e57;
            transform: translateY(-1px);
        }

        .topbar-links .secondary-btn {
            background-color: #ffffff;
            color: #0f766e;
            border: 1px solid #cbd5e1;
        }

        .topbar-links .secondary-btn:hover {
            background-color: #f8fafc;
            border-color: #94a3b8;
            transform: translateY(-1px);
        }

        .search-form,
        .filter-form {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 15px;
        }

        .search-form input[type="text"],
        .filter-form select,
        .filter-form input[type="text"] {
            padding: 8px;
            font-size: 14px;
        }

        .search-form input[type="text"] {
            min-width: 320px;
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

        .no-data {
            text-align: center;
            padding: 20px;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
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
    <main class="main" style="margin-left: 0;">
        <div class="inventory-page">
            <div class="topbar">
                <div>
                    <h1>Inventory</h1>
                    <p>View available medical inventory and withdraw items.</p>
                </div>

                <div class="topbar-links">
                    <% if (admin != null) { %>
                        <a href="<%= request.getContextPath() %>/admin-dashboard" class="primary-btn">Dashboard</a>
                    <% } else { %>
                        <a href="<%= request.getContextPath() %>/user-dashboard" class="primary-btn">Dashboard</a>
                    <% } %>
                    <a href="${pageContext.request.contextPath}/logout" class="secondary-btn">Logout</a>
                </div>
            </div>

            <div class="card" style="margin-top: 20px;">
                <div class="toolbar">
                    <form action="inventory" method="post" class="search-form">
                        <input type="text" name="search"
                               placeholder="Search by item name, item ref #, or category name"
                               value="<%= search %>">
                        <button type="submit">Search</button>
                        <a href="inventory">Reset</a>
                    </form>

                    <form action="inventory" method="post" class="filter-form">
                        <select name="filterType" id="filterType" onchange="updateFilterOptions()">
                            <option value="">Select Filter</option>
                            <option value="location" <%= "location".equals(filterType) ? "selected" : "" %>>By Location</option>
                            <option value="lot" <%= "lot".equals(filterType) ? "selected" : "" %>>By Lot Number</option>
                            <option value="expiration" <%= "expiration".equals(filterType) ? "selected" : "" %>>Nearest Expiration Date</option>
                            <option value="lowStock" <%= "lowStock".equals(filterType) ? "selected" : "" %>>Low Stock</option>
                        </select>

                        <span id="filterValueContainer"></span>

                        <button type="submit">Apply Filter</button>
                        <a href="inventory">Reset</a>
                    </form>
                </div>

                <% if (errorMessage != null) { %>
                    <div class="error"><%= errorMessage %></div>
                <% } %>

                <div class="table-wrap">
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
                                    <tr data-row-index="<%= i %>" onclick="toggleRow(this.dataset.rowIndex)" style="cursor:pointer;">
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
                </div>
            </div>
        </div>
    </main>
</body>
</html>