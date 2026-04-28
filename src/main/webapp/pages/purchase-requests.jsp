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
        <a href="<%= request.getContextPath() %>/admin-purchaseOrder" class="active">Purchase Requests</a>
        <a href="<%= request.getContextPath() %>/orders">Orders</a>
        <a href="<%= request.getContextPath() %>/supplier-info">Supplier Info</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </aside>

    <main class="main">
        <div class="purchase-page">

            <div class="page-header">
                <div>
                    <h1>All Purchase Orders</h1>
                    <p class="page-subtitle">View and manage requests submitted by users.</p>
                </div>

                <a href="<%= request.getContextPath() %>/admin-dashboard" class="back-link">
                    Back to Dashboard
                </a>
            </div>

            <% if (error != null) { %>
                <p style="color:red; margin-bottom: 16px;"><%= error %></p>
            <% } %>

            <div class="card">
                <form class="toolbar" method="get" action="<%= request.getContextPath() %>/admin-purchaseOrder">
                    <select name="status">
                        <option value="" <%= selectedStatus.isEmpty() ? "selected" : "" %>>All</option>
                        <option value="PENDING" <%= "PENDING".equals(selectedStatus) ? "selected" : "" %>>Pending</option>
                        <option value="APPROVED" <%= "APPROVED".equals(selectedStatus) ? "selected" : "" %>>Approved</option>
                        <option value="DENIED" <%= "DENIED".equals(selectedStatus) ? "selected" : "" %>>Denied</option>
                    </select>

                    <button type="submit">Apply</button>
                    <a href="<%= request.getContextPath() %>/admin-purchaseOrder">Reset</a>
                </form>

                <% if (purchaseOrders == null || purchaseOrders.isEmpty()) { %>
                    <p class="note">No purchase orders found.</p>
                <% } else { %>

                    <div class="table-wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>User</th>
                                    <th>Item</th>
                                    <th>Qty</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody>
                                <% for (PurchaseOrder order : purchaseOrders) { %>
                                    <tr class="clickable-row" onclick="toggle('<%= order.getOrderID() %>')">
                                        <td><%= order.getOrderID() %></td>
                                        <td><%= order.getUsername() %></td>
                                        <td><%= order.getItemName() %></td>
                                        <td><%= order.getQty() %></td>
                                        <td><span class="view-link">View Details</span></td>
                                    </tr>

                                    <tr id="row-<%= order.getOrderID() %>" class="expanded-row" style="display:none;">
                                        <td colspan="5">
                                            <div class="expanded-box">
                                                <p><strong>Message:</strong> <%= order.getMessage() %></p>
                                                <p><strong>Status:</strong> 
                                                    <span class="badge badge-exp"><%= order.getStatus() %></span>
                                                </p>

                                                <div class="action-row mt-16">
                                                    <form action="<%= request.getContextPath() %>/admin-purchaseOrder" method="post">
                                                        <input type="hidden" name="action" value="approve">
                                                        <input type="hidden" name="orderID" value="<%= order.getOrderID() %>">
                                                        <button type="submit">Approve</button>
                                                    </form>

                                                    <form action="<%= request.getContextPath() %>/admin-purchaseOrder" method="post">
                                                        <input type="hidden" name="action" value="deny">
                                                        <input type="hidden" name="orderID" value="<%= order.getOrderID() %>">
                                                        <button type="submit" class="red-btn">Deny</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                <% } %>
            </div>

        </div>
    </main>
</div>

<script>
function toggle(id){
    const row = document.getElementById("row-" + id);
    row.style.display = row.style.display === "none" ? "table-row" : "none";
}
</script>

</body>
</html>