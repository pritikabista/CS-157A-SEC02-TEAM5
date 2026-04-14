<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MedIMS Request Detail</title>
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
        <h2>Request Detail</h2>
      </div>

      <div class="card" style="max-width: 900px; margin-top: 20px;">
        <div class="expanded-box">
          <div class="expanded-grid">
            <p><strong>Request ID:</strong> REQ-101</p>
            <p><strong>User:</strong> John Doe</p>
            <p><strong>Department:</strong> ER</p>
            <p><strong>Role:</strong> Employee</p>

            <p><strong>Item Ref #:</strong> MED-1001</p>
            <p><strong>Item Name:</strong> Surgical Gloves</p>
            <p><strong>Lot Number:</strong> LOT-A123</p>
            <p><strong>Category:</strong> PPE</p>

            <p><strong>Expiration Date:</strong> 2026-05-10</p>
            <p><strong>Location:</strong> Storage Room A</p>
            <p><strong>Current Quantity:</strong> 8</p>
            <p><strong>Status:</strong> <span class="badge badge-low">Low Stock</span></p>
          </div>

          <div style="margin-top: 20px;">
            <h3 style="margin-bottom: 10px; color: #156f74;">Request Message</h3>
            <div class="card" style="background: #f9fcff; box-shadow: none; padding: 16px;">
              We are running low on surgical gloves in the ER. Please approve a purchase request as soon as possible to avoid shortage during patient care.
            </div>
          </div>

          <div class="form-actions" style="margin-top: 24px;">
            <button class="primary-btn" onclick="makePurchase()">Make Purchase</button>
            <button class="gray-btn" onclick="window.location.href='purchase-requests.jsp'">Back</button>
          </div>

          <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
          %>
            <p style="color: green; margin-top: 15px;"><%= message %></p>
          <%
            }
          %>
        </div>
      </div>
    </main>
  </div>

  <script>
    function makePurchase() {
      alert("Purchase request approved. Order created successfully.");
      window.location.href = "orders.jsp";
    }
  </script>
</body>
</html>