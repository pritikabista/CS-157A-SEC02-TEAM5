<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>MedIMS User Dashboard</title>
  <link rel="stylesheet" href="../css/style.css" />
</head>
<body>
  <div class="page">
    <header class="topbar user-topbar">
      <div class="brand">MedIMS</div>
      <nav class="user-nav">
        <a href="user-dashboard.jsp" class="active-link">Dashboard</a>
        <a href="user-inventory.jsp">Inventory</a>
        <a href="user-request.jsp">Request Item</a>
        <a href="../login.jsp">Logout</a>
      </nav>
    </header>

    <%
      String error = (String) request.getAttribute("error");
      String success = (String) request.getAttribute("success");
      String message = (String) request.getAttribute("message");
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
          <h1>User Dashboard</h1>
          <p class="hero-text">Track inventory, review item status, and submit requests for your department.</p>
        </div>
        <div class="hero-actions">
          <button class="primary-btn" onclick="window.location.href='user-inventory.jsp'">View Inventory</button>
          <button onclick="window.location.href='${pageContext.request.contextPath}/purchase-order'">View My Requests</button>
          <button class="secondary-btn" onclick="window.location.href='user-request.jsp'">Request Item</button>
        </div>
      </section>

      <section class="dashboard-stats">
        <div class="stat-card"><span class="stat-title">Low Stock Items</span><span class="stat-number low-text">4</span><span class="stat-note">Needs attention</span></div>
        <div class="stat-card"><span class="stat-title">Expiring Soon</span><span class="stat-number warn-text">3</span><span class="stat-note">Use FEFO first</span></div>
        <div class="stat-card"><span class="stat-title">My Requests</span><span class="stat-number">2</span><span class="stat-note">Pending review</span></div>
      </section>
    </main>
  </div>
</body>
</html>
