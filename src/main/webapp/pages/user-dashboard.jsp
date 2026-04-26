<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.medicalims.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>MedIMS User Dashboard</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>
<body>
  <div class="page">
    <header class="topbar user-topbar">
      <div class="brand">MedIMS</div>
      <nav class="user-nav">
        <a href="<%= request.getContextPath() %>/user-dashboard" class="active-link">Dashboard</a>
        <a href="<%= request.getContextPath() %>/inventory">Inventory</a>
        <a href="<%= request.getContextPath() %>/user-purchaseOrder">Request Item</a>
        <a href="<%= request.getContextPath() %>/pages/login.jsp">Logout</a>
      </nav>
    </header>

    <%
      String error = (String) request.getAttribute("error");
      String success = (String) request.getAttribute("success");
      String message = (String) request.getAttribute("message");
      User user = (User) session.getAttribute("user");

      if (user == null) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        return;
    }
    %>

    <% if (error != null) { %>
      <div class="card" style="margin: 16px 24px; color: #b00020;"><%= error %></div>
    <% } %>

    <% if (success != null) { %>
      <div class="card" style="margin: 16px 24px; color: #0b7a24;"><%= success %></div>
    <% } %>

    <% if (message != null) { %>
      <div class="card" style="margin: 16px 24px;"><%= message %></div>
    <% } %>

    <main class="user-dashboard-wrap">
      <section class="hero-card">
        <div>
          <p class="hero-label">Employee Portal</p>
          <h1>Welcome, <%= user.getUsername() %></h1>
          <p class="hero-text">Account ID: <%= user.getAccountID() %></p>
          <p class="hero-text">Department ID: <%= user.getDepartmentID() %></p>
          <p class="hero-text">Track inventory, review item status, and submit requests for your department.</p>
        </div>

        <div class="hero-actions">
          <button class="primary-btn"
                  onclick="window.location.href='<%= request.getContextPath() %>/inventory'">
            View Inventory
          </button>

          <button class="primary-btn"
                  onclick="window.location.href='<%= request.getContextPath() %>/user-myRequests'">
            View My Requests
          </button>

          <button class="secondary-btn"
                  onclick="window.location.href='<%= request.getContextPath() %>/user-purchaseOrder'">
            Request Item
          </button>
        </div>
      </section>

      <section class="dashboard-stats">
        <div class="stat-card">
          <span class="stat-title">Low Stock Items</span>
         <span class="stat-number low-text"><%= request.getAttribute("lowStockCount") %></span>
          <span class="stat-note">Needs attention</span>
        </div>

        <div class="stat-card">
          <span class="stat-title">Expiring Soon</span>
         <span class="stat-number warn-text"><%= request.getAttribute("expiringSoonCount") %></span>
          <span class="stat-note">Use FEFO first</span>
        </div>

        <div class="stat-card">
          <span class="stat-title">My Requests</span>
         <span class="stat-number"><%= request.getAttribute("myRequestsCount") %></span>
          <span class="stat-note">Pending review</span>
        </div>
      </section>
    </main>
  </div>
</body>
</html>