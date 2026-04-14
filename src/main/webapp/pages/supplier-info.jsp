<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MedIMS Supplier Info</title>
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
        <h2>Supplier Information</h2>
      </div>

      <div class="card" style="max-width: 800px; margin-top: 20px;">
        <form action="../saveSupplier" method="post">
          <div class="form-grid">
            <div class="form-group">
              <label for="supplierName">Supplier Name</label>
              <input
                type="text"
                id="supplierName"
                name="supplierName"
                placeholder="Enter supplier name"
                required
              />
            </div>

            <div class="form-group">
              <label for="phone">Phone</label>
              <input
                type="tel"
                id="phone"
                name="phone"
                placeholder="Enter supplier phone number"
                required
              />
            </div>

            <div class="form-group full">
              <label for="url">Supplier URL</label>
              <input
                type="url"
                id="url"
                name="url"
                placeholder="Enter supplier website URL"
                required
              />
            </div>
          </div>

          <div class="form-actions">
            <button type="submit" class="primary-btn">Save</button>
            <button
              type="button"
              class="gray-btn"
              onclick="window.location.href='admin-dashboard.jsp'"
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

      <div class="card" style="margin-top: 20px;">
        <h3 style="margin-bottom: 16px; color: #156f74;">Saved Suppliers</h3>

        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Supplier Name</th>
                <th>Phone</th>
                <th>URL</th>
              </tr>
            </thead>
            <tbody id="supplierTableBody">
              <tr>
                <td>MedSupply Co.</td>
                <td>(408) 555-1200</td>
                <td><a href="https://www.medsupply.com" target="_blank" style="color:#167d7f;">www.medsupply.com</a></td>
              </tr>
              <tr>
                <td>HealthCore Ltd.</td>
                <td>(650) 555-8821</td>
                <td><a href="https://www.healthcore.com" target="_blank" style="color:#167d7f;">www.healthcore.com</a></td>
              </tr>
              <tr>
                <td>CarePlus Inc.</td>
                <td>(510) 555-4412</td>
                <td><a href="https://www.careplus.com" target="_blank" style="color:#167d7f;">www.careplus.com</a></td>
              </tr>

              <%-- Later, dynamic supplier rows from servlet/database can go here --%>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </div>
</body>
</html>