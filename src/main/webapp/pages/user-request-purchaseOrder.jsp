<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicalims.model.InventoryItem" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>MedIMS Purchase Request</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />

  <style>
    .request-page {
      padding: 28px;
      max-width: 1400px;
      margin: 0 auto;
    }

    .request-page .topbar {
      margin-bottom: 26px;
    }

    .request-page .topbar h1 {
      font-size: 36px;
      font-weight: 800;
      margin-bottom: 6px;
    }

    .request-page .topbar p {
      color: #6b7280;
      font-size: 16px;
    }

    .request-page .action-row {
      display: flex;
      gap: 12px;
      align-items: center;
      flex-wrap: wrap;
    }

    .request-page a.secondary-btn,
    .request-page a.gray-btn {
      display: inline-flex !important;
      align-items: center !important;
      justify-content: center !important;
      min-height: 44px !important;
      padding: 0 18px !important;
      border-radius: 10px !important;
      font-weight: 700 !important;
      text-decoration: none !important;
      line-height: 1 !important;
    }

    .request-page a.secondary-btn {
      background: #e7f3f2 !important;
      color: #0f766e !important;
    }

    .request-page a.gray-btn {
      background: #e5e7eb !important;
      color: #374151 !important;
    }

    .request-page .request-card {
      background: white;
      border-radius: 22px;
      padding: 24px 28px;
      box-shadow: 0 8px 24px rgba(15, 23, 42, 0.06);
      margin-top: 18px;
    }

    .request-page .search-form {
      display: grid;
      grid-template-columns: 1fr 140px 120px;
      gap: 12px;
      align-items: center;
    }

    .request-page .search-form input,
    .request-page .search-form button,
    .request-page .search-form a {
      height: 48px;
    }

    .request-page .search-form a {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      border-radius: 10px;
      background: #e5e7eb;
      color: #374151;
      font-weight: 700;
      text-decoration: none;
    }

    .request-page .section-title {
      font-size: 22px;
      font-weight: 800;
      margin-bottom: 6px;
      color: #1f2937;
    }

    .request-page .section-subtitle {
      color: #6b7280;
      margin-bottom: 18px;
    }

    .request-page .table-wrap {
      border: 1px solid #edf2f7;
      box-shadow: none;
      margin-top: 14px;
    }

    .request-page table {
      width: 100%;
      border-collapse: collapse;
      border: none;
    }

    .request-page th {
      background: #f8fbfc;
      color: #475569;
      font-size: 13px;
      text-transform: uppercase;
      letter-spacing: 0.04em;
      padding: 14px 16px;
      border-bottom: 1px solid #edf2f7;
      text-align: left;
    }

    .request-page td {
      padding: 14px 16px;
      border-bottom: 1px solid #edf2f7;
      text-align: left;
    }

    .request-page tbody tr:hover {
      background: #f8fbfd;
      cursor: pointer;
    }

    .request-page .request-form {
      display: grid;
      gap: 16px;
    }

    .request-page .form-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 16px;
    }

    .request-page .form-group {
      margin-bottom: 0;
    }

    .request-page .form-group.full {
      grid-column: 1 / -1;
    }

    .request-page label {
      display: block;
      margin-bottom: 8px;
      font-weight: 700;
      color: #1f2937;
    }

    .request-page textarea {
      min-height: 140px;
    }

    .request-page .submit-row {
      display: flex;
      justify-content: flex-start;
      margin-top: 4px;
    }

    .request-page .message-card {
      margin-top: 16px;
      border-radius: 14px;
      padding: 14px 16px;
      background: white;
      box-shadow: 0 8px 24px rgba(15, 23, 42, 0.06);
      font-weight: 700;
    }

    .request-page .error-message {
      color: #b00020;
    }

    .request-page .success-message {
      color: #0b7a24;
    }

    @media (max-width: 800px) {
      .request-page .search-form,
      .request-page .form-grid {
        grid-template-columns: 1fr;
      }

      .request-page .action-row {
        width: 100%;
      }

      .request-page .action-row a {
        flex: 1;
      }
    }
  </style>
</head>

<body>
<div class="page main request-page">

  <div class="topbar">
    <div>
      <h1>Purchase Request</h1>
      <p>Request purchase or reorder for a selected inventory item.</p>
    </div>

    <div class="action-row">
      <a href="<%= request.getContextPath() %>/user-dashboard" class="secondary-btn">Dashboard</a>
      <a href="<%= request.getContextPath() %>/inventory" class="secondary-btn">Back to Inventory</a>
      <a href="<%= request.getContextPath() %>/logout" class="gray-btn">Logout</a>
    </div>
  </div>

  <%
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    String infoMessage = (String) request.getAttribute("message");

    String search = (String) request.getAttribute("search");
    if (search == null) search = "";

    String selectedItemReferenceNum = request.getParameter("itemReferenceNum") != null
        ? request.getParameter("itemReferenceNum") : "";

    String qtyValue = request.getParameter("quantity") != null
        ? request.getParameter("quantity") : "";

    String requestMessageValue = request.getParameter("message") != null
        ? request.getParameter("message") : "";

    List<InventoryItem> items = (List<InventoryItem>) request.getAttribute("items");

    boolean hasSearched = search != null && !search.trim().isEmpty();
  %>

  <% if (error != null) { %>
    <div class="message-card error-message"><%= error %></div>
  <% } %>

  <% if (success != null) { %>
    <div class="message-card success-message"><%= success %></div>
  <% } %>

  <% if (infoMessage != null) { %>
    <div class="message-card"><%= infoMessage %></div>
  <% } %>

  <div class="request-card">
    <h2 class="section-title">Find Item</h2>
    <p class="section-subtitle">Search for the inventory item you want to request.</p>

    <form action="<%= request.getContextPath() %>/user-purchaseOrder" method="get" class="search-form">
      <input type="text" name="search" value="<%= search %>" placeholder="Search item..." />
      <button type="submit" class="primary-btn">Search</button>
      <a href="<%= request.getContextPath() %>/user-purchaseOrder">Reset</a>
    </form>
  </div>

  <% if (hasSearched) { %>
    <div class="request-card">
      <h2 class="section-title">Search Results</h2>
      <p class="section-subtitle">Click an item below to select it for your request.</p>

      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>Ref #</th>
              <th>Name</th>
              <th>Category</th>
              <th>Lot</th>
              <th>Expiry</th>
              <th>Qty</th>
              <th>Location</th>
            </tr>
          </thead>

          <tbody>
            <% if (items != null && !items.isEmpty()) { %>
              <% for (InventoryItem item : items) { %>
                <tr onclick="selectItem('<%= item.getItemReferenceNumber() %>')">
                  <td><%= item.getItemReferenceNumber() %></td>
                  <td><%= item.getItemName() %></td>
                  <td><%= item.getCategoryName() %></td>
                  <td><%= item.getLotNumber() %></td>
                  <td><%= item.getExpirationDate() %></td>
                  <td><%= item.getStock() %></td>
                  <td><%= item.getLocation() %></td>
                </tr>
              <% } %>
            <% } else { %>
              <tr>
                <td colspan="7">No items found.</td>
              </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>
  <% } %>

  <div class="request-card">
    <h2 class="section-title">Request Details</h2>
    <p class="section-subtitle">Enter the quantity and message for your purchase request.</p>

    <form method="post" action="<%= request.getContextPath() %>/user-purchaseOrder" class="request-form">
      <div class="form-grid">
        <div class="form-group">
          <label for="itemReferenceNum">Selected Item</label>
          <input type="number" id="itemReferenceNum" name="itemReferenceNum"
                 value="<%= selectedItemReferenceNum %>" readonly required>
        </div>

        <div class="form-group">
          <label for="quantity">Quantity</label>
          <input type="number" id="quantity" name="quantity" min="1"
                 value="<%= qtyValue %>" required>
        </div>

        <div class="form-group full">
          <label for="message">Message</label>
          <textarea id="message" name="message" placeholder="Write your request message..." required><%= requestMessageValue %></textarea>
        </div>
      </div>

      <div class="submit-row">
        <button type="submit" class="primary-btn">Submit Request</button>
      </div>
    </form>
  </div>

</div>

<script>
  function selectItem(ref) {
    document.getElementById("itemReferenceNum").value = ref;
  }
</script>

</body>
</html>