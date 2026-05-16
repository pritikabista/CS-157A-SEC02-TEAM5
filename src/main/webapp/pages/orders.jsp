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

      <form class="toolbar" method="get"
          action="<%= request.getContextPath() %>/orders">

        <select name="status">

            <option value="">All</option>

            <option value="APPROVED"
                <%= "APPROVED".equals(request.getParameter("status"))
                    ? "selected" : "" %>>
                Approved
            </option>

            <option value="DENIED"
                <%= "DENIED".equals(request.getParameter("status"))
                    ? "selected" : "" %>>
                Denied
            </option>

            <option value="COMPLETED"
                <%= "COMPLETED".equals(request.getParameter("status"))
                    ? "selected" : "" %>>
                Completed
            </option>

        </select>

        <button type="submit">Apply</button>

        <a href="<%= request.getContextPath() %>/orders">
            Reset
        </a>

      </form>

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
                      <span class="badge badge-process">
                        In Process
                      </span>
                    <% } else if (order.getStatus().toString().equals("DENIED")) { %>
                      <span class="badge badge-exp">
                        Denied
                      </span>
                    <% } else if (order.getStatus().toString().equals("COMPLETED")) { %>
                      <span class="badge badge-done">
                        Completed
                      </span>
                    <% } %>
                  </td>
                  <td>
                    <% if (order.getStatus().toString().equals("APPROVED")) { %>
                      <form action="<%= request.getContextPath() %>/orders"
                            method="post">
                        <input type="hidden"
                              name="action"
                              value="complete">
                        <input type="hidden"
                              name="orderID"
                              value="<%= order.getOrderID() %>">
                        <button type="submit"
                                class="secondary-btn">
                          Mark Done
                        </button>
                      </form>
                    <% } else { %>
                      <span style="color: gray;">
                        No Actions
                      </span>

                    <% } %>
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
</body>
</html>