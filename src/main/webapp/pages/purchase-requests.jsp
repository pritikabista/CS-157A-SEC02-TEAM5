<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicalims.model.Admin" %>
<%@ page import="com.medicalims.model.PurchaseOrder" %>

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/logout");
        return;
    }

    String error = (String) request.getAttribute("error");
    String selectedStatus = (String) request.getAttribute("selectedStatus");
    List<PurchaseOrder> purchaseOrders =
            (List<PurchaseOrder>) request.getAttribute("purchaseOrders");

    if (selectedStatus == null) selectedStatus = "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MedIMS Purchase Requests</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>

<body>

<div class="layout">
    <aside class="sidebar">
        <h2>MedIMS Admin</h2>

        <a href="<%= request.getContextPath() %>/admin-dashboard">Dashboard</a>
        <a href="<%= request.getContextPath() %>/inventory">Inventory</a>
        <a href="<%= request.getContextPath() %>/admin-purchaseOrder">Purchase Requests</a>
        <a href="<%= request.getContextPath() %>/orders">Orders</a>
        <a href="<%= request.getContextPath() %>/supplier-info">Supplier Info</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </aside>

    <main class="main">
        <div class="topbar">
            <div>
                <h2>All Purchase Orders</h2>
                <p>View all requests submitted by users.</p>
            </div>

            <a href="<%= request.getContextPath() %>/admin-dashboard" class="secondary-btn">
                Back to Dashboard
            </a>
        </div>

        <% if (error != null) { %>
            <div style="color:red;"><%= error %></div>
        <% } %>

        <!-- FILTER -->
        <form method="get" action="<%= request.getContextPath() %>/admin-purchaseOrder">
            <select name="status">
                <option value="" <%= selectedStatus.isEmpty() ? "selected" : "" %>>All</option>
                <option value="PENDING" <%= "PENDING".equals(selectedStatus) ? "selected" : "" %>>Pending</option>
                <option value="APPROVED" <%= "APPROVED".equals(selectedStatus) ? "selected" : "" %>>Approved</option>
                <option value="DENIED" <%= "DENIED".equals(selectedStatus) ? "selected" : "" %>>Denied</option>
            </select>

            <button type="submit">Apply</button>
            <a href="<%= request.getContextPath() %>/admin-purchaseOrder">Reset</a>
        </form>

        <!-- TABLE -->
        <% if (purchaseOrders == null || purchaseOrders.isEmpty()) { %>
            <p>No purchase orders found.</p>
        <% } else { %>

            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>User</th>
                    <th>Item</th>
                    <th>Qty</th>
                    <th>Action</th>
                </tr>

                <% for (PurchaseOrder order : purchaseOrders) { %>

                    <tr onclick="toggle('<%= order.getOrderID() %>')" style="cursor:pointer;">
                        <td><%= order.getOrderID() %></td>
                        <td><%= order.getUsername() %></td>
                        <td><%= order.getItemName() %></td>
                        <td><%= order.getQty() %></td>
                        <td>View</td>
                    </tr>

                    <tr id="row-<%= order.getOrderID() %>" style="display:none;">
                        <td colspan="5">

                            <p><b>Message:</b> <%= order.getMessage() %></p>
                            <p><b>Status:</b> <%= order.getStatus() %></p>

                            <form action="<%= request.getContextPath() %>/admin-purchaseOrder" method="post">
                                <input type="hidden" name="action" value="approve">
                                <input type="hidden" name="orderID" value="<%= order.getOrderID() %>">
                                <button type="submit">Approve</button>
                            </form>

                            <form action="<%= request.getContextPath() %>/admin-purchaseOrder" method="post">
                                <input type="hidden" name="action" value="deny">
                                <input type="hidden" name="orderID" value="<%= order.getOrderID() %>">
                                <button type="submit">Deny</button>
                            </form>

                        </td>
                    </tr>

                <% } %>

            </table>
        <% } %>

    </main>
</div>

<script>
function toggle(id){
    const row = document.getElementById("row-"+id);
    row.style.display = row.style.display === "none" ? "table-row" : "none";
}
</script>

</body>
</html>