<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicalims.model.InventoryItem" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>User Request</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />

  <style>
    .search-box {
      margin-top: 20px;
      margin-bottom: 20px;
    }

    .search-box input[type="text"] {
      width: 320px;
      padding: 8px;
      font-size: 14px;
    }

    .search-box button {
      padding: 8px 12px;
      font-size: 14px;
      cursor: pointer;
    }

    .search-box a {
      margin-left: 10px;
      text-decoration: none;
      color: #007bff;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: white;
      margin-bottom: 20px;
    }

    th, td {
      border: 1px solid #ddd;
      padding: 10px;
      text-align: left;
    }

    th {
      background-color: #343a40;
      color: white;
    }

    tr:nth-child(even) {
      background-color: #f2f2f2;
    }

    .clickable-row {
      cursor: pointer;
    }

    .clickable-row:hover {
      background-color: #eef3f7 !important;
    }

    .no-data {
      text-align: center;
      padding: 20px;
    }
  </style>
</head>
<body>
  <div class="page main">
    <div class="topbar">
      <div>
        <h2>Submit Request</h2>
        <p>Request purchase or reorder for a selected item.</p>
      </div>
      <a href="<%= request.getContextPath() %>/inventory" class="secondary-btn">Back to Inventory</a>
    </div>

    <%
      String error = (String) request.getAttribute("error");
      String success = (String) request.getAttribute("success");
      String infoMessage = (String) request.getAttribute("message");

      String search = (String) request.getAttribute("search");
      if (search == null) {
          search = "";
      }

      String selectedItemReferenceNum = request.getParameter("itemReferenceNum") != null
              ? request.getParameter("itemReferenceNum")
              : "";

      String qtyValue = request.getParameter("quantity") != null
              ? request.getParameter("quantity")
              : "";

      String requestMessageValue = request.getParameter("message") != null
              ? request.getParameter("message")
              : "";

      List<InventoryItem> items = (List<InventoryItem>) request.getAttribute("items");

      boolean hasSearched = search != null && !search.trim().isEmpty();
    %>

    <% if (error != null) { %>
      <div class="card" style="margin-top: 16px; color: #b00020;"><%= error %></div>
    <% } %>

    <% if (success != null) { %>
      <div class="card" style="margin-top: 16px; color: #0b7a24;"><%= success %></div>
    <% } %>

    <% if (infoMessage != null) { %>
      <div class="card" style="margin-top: 16px;"><%= infoMessage %></div>
    <% } %>

    <div class="search-box">
      <form action="<%= request.getContextPath() %>/user-purchaseOrder" method="get">
        <input
            type="text"
            name="search"
            placeholder="Search by item name, item ref #, or category name"
            value="<%= search %>">

        <button type="submit">Search</button>
        <a href="<%= request.getContextPath() %>/user-purchaseOrder">Reset</a>
      </form>
    </div>

    <% if (hasSearched) { %>
      <div style="margin-bottom: 10px; font-weight: bold; color: #555;">
        Click on an item from the table below to select it.
       </div>
      <table>
        <thead>
          <tr>
            <th>Item Ref #</th>
            <th>Item Name</th>
            <th>Category</th>
            <th>Lot #</th>
            <th>Expiration Date</th>
            <th>Quantity</th>
            <th>Location</th>
          </tr>
        </thead>
        <tbody>
          <% if (items != null && !items.isEmpty()) { %>
            <% for (InventoryItem item : items) { %>
              <tr class="clickable-row"
                  onclick="selectItem('<%= item.getItemReferenceNumber() %>')">
                <td><%= item.getItemReferenceNumber() %></td>
                <td><%= item.getItemName() %></td>
                <td><%= item.getCategoryName() %></td>
                <td><%= item.getLotNumber() %></td>
                <td><%= item.getExpirationDate() != null ? item.getExpirationDate() : "" %></td>
                <td><%= item.getStock() %></td>
                <td><%= item.getLocation() %></td>
              </tr>
            <% } %>
          <% } else { %>
            <tr>
              <td colspan="7" class="no-data">No matching items found.</td>
            </tr>
          <% } %>
        </tbody>
      </table>
    <% } %>

    <div class="form-card">
      <form id="requestForm" method="post" action="<%= request.getContextPath() %>/user-purchaseOrder">
        <div class="form-group">
          <label for="itemReferenceNum">Selected Item Reference Number</label>
          <div style="font-size: 13px; color: #777; margin-bottom: 6px;">
          Please select an item from the table above.
          </div>
          <input
              type="number"
              id="itemReferenceNum"
              name="itemReferenceNum"
              value="<%= selectedItemReferenceNum %>"
              readonly
              required
          />
        </div>

        <div class="form-group">
          <label for="quantity">Quantity</label>
          <input
              type="number"
              id="quantity"
              name="quantity"
              min="1"
              value="<%= qtyValue %>"
              required
          />
        </div>

        <div class="form-group">
          <label for="requestMessage">Message</label>
          <textarea
              id="requestMessage"
              name="message"
              placeholder="Write your request here..."
              required
          ><%= requestMessageValue %></textarea>
        </div>

        <div class="form-actions">
          <button type="submit" class="primary-btn">Submit Request</button>
        </div>
      </form>
    </div>
  </div>

  <script>
    function selectItem(itemReferenceNumber) {
      const input = document.getElementById("itemReferenceNum");
      input.value = itemReferenceNumber;
      input.style.border = "2px solid #0f766e";
    }
  </script>

  <script src="<%= request.getContextPath() %>/js/script.js"></script>
</body>
</html>