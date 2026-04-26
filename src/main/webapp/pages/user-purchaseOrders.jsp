<%---jsp when user click the "view my requsts" --%>
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
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="page main">

    <div class="topbar">
        <div>
            <h2>My Purchase Orders</h2>
            <p>View all requests you have submitted.</p>
        </div>
        <a href="user-dashboard.jsp">
            <button type="button" class="secondary">Back to Dashboard</button>
        </a>
    </div>

    <% if (error != null) { %>
        <div class="card" style="margin-top: 16px; color: #b00020;">
            <%= error %>
        </div>
    <% } %>

    <div class="form-card" style="margin-top: 16px;">
        <form method="get" action="<%= request.getContextPath() %>/user-purchaseOrders">
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
                <button type="submit">Apply Filter</button>
                <a href="<%= request.getContextPath() %>/user-purchaseOrders">
                    <button type="button" class="secondary">Clear Filter</button>
                </a>
            </div>
        </form>
    </div>

    <div class="card" style="margin-top: 20px;">
        <h3>Submitted Requests</h3>

        <% if (purchaseOrders == null || purchaseOrders.isEmpty()) { %>
            <p>No purchase orders found.</p>
        <% } else { %>
            <table style="width: 100%; border-collapse: collapse; margin-top: 12px;">
                <thead>
                <tr style="border-bottom: 1px solid #ddd; text-align: left;">
                    <th style="padding: 12px;">Order ID</th>
                    <th style="padding: 12px;">Item Reference #</th>
                    <th style="padding: 12px;">Quantity</th>
                    <th style="padding: 12px;">Message</th>
                    <th style="padding: 12px;">Status</th>
                    <th style="padding: 12px;">Approved By</th>
                </tr>
                </thead>
                <tbody>
                <% for (PurchaseOrder order : purchaseOrders) { %>
                    <tr style="border-bottom: 1px solid #eee;">
                        <td style="padding: 12px;"><%= order.getOrderID() %></td>
                        <td style="padding: 12px;"><%= order.getItemReferenceNumber() %></td>
                        <td style="padding: 12px;"><%= order.getQty() %></td>
                        <td style="padding: 12px;"><%= order.getMessage() %></td>
                        <td style="padding: 12px;"><%= order.getStatus() %></td>
                        <td style="padding: 12px;">
                            <%= order.getApprovedBy() == 0 ? "Not yet approved" : order.getApprovedBy() %>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        <% } %>
    </div>

</div>

<script src="../js/script.js"></script>
</body>
</html>

