<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MedIMS Add New Inventory Item</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>

<body>
  <div class="layout">
    <aside class="sidebar">
      <h2>MedIMS Admin</h2>
      <a href="<%= request.getContextPath() %>/admin-dashboard">Dashboard</a>
      <a href="<%= request.getContextPath() %>/inventory">Inventory</a>
      <a href="<%= request.getContextPath() %>/admin-purchaseOrder">Purchase Requests</a>
      <a href="<%= request.getContextPath() %>/orders">Orders</a>
      <a href="<%= request.getContextPath() %>/supplier-info">Supplier Info</a>
      <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </aside>

    <main class="main">
      <div class="topbar">
        <h2>Add New Inventory Item</h2>
      </div>

      <div class="card" style="max-width: 800px; margin-top: 20px;">
        <form id="addItemForm" action="<%= request.getContextPath() %>/add-item" method="post">
          <div class="form-grid">

            <div class="form-group">
              <label for="itemName">Item Name</label>
              <input
                type="text"
                id="itemName"
                name="itemName"
                placeholder="Enter item name"
                required
              />
            </div>

            <div class="form-group">
              <label for="referenceNumber">Reference Number</label>
              <input
                type="number"
                id="referenceNumber"
                name="referenceNumber"
                placeholder="Enter reference number"
                required
              />
            </div>

            <div class="form-group">
              <label for="lotNumber">Lot #</label>
              <input
                type="number"
                id="lotNumber"
                name="lotNumber"
                placeholder="Enter lot number"
                required
              />
            </div>

            <div class="form-group">
              <label for="expirationDate">Expiration Date</label>
              <input
                type="date"
                id="expirationDate"
                name="expirationDate"
                required
              />
            </div>

            <div class="form-group">
              <label for="quantity">Quantity</label>
              <input
                type="number"
                id="quantity"
                name="quantity"
                placeholder="Enter quantity"
                min="1"
                required
              />
            </div>

            <div class="form-group">
              <label for="category">Category</label>
              <select id="category" name="category" required>
                <option value="">Select category</option>
                <option value="1">PPE</option>
                <option value="2">Injection Supplies</option>
                <option value="3">Fluids</option>
                <option value="4">Medication</option>
                <option value="5">Sterile Supplies</option>
              </select>
            </div>

            <div class="form-group">
              <label for="supplierID">Supplier</label>
              <select id="supplierID" name="supplierID" required>
                <option value="">Select supplier</option>
                <option value="1">Supplier 1</option>
                <option value="2">Supplier 2</option>
              </select>
            </div>

            <div class="form-group full">
              <label for="location">Location</label>
              <select id="location" name="location" required>
                <option value="">Select location</option>
                <option value="1">B1-R101</option>
                <option value="2">B1-R102</option>
                <option value="3">B1-R103</option>
                <option value="4">B2-R201</option>
                <option value="5">B2-R202</option>
                <option value="6">B2-R203</option>
                <option value="7">B3-R301</option>
                <option value="8">B3-R302</option>
                <option value="9">B3-R303</option>
                <option value="10">B1-R100</option>
              </select>
            </div>

          </div>

          <div class="form-actions">
            <button type="submit" class="primary-btn">Done</button>

            <button
              type="button"
              class="gray-btn"
              onclick="window.location.href='<%= request.getContextPath() %>/inventory'"
            >
              Cancel
            </button>
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