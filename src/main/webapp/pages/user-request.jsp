<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>User Request</title>
  <link rel="stylesheet" href="../css/style.css" />
</head>
<body>
  <div class="page main">
    <div class="topbar">
      <div>
        <h2>Submit Request</h2>
        <p>Request purchase or reorder for a selected item.</p>
      </div>
      <a href="user-inventory.jsp"><button class="secondary">Back to Inventory</button></a>
    </div>

    <%
      String error = (String) request.getAttribute("error");
      String success = (String) request.getAttribute("success");
      String message = (String) request.getAttribute("message");
      String itemName = request.getParameter("itemName") != null ? request.getParameter("itemName") : "";
      String referenceNumber = request.getParameter("referenceNumber") != null ? request.getParameter("referenceNumber") : "";
    %>
    <% if (error != null) { %><div class="card" style="margin-top: 16px; color: #b00020;"><%= error %></div><% } %>
    <% if (success != null) { %><div class="card" style="margin-top: 16px; color: #0b7a24;"><%= success %></div><% } %>
    <% if (message != null) { %><div class="card" style="margin-top: 16px;"><%= message %></div><% } %>

    <div class="form-card">
      <form id="requestForm" method="post" action="user-request">
        <div class="form-group">
          <label for="requestItem">Item</label>
          <input type="text" id="requestItem" name="itemName" value="<%= itemName %>" required />
        </div>

        <div class="form-group">
          <label for="referenceNumber">Reference Number</label>
          <input type="text" id="referenceNumber" name="referenceNumber" value="<%= referenceNumber %>" required />
        </div>

        <div class="form-group">
          <label for="quantity">Quantity</label>
          <input type="number" id="quantity" name="quantity" min="1" required />
        </div>

        <div class="form-group">
          <label for="requestMessage">Message</label>
          <textarea id="requestMessage" name="message" placeholder="Write your request here..." required></textarea>
        </div>

        <div class="form-actions">
          <button type="submit">Submit Request</button>
        </div>
      </form>
    </div>
  </div>

  <script src="../js/script.js"></script>
</body>
</html>
