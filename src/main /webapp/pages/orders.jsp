<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>MedIMS Orders</title>
  <link rel="stylesheet" href="../css/style.css" />
</head>
<body>

<div class="layout">
  <!-- Sidebar -->
  <aside class="sidebar">
    <h2>MedIMS Admin</h2>
    <a href="admin-dashboard.jsp">Dashboard</a>
    <a href="admin-inventory.jsp">Inventory</a>
    <a href="purchase-requests.jsp">Purchase Requests</a>
    <a href="orders.jsp">Orders</a>
    <a href="supplier-info.jsp">Supplier Info</a>
    <a href="../login.jsp">Logout</a>
  </aside>

  <!-- Main Content -->
  <main class="main">
    <div class="topbar">
      <h2>Orders</h2>
    </div>

    <div class="card" style="margin-top: 20px;">
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>Order ID</th>
              <th>Item</th>
              <th>Supplier</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>

          <tbody>

            <%-- Future dynamic orders from Servlet will go here --%>

            <tr>
              <td>#ORD-001</td>
              <td>Surgical Gloves</td>
              <td>MedSupply Co.</td>
              <td><span class="badge badge-process">In Process</span></td>
              <td>
                <button class="primary-btn" onclick="approveOrder(this)">Approve</button>
                <button class="secondary-btn" onclick="toggleStatus(this)">Mark Done</button>
              </td>
            </tr>

            <tr>
              <td>#ORD-002</td>
              <td>IV Fluids</td>
              <td>HealthCorp Ltd.</td>
              <td><span class="badge badge-done">Done</span></td>
              <td>
                <button class="secondary-btn" onclick="toggleStatus(this)">Set In Process</button>
              </td>
            </tr>

            <tr>
              <td>#ORD-003</td>
              <td>Syringes</td>
              <td>CarePlus Inc.</td>
              <td><span class="badge badge-process">In Process</span></td>
              <td>
                <button class="primary-btn" onclick="approveOrder(this)">Approve</button>
                <button class="secondary-btn" onclick="toggleStatus(this)">Mark Done</button>
              </td>
            </tr>

            <tr>
              <td>#ORD-004</td>
              <td>Face Masks</td>
              <td>SafeMed Supplies</td>
              <td><span class="badge badge-process">In Process</span></td>
              <td>
                <button class="primary-btn" onclick="approveOrder(this)">Approve</button>
                <button class="secondary-btn" onclick="toggleStatus(this)">Mark Done</button>
              </td>
            </tr>

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
  function approveOrder(button) {
    const row = button.closest("tr");
    const statusCell = row.cells[3];
    statusCell.innerHTML = '<span class="badge badge-process">In Process</span>';
    alert("Order Approved!");
  }

  function toggleStatus(button) {
    const row = button.closest("tr");
    const statusCell = row.cells[3];

    if (statusCell.innerText.includes("Done")) {
      statusCell.innerHTML = '<span class="badge badge-process">In Process</span>';
      button.innerText = "Mark Done";
    } else {
      statusCell.innerHTML = '<span class="badge badge-done">Done</span>';
      button.innerText = "Set In Process";
    }
  }
</script>

</body>
</html>