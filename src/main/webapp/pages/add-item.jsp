<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MedIMS Add New Inventory Item</title>
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
        <h2>Add New Inventory Item</h2>
      </div>

      <div class="card" style="max-width: 800px; margin-top: 20px;">
        <form id="addItemForm" action="../addItem" method="post">
          <div class="form-grid">
            <div class="form-group">
              <label for="itemName">Item Name</label>
              <input type="text" id="itemName" name="itemName" placeholder="Enter item name" required />
            </div>

            <div class="form-group">
              <label for="referenceNumber">Reference Number</label>
              <input type="text" id="referenceNumber" name="referenceNumber" placeholder="Enter reference number" required />
            </div>

            <div class="form-group">
              <label for="lotNumber">Lot #</label>
              <input type="text" id="lotNumber" name="lotNumber" placeholder="Enter lot number" required />
            </div>

            <div class="form-group">
              <label for="expirationDate">Expiration Date</label>
              <input type="date" id="expirationDate" name="expirationDate" required />
            </div>

            <div class="form-group">
              <label for="quantity">Quantity</label>
              <input type="number" id="quantity" name="quantity" placeholder="Enter quantity" min="1" required />
            </div>

            <div class="form-group">
              <label for="category">Category</label>
              <select id="category" name="category" required>
                <option value="">Select category</option>
                <option value="PPE">PPE</option>
                <option value="Injection Supplies">Injection Supplies</option>
                <option value="Fluids">Fluids</option>
                <option value="Medication">Medication</option>
                <option value="Sterile Supplies">Sterile Supplies</option>
              </select>
            </div>

            <div class="form-group full">
              <label for="location">Location</label>
              <input type="text" id="location" name="location" placeholder="Enter storage location" required />
            </div>
          </div>

          <div class="form-actions">
            <button type="submit" class="primary-btn">Done</button>
            <button type="button" class="gray-btn" onclick="window.location.href='admin-inventory.jsp'">Cancel</button>
          </div>
        </form>

        <%
          String success = (String) request.getAttribute("success");
          String error = (String) request.getAttribute("error");
          if (success != null) {
        %>
          <p style="color: green; margin-top: 15px;"><%= success %></p>
        <%
          }
          if (error != null) {
        %>
          <p style="color: red; margin-top: 15px;"><%= error %></p>
        <%
          }
        %>
      </div>
    </main>
  </div>
</body>
</html>