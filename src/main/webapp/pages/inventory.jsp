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
    if (search == null) search = "";

    String filterType = (String) request.getAttribute("filterType");
    if (filterType == null) filterType = "";

    String filterValue = (String) request.getAttribute("filterValue");
    if (filterValue == null) filterValue = "";

    List<InventoryItem> inventoryItems =
            (List<InventoryItem>) request.getAttribute("inventoryItems");

    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MedIMS Inventory</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
</head>

<body>
<main class="main" style="margin-left: 0;">
    <div class="inventory-page">

        <div class="topbar">
            <h1>Inventory</h1>

            <div>
                <% if (admin != null) { %>
                    <a href="${pageContext.request.contextPath}/admin-dashboard">Dashboard</a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/user-dashboard">Dashboard</a>
                <% } %>

                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>

        <div class="card">

            <form action="${pageContext.request.contextPath}/inventory" method="post" class="toolbar">
                <input type="text" name="search" value="<%= search %>" placeholder="Search inventory...">
                <button type="submit">Search</button>
                <a href="${pageContext.request.contextPath}/inventory" class="gray-btn">Reset</a>
            </form>

            <form action="${pageContext.request.contextPath}/inventory" method="post" class="toolbar">
                <select name="filterType">
                    <option value="">Select Filter</option>
                    <option value="location" <%= "location".equals(filterType) ? "selected" : "" %>>Location</option>
                    <option value="lot" <%= "lot".equals(filterType) ? "selected" : "" %>>Lot</option>
                    <option value="expiration" <%= "expiration".equals(filterType) ? "selected" : "" %>>Expiration</option>
                    <option value="lowStock" <%= "lowStock".equals(filterType) ? "selected" : "" %>>Low Stock</option>
                </select>

                <input type="text" name="filterValue" value="<%= filterValue %>" placeholder="Enter filter value">
                <button type="submit">Apply</button>
                <a href="${pageContext.request.contextPath}/inventory" class="gray-btn">Reset</a>
            </form>

            <% if (errorMessage != null) { %>
                <p style="color:red; margin-bottom: 16px;"><%= errorMessage %></p>
            <% } %>

            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>Ref #</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Lot</th>
                            <th>Expiry</th>
                            <th>Qty</th>
                            <th>Location</th>
                        </tr>
                    </thead>

                    <tbody>
                        <% if (inventoryItems != null && !inventoryItems.isEmpty()) { %>
                            <% for (InventoryItem item : inventoryItems) { %>
                                <tr>
                                    <td><%= item.getItemReferenceNumber() %></td>
                                    <td><%= item.getItemName() %></td>
                                    <td><%= item.getCategoryName() %></td>
                                    <td><%= item.getLotNumber() %></td>
                                    <td><%= item.getExpirationDate() %></td>
                                    <td><%= item.getStock() %></td>
                                    <td><%= item.getLocation() %></td>
                                </tr>

                                <tr class="expanded-row">
                                    <td colspan="7">
                                        <div class="expanded-box">
                                            <form action="${pageContext.request.contextPath}/inventory" method="post">
                                                <input type="hidden" name="action" value="withdraw">
                                                <input type="hidden" name="itemReferenceNumber" value="<%= item.getItemReferenceNumber() %>">
                                                <input type="hidden" name="locationID" value="<%= item.getLocationID() %>">

                                                <label>Withdraw Qty:</label>
                                                <input type="number" name="qty" min="1" required>

                                                <button type="submit">Withdraw</button>
                                            </form>

                                            <% if (admin != null) { %>
                                                <form action="${pageContext.request.contextPath}/inventory" method="post" style="margin-top:10px;">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="itemReferenceNumber" value="<%= item.getItemReferenceNumber() %>">
                                                    <input type="hidden" name="locationID" value="<%= item.getLocationID() %>">

                                                    <label>Add Qty:</label>
                                                    <input type="number" name="qty" min="1" required>

                                                    <button type="submit">Add Stock</button>
                                                </form>
                                            <% } %>
                                        </div>
                                    </td>
                                </tr>
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