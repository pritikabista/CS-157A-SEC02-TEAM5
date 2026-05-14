<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicalims.model.PurchaseOrder" %>

<%
  List<PurchaseOrder> orders =
      (List<PurchaseOrder>) request.getAttribute("orders");
%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>MedIMS Orders</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>
<body>

<div class="layout">
  <aside class="sidebar">
    <h2>MedIMS Admin</h2>
    <a href="<%= request.getContextPath() %>/admin-dashboard">Dashboard</a>
    <a href="<%= request.getContextPath() %>/pages/admin-inventory.jsp">Inventory</a>
    <a href="<%= request.getContextPath() %>/admin-purchaseOrder">Purchase Requests</a>
    <a href="<%= request.getContextPath() %>/orders" class="active">Orders</a>
    <a href="<%= request.getContextPath() %>/supplier-info">Supplier Info</a>
    <a href="<%= request.getContextPath() %>/logout">Logout</a>
  </aside>

  <main class="main">
    <div class="topbar">
      <h2>Orders</h2>
    </div>

    <div class="card" style="margin-top: 20px;">
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>Order ID</th>
              <th>Item</th>
              <th>Supplier</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>

          <tbody>
            <% if (orders != null && !orders.isEmpty()) { %>

              <% for (PurchaseOrder order : orders) { %>
                <tr>
                  <td>#ORD-<%= order.getOrderID() %></td>
                  <td><%= order.getItemName() %></td>
                  <td><%= order.getSupplierName() %></td>
                  <td>
                    <% if (order.getStatus().toString().equals("APPROVED")) { %>
                      <span class="badge badge-process">In Process</span>
                    <% } else if (order.getStatus().toString().equals("DENIED")) { %>
                      <span class="badge badge-exp">Denied</span>
                    <% } %>
                  </td>
                  <td>
                    <button class="secondary-btn" onclick="toggleStatus(this)">
                      Mark Done
                    </button>
                  </td>
                </tr>
              <% } %>

            <% } else { %>

              <tr>
                <td colspan="5">No orders in process.</td>
              </tr>

            <% } %>
          </tbody>
        </table>
      </div>
    </div>

    <%
      String msg = (String) request.getAttribute("message");
      if (msg != null) {
    %>
      <p style="color: green; margin-top: 15px;"><%= msg %></p>
    <%
      }
    %>
  </main>
</div>

<script>

  function toggleStatus(button) {
    const row = button.closest("tr");
    const statusCell = row.cells[3];

    if (statusCell.innerText.includes("Done")) {
      statusCell.innerHTML = '<span class="badge badge-process">In Process</span>';
      button.innerText = "Mark Done";
    } else {
      statusCell.innerHTML = '<span class="badge badge-done">Done</span>';
      button.innerText = "Set In Process";
    }
  }
</script>

</body>
</html>