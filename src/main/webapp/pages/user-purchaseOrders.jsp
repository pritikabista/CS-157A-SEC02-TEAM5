<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicalims.model.PurchaseOrder" %>

<%
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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Purchase Orders</title>

    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

    <style>
        .user-orders-page a {
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            min-height: 44px !important;
            padding: 0 18px !important;
            border-radius: 10px !important;
            font-weight: 700 !important;
            text-decoration: none !important;
            line-height: 1 !important;
        }

        .user-orders-page a.primary-btn {
            background: #0f766e !important;
            color: white !important;
        }

        .user-orders-page a.secondary-btn {
            background: #e7f3f2 !important;
            color: #0f766e !important;
        }

        .user-orders-page a.gray-btn {
            background: #e5e7eb !important;
            color: #374151 !important;
        }

        .user-orders-page .toolbar {
            display: grid !important;
            grid-template-columns: 1fr 180px 160px !important;
            gap: 12px !important;
            align-items: center !important;
        }

        .user-orders-page .toolbar select,
        .user-orders-page .toolbar button,
        .user-orders-page .toolbar a {
            height: 48px !important;
        }

        .user-orders-page .empty-state {
            text-align: center !important;
            padding: 42px 20px !important;
            margin-top: 20px !important;
            background: #f8fbfc !important;
            border: 1px dashed #dbe4ea !important;
            border-radius: 18px !important;
        }

        .user-orders-page .panel-subtext {
            color: #64748b;
            margin-top: 6px;
        }

        .user-orders-page .clean-table {
            width: 100%;
            border-collapse: collapse;
        }

        .user-orders-page .clean-table th {
            background: #f8fbfc;
            color: #475569;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.04em;
        }

        .user-orders-page .clean-table th,
        .user-orders-page .clean-table td {
            padding: 14px 16px;
            border-bottom: 1px solid #edf2f7;
            text-align: left;
        }
    </style>
</head>

<body>

<div class="page main user-orders-page">

    <div class="topbar">
        <div>
            <h1>My Purchase Orders</h1>
            <p>Track your submitted item requests and approval status.</p>
        </div>

        <div class="action-row">
            <a href="<%= request.getContextPath() %>/user-dashboard" class="secondary-btn">
                Dashboard
            </a>

            <a href="<%= request.getContextPath() %>/user-purchaseOrder" class="primary-btn">
                New Request
            </a>

            <a href="<%= request.getContextPath() %>/logout" class="gray-btn">
                Logout
            </a>
        </div>
    </div>

    <% if (error != null) { %>
        <div class="card" style="margin-top: 16px; color: #b00020;">
            <%= error %>
        </div>
    <% } %>

    <div class="card" style="margin-top: 16px;">
        <form method="get"
              action="<%= request.getContextPath() %>/user-myRequests"
              class="toolbar">

            <select id="status" name="status">
                <option value="" <%= selectedStatus.isEmpty() ? "selected" : "" %>>
                    All Requests
                </option>

                <option value="PENDING"
                    <%= "PENDING".equals(selectedStatus) ? "selected" : "" %>>
                    Pending
                </option>

                <option value="APPROVED"
                    <%= "APPROVED".equals(selectedStatus) ? "selected" : "" %>>
                    Approved
                </option>

                <option value="DENIED"
                    <%= "DENIED".equals(selectedStatus) ? "selected" : "" %>>
                    Denied
                </option>
            </select>

            <button type="submit" class="primary-btn">
                Apply Filter
            </button>

            <a href="<%= request.getContextPath() %>/user-myRequests"
               class="gray-btn">
                Clear Filter
            </a>
        </form>
    </div>

    <div class="card" style="margin-top: 20px;">

        <div class="panel-head">
            <div>
                <h3>Submitted Requests</h3>

                <p class="panel-subtext">
                    Review the status of your inventory purchase requests.
                </p>
            </div>
        </div>

        <% if (purchaseOrders == null || purchaseOrders.isEmpty()) { %>

            <div class="empty-state">
                <h3>No purchase orders found</h3>

                <p>
                    You have not submitted any matching requests yet.
                </p>

                <a href="<%= request.getContextPath() %>/user-purchaseOrder"
                   class="primary-btn">
                    Create Request
                </a>
            </div>

        <% } else { %>

            <div class="table-wrap" style="margin-top: 12px;">

                <table class="clean-table">

                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Item Ref #</th>
                            <th>Quantity</th>
                            <th>Message</th>
                            <th>Status</th>
                            <th>Approved By</th>
                        </tr>
                    </thead>

                    <tbody>

                        <% for (PurchaseOrder order : purchaseOrders) { %>

                            <tr>
                                <td>#<%= order.getOrderID() %></td>

                                <td><%= order.getItemReferenceNum() %></td>

                                <td><%= order.getQty() %></td>

                                <td><%= order.getMessage() %></td>

                                <td>
                                    <% if ("PENDING".equals(order.getStatus())) { %>

                                        <span class="badge badge-expiring">
                                            Pending
                                        </span>

                                    <% } else if ("APPROVED".equals(order.getStatus())) { %>

                                        <span class="badge badge-done">
                                            Approved
                                        </span>

                                    <% } else if ("DENIED".equals(order.getStatus())) { %>

                                        <span class="badge badge-low">
                                            Denied
                                        </span>

                                    <% } else { %>

                                        <span class="badge badge-process">
                                            <%= order.getStatus() %>
                                        </span>

                                    <% } %>
                                </td>

                                <td>
                                    <%= order.getApprovedBy() == 0
                                        ? "Not yet approved"
                                        : order.getApprovedBy() %>
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