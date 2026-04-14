<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>MedIMS Purchase Requests</title>
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
      <h2>Purchase Requests</h2>
    </div>

    <div class="card" style="margin-top: 20px;">
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>Request ID</th>
              <th>User</th>
              <th>Item</th>
              <th>Message</th>
              <th>Action</th>
            </tr>
          </thead>

          <tbody>

            <%-- Future dynamic data will come from Servlet here --%>

            <tr class="clickable-row" onclick="toggleExpand('req1')">
              <td>#REQ-101</td>
              <td>John Doe (ER)</td>
              <td>Surgical Gloves</td>
              <td>Low stock in ER</td>
              <td><button class="secondary-btn">View</button></td>
            </tr>

            <tr id="req1" style="display:none;">
              <td colspan="5">
                <div class="expanded-box">
                  <p><strong>Request ID:</strong> REQ-101</p>
                  <p><strong>User:</strong> John Doe</p>
                  <p><strong>Department:</strong> ER</p>
                  <p><strong>Item:</strong> Surgical Gloves</p>
                  <p><strong>Message:</strong> We are running low on gloves.</p>

                  <div class="expanded-actions">
                    <button class="primary-btn" onclick="makePurchase(event)">
                      Make Purchase
                    </button>
                    <button class="gray-btn" onclick="closeRow(event, 'req1')">
                      Close
                    </button>
                  </div>
                </div>
              </td>
            </tr>

            <tr class="clickable-row" onclick="toggleExpand('req2')">
              <td>#REQ-102</td>
              <td>Alice Smith (ICU)</td>
              <td>IV Fluids</td>
              <td>Need more stock</td>
              <td><button class="secondary-btn">View</button></td>
            </tr>

            <tr id="req2" style="display:none;">
              <td colspan="5">
                <div class="expanded-box">
                  <p><strong>Request ID:</strong> REQ-102</p>
                  <p><strong>User:</strong> Alice Smith</p>
                  <p><strong>Department:</strong> ICU</p>
                  <p><strong>Item:</strong> IV Fluids</p>
                  <p><strong>Message:</strong> Stock is getting low.</p>

                  <div class="expanded-actions">
                    <button class="primary-btn" onclick="makePurchase(event)">
                      Make Purchase
                    </button>
                    <button class="gray-btn" onclick="closeRow(event, 'req2')">
                      Close
                    </button>
                  </div>
                </div>
              </td>
            </tr>

            <tr class="clickable-row" onclick="toggleExpand('req3')">
              <td>#REQ-103</td>
              <td>David Lee (Pharmacy)</td>
              <td>Insulin Vials</td>
              <td>Expiring soon</td>
              <td><button class="secondary-btn">View</button></td>
            </tr>

            <tr id="req3" style="display:none;">
              <td colspan="5">
                <div class="expanded-box">
                  <p><strong>Request ID:</strong> REQ-103</p>
                  <p><strong>User:</strong> David Lee</p>
                  <p><strong>Department:</strong> Pharmacy</p>
                  <p><strong>Item:</strong> Insulin Vials</p>
                  <p><strong>Message:</strong> Need new stock soon.</p>

                  <div class="expanded-actions">
                    <button class="primary-btn" onclick="makePurchase(event)">
                      Make Purchase
                    </button>
                    <button class="gray-btn" onclick="closeRow(event, 'req3')">
                      Close
                    </button>
                  </div>
                </div>
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
  function toggleExpand(id) {
    const row = document.getElementById(id);
    row.style.display = row.style.display === "table-row" ? "none" : "table-row";
  }

  function closeRow(event, id) {
    event.stopPropagation();
    document.getElementById(id).style.display = "none";
  }

  function makePurchase(event) {
    event.stopPropagation();
    alert("Purchase request approved!");
    window.location.href = "orders.jsp";
  }
</script>

</body>
</html>