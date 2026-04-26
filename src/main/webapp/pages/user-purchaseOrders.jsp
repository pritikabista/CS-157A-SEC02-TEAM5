<%---jsp when user click the "view my requests" --%>
<%-- see DisplayUserPurchaseOrdersServlet --%>

<%-- Temp, chatgpted frontend --%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicalims.model.PurchaseOrder" %>
<%@ page import="com.medicalims.model.OrderStatus" %>

<%
    String error = (String) request.getAttribute("error");
    String selectedStatus = (String) request.getAttribute("selectedStatus");
    List<PurchaseOrder> purchaseOrders = (List<PurchaseOrder>) request.getAttribute("purchaseOrders");

    if (selectedStatus == null) {
        selectedStatus = "";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Purchase Orders</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="page main">

    <div class="topbar">
        <div>
            <h2>My Purchase Orders</h2>
            <p>View all requests you have submitted.</p>
        </div>
        <a href="<%= request.getContextPath() %>/user-dashboard" class="secondary-btn">
            Back to Dashboard
        </a>
    </div>

    <% if (error != null) { %>
        <div class="card" style="margin-top: 16px; color: #b00020;">
            <%= error %>
        </div>
    <% } %>

    <div class="form-card" style="margin-top: 16px;">
        <form method="get" action="<%= request.getContextPath() %>/user-myRequests">
            <div class="form-group">
                <label for="status">Filter by Status</label>
                <select id="status" name="status">
                    <option value="" <%= selectedStatus.isEmpty() ? "selected" : "" %>>All</option>
                    <option value="PENDING" <%= "PENDING".equals(selectedStatus) ? "selected" : "" %>>Pending</option>
                    <option value="APPROVED" <%= "APPROVED".equals(selectedStatus) ? "selected" : "" %>>Approved</option>
                    <option value="DENIED" <%= "DENIED".equals(selectedStatus) ? "selected" : "" %>>Denied</option>
                </select>
            </div>

            <div class="form-actions">
                <button type="submit" class="primary-btn">Apply Filter</button>
                <a href="<%= request.getContextPath() %>/user-myRequests" class="secondary-btn">
                    Clear Filter
                </a>
            </div>
        </form>
    </div>

    <div class="card" style="margin-top: 20px;">
        <h3>Submitted Requests</h3>

        <% if (purchaseOrders == null || purchaseOrders.isEmpty()) { %>
            <p>No purchase orders found.</p>
        <% } else { %>
            <div class="table-wrap" style="margin-top: 12px;">
                <table>
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Item Reference #</th>
                        <th>Quantity</th>
                        <th>Message</th>
                        <th>Status</th>
                        <th>Approved By</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (PurchaseOrder order : purchaseOrders) { %>
                        <tr>
                            <td><%= order.getOrderID() %></td>
                            <td><%= order.getItemReferenceNum() %></td>
                            <td><%= order.getQty() %></td>
                            <td><%= order.getMessage() %></td>
                            <td><%= order.getStatus() %></td>
                            <td>
                                <%= order.getApprovedBy() == 0 ? "Not yet approved" : order.getApprovedBy() %>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </div>

</div>

<script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>