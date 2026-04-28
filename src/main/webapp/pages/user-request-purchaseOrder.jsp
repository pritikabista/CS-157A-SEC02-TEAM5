<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicalims.model.InventoryItem" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>MedIMS Purchase Request</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>

<body>
<div class="page main">

  <div class="topbar">
    <div>
      <h2>Purchase Request</h2>
      <p>Request purchase or reorder for a selected item.</p>
    </div>

    <div style="display: flex; gap: 10px;">
      <a href="<%= request.getContextPath() %>/user-dashboard" class="secondary-btn">Dashboard</a>
      <a href="<%= request.getContextPath() %>/inventory" class="secondary-btn">Back to Inventory</a>
      <a href="<%= request.getContextPath() %>/logout" class="secondary-btn">Logout</a>
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
    <div class="card" style="color: red;"><%= error %></div>
  <% } %>

  <% if (success != null) { %>
    <div class="card" style="color: green;"><%= success %></div>
  <% } %>

  <% if (infoMessage != null) { %>
    <div class="card"><%= infoMessage %></div>
  <% } %>

  <!-- SEARCH -->
  <form action="<%= request.getContextPath() %>/user-purchaseOrder" method="get">
    <input type="text" name="search" value="<%= search %>" placeholder="Search item..." />
    <button type="submit">Search</button>
    <a href="<%= request.getContextPath() %>/user-purchaseOrder">Reset</a>
  </form>

  <!-- RESULTS TABLE -->
  <% if (hasSearched) { %>
    <p>Select an item below:</p>

    <table border="1">
      <tr>
        <th>Ref #</th>
        <th>Name</th>
        <th>Category</th>
        <th>Lot</th>
        <th>Expiry</th>
        <th>Qty</th>
        <th>Location</th>
      </tr>

      <% if (items != null && !items.isEmpty()) { %>
        <% for (InventoryItem item : items) { %>
          <tr onclick="selectItem('<%= item.getItemReferenceNumber() %>')" style="cursor:pointer;">
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
        <tr><td colspan="7">No items found</td></tr>
      <% } %>
    </table>
  <% } %>

  <!-- REQUEST FORM -->
  <form method="post" action="<%= request.getContextPath() %>/user-purchaseOrder">
    <p>Selected Item:</p>
    <input type="number" id="itemReferenceNum" name="itemReferenceNum" value="<%= selectedItemReferenceNum %>" readonly required>

    <p>Quantity:</p>
    <input type="number" name="quantity" min="1" value="<%= qtyValue %>" required>

    <p>Message:</p>
    <textarea name="message" required><%= requestMessageValue %></textarea>

    <br><br>
    <button type="submit">Submit Request</button>
  </form>

</div>

<script>
  function selectItem(ref) {
    document.getElementById("itemReferenceNum").value = ref;
  }
</script>

</body>
</html>