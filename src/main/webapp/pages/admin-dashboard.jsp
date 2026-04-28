<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.medicalims.model.Admin" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>

<body>
  <%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
      response.sendRedirect(request.getContextPath() + "/logout");
      return;
    }
  %>

  <div class="layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">

      <!--  LOGO + TITLE -->
      <div style="text-align:center; padding:20px 0;">
        <img src="<%= request.getContextPath() %>/images/logo.png"
             alt="MedIMS Logo"
             style="width:70px; display:block; margin:0 auto 10px; border-radius:10px;">
        
        <h2 style="color:white; margin:0;">MedIMS Admin</h2>
      </div>

      <nav>
        <a href="<%= request.getContextPath() %>/admin-dashboard">Dashboard</a>
        <a href="<%= request.getContextPath() %>/inventory">Inventory</a>
        <a href="<%= request.getContextPath() %>/admin-purchaseOrder">Purchase Requests</a>
        <a href="<%= request.getContextPath() %>/orders">Orders</a>
        <a href="<%= request.getContextPath() %>/supplier-info">Supplier Info</a>
        <a href="<%= request.getContextPath() %>/add-item">Add Item</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
      </nav>

    </aside>

    <!-- MAIN CONTENT -->
    <main class="main">
      <div class="topbar">
        <div>
          <p class="hero-label">Admin Dashboard</p>
          <h1>Welcome, <%= admin.getUsername() %></h1>
          <p class="hero-text">Account ID: <%= admin.getAccountID() %></p>
          <p>Manage inventory, requests, orders, and suppliers.</p>
        </div>
      </div>

      <div class="dashboard-grid">
        <a href="<%= request.getContextPath() %>/inventory" class="dashboard-tile">
          <h3>Inventory</h3>
          <p class="note">View and update hospital inventory</p>
        </a>

        <a href="<%= request.getContextPath() %>/admin-purchaseOrder" class="dashboard-tile">
          <h3>Purchase Requests</h3>
          <p class="note">Review user requests</p>
        </a>

        <a href="<%= request.getContextPath() %>/orders" class="dashboard-tile">
          <h3>Orders</h3>
          <p class="note">Approve and update order status</p>
        </a>
      </div>

      <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
      %>
        <p style="color: green; margin-top: 15px;"><%= message %></p>
      <%
        }
      %>
    </main>

  </div>

  <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>