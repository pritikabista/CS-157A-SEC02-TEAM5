<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MedIMS Update Inventory</title>
  <link rel="stylesheet" href="../css/style.css" />
</head>
<body>
  <div class="layout">
    <aside class="sidebar">
      <h2>MedIMS Admin</h2>
      <a href="admin-dashboard.jsp">Dashboard</a>
      <a href="admin-inventory.jsp">Inventory</a>
      <a href="purchase-requests.jsp">Purchase Requests</a>
      <a href="orders.jsp">Orders</a>
      <a href="supplier-info.jsp">Supplier Info</a>
      <a href="../login.jsp">Logout</a>
    </aside>

    <main class="main">
      <div class="topbar">
        <h2>Update Inventory Item</h2>
      </div>

      <%
        String error = (String) request.getAttribute("error");
        String success = (String) request.getAttribute("success");
        String message = (String) request.getAttribute("message");
      %>
      <% if (error != null) { %>
        <div class="card" style="margin-top: 16px; color: #b00020;"><%= error %></div>
      <% } %>
      <% if (success != null) { %>
        <div class="card" style="margin-top: 16px; color: #0b7a24;"><%= success %></div>
      <% } %>
      <% if (message != null) { %>
        <div class="card" style="margin-top: 16px;"><%= message %></div>
      <% } %>

      <div class="card" style="max-width: 850px; margin-top: 20px;">
        <form id="updateInventoryForm" method="post" action="update-inventory">
          <div class="form-grid">
            <div class="form-group">
              <label for="itemName">Item Name</label>
              <input type="text" id="itemName" name="itemName" value="Surgical Gloves" required />
            </div>

            <div class="form-group">
              <label for="referenceNumber">Reference Number</label>
              <input type="text" id="referenceNumber" name="referenceNumber" value="MED-1001" required />
            </div>

            <div class="form-group">
              <label for="lotId">Lot ID</label>
              <input type="text" id="lotId" name="lotId" value="LOT-A123" required />
            </div>

            <div class="form-group">
              <label for="expirationDate">Expiration Date</label>
              <input type="date" id="expirationDate" name="expirationDate" value="2026-05-10" required />
            </div>

            <div class="form-group">
              <label for="quantity">Quantity</label>
              <input type="number" id="quantity" name="quantity" value="8" min="0" required />
            </div>

            <div class="form-group">
              <label for="category">Category</label>
              <select id="category" name="category" required>
                <option value="PPE" selected>PPE</option>
                <option value="Injection Supplies">Injection Supplies</option>
                <option value="Fluids">Fluids</option>
                <option value="Medication">Medication</option>
                <option value="Sterile Supplies">Sterile Supplies</option>
              </select>
            </div>

            <div class="form-group full">
              <label for="location">Location</label>
              <input type="text" id="location" name="location" value="Storage Room A" required />
            </div>

            <div class="form-group full">
              <label for="notes">Notes</label>
              <textarea id="notes" name="notes" placeholder="Add update notes here...">Adjusting quantity after stock review.</textarea>
            </div>
          </div>

          <div class="form-actions">
            <button type="submit" class="primary-btn">Save</button>
            <button type="button" class="gray-btn" onclick="window.location.href='admin-inventory.jsp'">Cancel</button>
          </div>
        </form>
      </div>
    </main>
  </div>
</body>
</html>
