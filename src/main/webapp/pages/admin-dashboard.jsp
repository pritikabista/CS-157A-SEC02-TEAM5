<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="../css/style.css" />
</head>
<body>
  <div class="layout">
    <aside class="sidebar">
      <h2>MedIMS Admin</h2>
      <nav>
        <a href="admin-dashboard.jsp">Dashboard</a>
        <a href="admin-inventory.jsp">Inventory</a>
        <a href="purchase-requests.jsp">Purchase Requests</a>
        <a href="orders.jsp">Orders</a>
        <a href="supplier-info.jsp">Supplier Info</a>
        <a href="add-item.jsp">Add Item</a>
        <a href="../login.jsp">Logout</a>
      </nav>
    </aside>

    <main class="main">
      <div class="topbar">
        <div>
          <h1>Admin Dashboard</h1>
          <p>Manage inventory, requests, orders, and suppliers.</p>
        </div>
      </div>

      <div class="dashboard-grid">
        <a href="admin-inventory.jsp" class="dashboard-tile">
          <h3>Inventory</h3>
          <p class="note">View and update hospital inventory</p>
        </a>

        <a href="purchase-requests.jsp" class="dashboard-tile">
          <h3>Purchase Requests</h3>
          <p class="note">Review user requests</p>
        </a>

        <a href="orders.jsp" class="dashboard-tile">
          <h3>Orders</h3>
          <p class="note">Approve and update order status</p>
        </a>
      </div>

      <%-- Optional dynamic message (future backend use) --%>
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

  <script src="../js/script.js"></script>
</body>
</html>