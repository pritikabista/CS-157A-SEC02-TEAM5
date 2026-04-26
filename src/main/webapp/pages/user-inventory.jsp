<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>User Inventory</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>
<body>
  <div class="page main">
    <div class="user-header">
      <div class="user-nav">
        <div>
          <h2>User Inventory</h2>
          <p class="note">Search, filter, sort, and expand items to withdraw or request.</p>
        </div>
        <div class="user-nav-links">
          <a href="<%= request.getContextPath() %>/inventory">Inventory</a>
          <a href="<%= request.getContextPath() %>/pages/login.jsp">Logout</a>
        </div>
      </div>
    </div>

    <%
      String error = (String) request.getAttribute("error");
      String success = (String) request.getAttribute("success");
      String message = (String) request.getAttribute("message");
    %>
    <% if (error != null) { %><div class="card" style="margin-top: 16px; color: #b00020;"><%= error %></div><% } %>
    <% if (success != null) { %><div class="card" style="margin-top: 16px; color: #0b7a24;"><%= success %></div><% } %>
    <% if (message != null) { %><div class="card" style="margin-top: 16px;"><%= message %></div><% } %>

    <div class="toolbar">
      <input type="text" id="searchInput" placeholder="Search by item name, ref, or location" />
      <select id="categoryFilter">
        <option value="">Filter by category</option>
        <option value="PPE">PPE</option>
        <option value="Injection Supplies">Injection Supplies</option>
        <option value="Fluids">Fluids</option>
        <option value="Expiring Soon">Expiring Soon</option>
      </select>
      <select id="sortFilter">
        <option value="">Sort by</option>
        <option value="Expiry">Expiry</option>
        <option value="Alphabetical">Alphabetical</option>
      </select>
    </div>

    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>Item Ref #</th>
            <th>Name</th>
            <th>Lot Number</th>
            <th>Expiration Date</th>
            <th>Location</th>
            <th>Quantity</th>
          </tr>
        </thead>
        <tbody id="inventoryTableBody"></tbody>
      </table>
    </div>
  </div>

  <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>