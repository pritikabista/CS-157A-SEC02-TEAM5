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

    if (selectedStatus == null) {
        selectedStatus = "";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>MedIMS Purchase Requests</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />

    <style>
        .expanded-row {
            display: none;
        }

        .expanded-box {
            padding: 18px 20px;
            background-color: #f8fafc;
            border-radius: 12px;
        }

        .expanded-actions {
            margin-top: 16px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .clickable-row {
            cursor: pointer;
        }

        .clickable-row:hover {
            background-color: #f8fafc;
        }
    </style>
</head>
<body>

<div class="layout">
    <aside class="sidebar">
        <h2>MedIMS Admin</h2>
        <a href="<%= request.getContextPath() %>/admin-dashboard">Dashboard</a>
        <a href="<%= request.getContextPath() %>/inventory">Inventory</a>
        <a href="<%= request.getContextPath() %>/admin-purchaseOrder">Purchase Requests</a>
        <a href="<%= request.getContextPath() %>/pages/orders.jsp">Orders</a>
        <a href="<%= request.getContextPath() %>/pages/supplier-info.jsp">Supplier Info</a>
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
            <div class="card" style="margin-top: 16px; color: #b00020;">
                <%= error %>
            </div>
        <% } %>

        <div class="form-card" style="margin-top: 16px;">
            <form method="get" action="<%= request.getContextPath() %>/admin-purchaseOrder">
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
                    <a href="<%= request.getContextPath() %>/admin-purchaseOrder" class="secondary-btn">
                        Clear Filter
                    </a>
                </div>
            </form>
        </div>

        <div class="card" style="margin-top: 20px;">
            <h3>Submitted Requests</h3>

            <% if (purchaseOrders == null || purchaseOrders.isEmpty()) { %>
                <p style="margin-top: 12px;">No purchase orders found.</p>
            <% } else { %>
                <div class="table-wrap" style="margin-top: 12px;">
                    <table>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Username</th>
                                <th>Item Name</th>
                                <th>Quantity</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (PurchaseOrder order : purchaseOrders) { %>
                                <tr class="clickable-row" onclick="toggleExpand('order-<%= order.getOrderID() %>')">
                                    <td><%= order.getOrderID() %></td>
                                    <td><%= order.getUsername() %></td>
                                    <td><%= order.getItemName() %></td>
                                    <td><%= order.getQty() %></td>
                                    <td>
                                        <button type="button" class="secondary-btn" onclick="toggleExpandButton(event, 'order-<%= order.getOrderID() %>')">
                                            View
                                        </button>
                                    </td>
                                </tr>

                                <tr id="order-<%= order.getOrderID() %>" class="expanded-row">
                                    <td colspan="5">
                                        <div class="expanded-box">
                                            <p><strong>User ID:</strong> <%= order.getUserID() %></p>
                                            <p><strong>Item Reference #:</strong> <%= order.getItemReferenceNum() %></p>
                                            <p><strong>Message:</strong> <%= order.getMessage() %></p>
                                            <p><strong>Approved By:</strong> <%= order.getApprovedBy() == 0 ? "Not yet approved" : order.getApprovedBy() %></p>
                                            <p><strong>Status:</strong> <%= order.getStatus() %></p>

                                            <div class="expanded-actions">
                                                <form action="<%= request.getContextPath() %>/admin-purchaseOrder" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="approve">
                                                    <input type="hidden" name="orderID" value="<%= order.getOrderID() %>">
                                                    <button type="submit" class="primary-btn" onclick="event.stopPropagation();">
                                                        Approve
                                                    </button>
                                                </form>

                                                <form action="<%= request.getContextPath() %>/admin-purchaseOrder" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="deny">
                                                    <input type="hidden" name="orderID" value="<%= order.getOrderID() %>">
                                                    <button type="submit" class="gray-btn" onclick="event.stopPropagation();">
                                                        Deny
                                                    </button>
                                                </form>

                                                <button type="button" class="gray-btn" onclick="closeRow(event, 'order-<%= order.getOrderID() %>')">
                                                    Close
                                                </button>
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
    </main>
</div>

<script>
    function toggleExpand(id) {
        const row = document.getElementById(id);
        row.style.display = row.style.display === "table-row" ? "none" : "table-row";
    }

    function toggleExpandButton(event, id) {
        event.stopPropagation();
        toggleExpand(id);
    }

    function closeRow(event, id) {
        event.stopPropagation();
        document.getElementById(id).style.display = "none";
    }
</script>

<script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>