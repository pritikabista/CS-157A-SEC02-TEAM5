<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MedIMS Inventory</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
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
        <h2>Inventory</h2>
        <button class="primary-btn" onclick="window.location.href='add-item.jsp'">
          Add New Item
        </button>
      </div>

      <div class="card" style="margin-top: 20px;">
        <div class="toolbar">
          <input type="text" id="searchInput" placeholder="Search item..." />
          
          <select id="categoryFilter">
            <option value="">All Categories</option>
            <option value="PPE">PPE</option>
            <option value="Injection Supplies">Injection Supplies</option>
            <option value="Fluids">Fluids</option>
            <option value="Medication">Medication</option>
            <option value="Sterile Supplies">Sterile Supplies</option>
          </select>

          <select id="sortSelect">
            <option value="">Sort By</option>
            <option value="name">Alphabetical</option>
            <option value="expiry">Expiry</option>
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

            <tbody id="inventoryTableBody">

              <%-- Future dynamic data will come here from Servlet --%>

              <tr class="clickable-row low-stock-row" onclick="toggleExpand('item1')">
                <td>MED-1001</td>
                <td>Surgical Gloves</td>
                <td>LOT-A123</td>
                <td>2026-05-10</td>
                <td>Storage Room A</td>
                <td>8</td>
              </tr>

              <tr id="item1" style="display: none;">
                <td colspan="6">
                  <div class="expanded-box">
                    <div class="expanded-grid">
                      <p><strong>Reference Number:</strong> MED-1001</p>
                      <p><strong>Category:</strong> PPE</p>
                      <p><strong>Lot Number:</strong> LOT-A123</p>
                      <p><strong>Expiration Date:</strong> 2026-05-10</p>
                      <p><strong>Location:</strong> Storage Room A</p>
                      <p><strong>Status:</strong> <span class="badge badge-low">Low Stock</span></p>
                      <p><strong>Details:</strong> Latex-free sterile gloves</p>
                    </div>

                    <div class="qty-box">
                      <button class="qty-btn" onclick="changeQty(event, 'qty1', -1)">-</button>
                      <span class="qty-value" id="qty1">1</span>
                      <button class="qty-btn" onclick="changeQty(event, 'qty1', 1)">+</button>
                    </div>

                    <div class="expanded-actions">
                      <button class="primary-btn" onclick="event.stopPropagation(); window.location.href='update-inventory.jsp'">Update</button>
                      <button class="secondary-btn" onclick="event.stopPropagation(); window.location.href='purchase-requests.jsp'">Request</button>
                    </div>
                  </div>
                </td>
              </tr>

              <%-- You can keep rest same OR later replace with dynamic loop --%>

            </tbody>
          </table>
        </div>
      </div>

      <%-- Optional backend message --%>
      <%
        String msg = (String) request.getAttribute("message");
        if (msg != null) {
      %>
        <p style="color: green; margin-top: 15px;"><%= msg %></p>
      <%
        }
      %>

    </main>
  </div>

  <script>
    function toggleExpand(id) {
      const row = document.getElementById(id);
      row.style.display = (row.style.display === "none" || row.style.display === "") ? "table-row" : "none";
    }

    function changeQty(event, id, change) {
      event.stopPropagation();
      const qtyElement = document.getElementById(id);
      let current = parseInt(qtyElement.textContent);
      current += change;
      if (current < 1) current = 1;
      qtyElement.textContent = current;
    }
  </script>
</body>
</html>