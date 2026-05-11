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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>

<body>
<div class="layout">

    <aside class="sidebar">
        <% if (admin != null) { %>
            <h2>MedIMS Admin</h2>
            <a href="<%= request.getContextPath() %>/admin-dashboard">Dashboard</a>
            <a href="<%= request.getContextPath() %>/inventory" class="active">Inventory</a>
            <a href="<%= request.getContextPath() %>/admin-purchaseOrder">Purchase Requests</a>
            <a href="<%= request.getContextPath() %>/orders">Orders</a>
            <a href="<%= request.getContextPath() %>/supplier-info">Supplier Info</a>
            <a href="<%= request.getContextPath() %>/logout">Logout</a>
        <% } else { %>
            <h2>MedIMS User</h2>
            <a href="<%= request.getContextPath() %>/user-dashboard">Dashboard</a>
            <a href="<%= request.getContextPath() %>/inventory" class="active">Inventory</a>
            <a href="<%= request.getContextPath() %>/user-myRequests">My Requests</a>
            <a href="<%= request.getContextPath() %>/logout">Logout</a>
        <% } %>
    </aside>

    <main class="main">
        <div class="inventory-page">

            <div class="topbar">
                <div>
                    <h1>Inventory</h1>
                    <p>Manage and track medical inventory items</p>
                </div>

                <% if (admin != null) { %>
                    <button class="primary-btn"
                        onclick="window.location.href='<%= request.getContextPath() %>/pages/add-item.jsp'">
                        Add New Item
                    </button>
                <% } %>
            </div>

            <div class="card">

                <!-- Search + Filter -->
                <form action="<%= request.getContextPath() %>/inventory" method="post" class="toolbar">
                    <input type="text" name="search" value="<%= search %>" placeholder="Search inventory..." />

                    <select name="filterType">
                        <option value="">Filter</option>
                        <option value="location" <%= "location".equals(filterType) ? "selected" : "" %>>Location</option>
                        <option value="lot" <%= "lot".equals(filterType) ? "selected" : "" %>>Lot</option>
                        <option value="expiration" <%= "expiration".equals(filterType) ? "selected" : "" %>>Expiration</option>
                        <option value="lowStock" <%= "lowStock".equals(filterType) ? "selected" : "" %>>Low Stock</option>
                    </select>

                    <input type="text" name="filterValue" value="<%= filterValue %>" placeholder="Filter value" />

                    <button type="submit" class="primary-btn">Apply</button>
                    <a href="<%= request.getContextPath() %>/inventory" class="gray-btn">Reset</a>
                </form>

                <% if (errorMessage != null) { %>
                    <p style="color:red; margin-bottom: 15px;"><%= errorMessage %></p>
                <% } %>

                <!-- Table -->
                <div class="table-wrap">
                    <table>
                        <thead>
                        <tr>
                            <th>Ref #</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Lot</th>
                            <th>Expiry</th>
                            <th>Location</th>
                            <th>Qty</th>
                        </tr>
                        </thead>

                        <tbody>
                        <% if (inventoryItems != null && !inventoryItems.isEmpty()) { %>

                            <% for (InventoryItem item : inventoryItems) { 
                                String rowId = "row" + String.valueOf(item.getItemReferenceNumber());
                            %>

                            <!-- Main Row -->
                            <tr class="clickable-row <%= item.getStock() <= 10 ? "low-stock-row" : "" %>"
                                onclick="toggleExpand('<%= rowId %>')">
                                <td><%= item.getItemReferenceNumber() %></td>
                                <td><%= item.getItemName() %></td>
                                <td><%= item.getCategoryName() %></td>
                                <td><%= item.getLotNumber() %></td>
                                <td><%= item.getExpirationDate() %></td>
                                <td><%= item.getLocation() %></td>
                                <td><%= item.getStock() %></td>
                            </tr>

                            <!-- Expand Row -->
                            <tr id="<%= rowId %>" style="display:none;">
                                <td colspan="7">
                                    <div class="expanded-box">

                                        <div class="expanded-grid">
                                            <p><strong>Reference:</strong> <%= item.getItemReferenceNumber() %></p>
                                            <p><strong>Name:</strong> <%= item.getItemName() %></p>
                                            <p><strong>Category:</strong> <%= item.getCategoryName() %></p>
                                            <p><strong>Lot:</strong> <%= item.getLotNumber() %></p>
                                            <p><strong>Expiry:</strong> <%= item.getExpirationDate() %></p>
                                            <p><strong>Location:</strong> <%= item.getLocation() %></p>

                                            <% if (item.getStock() <= 10) { %>
                                                <p><strong>Status:</strong> <span class="badge badge-low">Low Stock</span></p>
                                            <% } else { %>
                                                <p><strong>Status:</strong> <span class="badge badge-done">Available</span></p>
                                            <% } %>
                                        </div>

                                        <!-- Actions -->
                                        <div class="expanded-actions">

                                            <!-- Withdraw -->
                                            <form action="<%= request.getContextPath() %>/inventory" method="post">
                                                <input type="hidden" name="action" value="withdraw" />
                                                <input type="hidden" name="itemReferenceNumber" value="<%= item.getItemReferenceNumber() %>" />
                                                <input type="hidden" name="locationID" value="<%= item.getLocationID() %>" />

                                                <input type="number" name="qty" min="1" required />
                                                <button type="submit" class="primary-btn">Withdraw</button>
                                            </form>

                                            <% if (admin != null) { %>
                                            <!-- Add Stock -->
                                            <form action="<%= request.getContextPath() %>/inventory" method="post">
                                                <input type="hidden" name="action" value="update" />
                                                <input type="hidden" name="itemReferenceNumber" value="<%= item.getItemReferenceNumber() %>" />
                                                <input type="hidden" name="locationID" value="<%= item.getLocationID() %>" />

                                                <input type="number" name="qty" min="1" required />
                                                <button type="submit" class="secondary-btn">Add Stock</button>
                                            </form>
                                            <% } %>

                                        </div>

                                    </div>
                                </td>
                            </tr>

                            <% } %>

                        <% } else { %>
                            <tr>
                                <td colspan="7">No inventory found.</td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </main>
</div>

<script>
function toggleExpand(id) {
    const row = document.getElementById(id);
    row.style.display =
        (row.style.display === "none" || row.style.display === "")
            ? "table-row"
            : "none";
}
</script>

</body>
</html>