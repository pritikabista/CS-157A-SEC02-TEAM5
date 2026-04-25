<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicalims.model.Item" %>
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
      <a href="user-inventory.jsp"><button type="button" class="secondary">Back to Inventory</button></a>
    </div>

    <%
      String error = (String) request.getAttribute("error");
      String success = (String) request.getAttribute("success");
      String infoMessage = (String) request.getAttribute("message");

      String selectedItemReferenceNum = request.getParameter("itemReferenceNum") != null
              ? request.getParameter("itemReferenceNum")
              : "";

      String qtyValue = request.getParameter("quantity") != null
              ? request.getParameter("quantity")
              : "";

      String requestMessageValue = request.getParameter("message") != null
              ? request.getParameter("message")
              : "";

      List<Item> items = (List<Item>) request.getAttribute("items");
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

    <div class="form-card">
      <form id="requestForm" method="post" action="user-purchaseOrder">
        <div class="form-group">
          <label for="itemSearch">Search Item</label>
          <input
              type="text"
              id="itemSearch"
              placeholder="Search by item name or reference number"
              autocomplete="off"
              required
          />

          <input
              type="hidden"
              id="itemReferenceNum"
              name="itemReferenceNum"
              value="<%= selectedItemReferenceNum %>"
              required
          />

          <div id="itemDropdown" class="card" style="margin-top: 8px; max-height: 220px; overflow-y: auto; display: none; padding: 0;">
            <% if (items != null) {
                 for (Item item : items) { %>
                   <div
                     class="item-option"
                     data-ref="<%= item.getItemReferenceNumber() %>"
                     data-name="<%= item.getItemName() %>"
                     style="padding: 12px 16px; cursor: pointer; border-bottom: 1px solid #e5e7eb;"
                   >
                     <strong><%= item.getItemName() %></strong>
                     <span style="margin-left: 8px; color: #666;">(#<%= item.getItemReferenceNumber() %>)</span>
                   </div>
            <%   }
               } %>
          </div>
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
          <button type="submit">Submit Request</button>
        </div>
      </form>
    </div>
  </div>

  <script>
    const itemSearch = document.getElementById("itemSearch");
    const itemDropdown = document.getElementById("itemDropdown");
    const itemReferenceNum = document.getElementById("itemReferenceNum");
    const itemOptions = document.querySelectorAll(".item-option");
    const requestForm = document.getElementById("requestForm");

    itemSearch.addEventListener("focus", function () {
      itemDropdown.style.display = "block";
      filterItems();
    });

    itemSearch.addEventListener("input", function () {
      itemReferenceNum.value = "";
      itemDropdown.style.display = "block";
      filterItems();
    });

    document.addEventListener("click", function (event) {
      if (!itemSearch.contains(event.target) && !itemDropdown.contains(event.target)) {
        itemDropdown.style.display = "none";
      }
    });

    itemOptions.forEach(function (option) {
      option.addEventListener("click", function () {
        const ref = option.getAttribute("data-ref");
        const name = option.getAttribute("data-name");

        itemSearch.value = name + " (#" + ref + ")";
        itemReferenceNum.value = ref;
        itemDropdown.style.display = "none";
      });
    });

    requestForm.addEventListener("submit", function (event) {
      if (itemReferenceNum.value.trim() === "") {
        event.preventDefault();
        alert("Please select a valid item from the dropdown.");
      }
    });

    function filterItems() {
      const keyword = itemSearch.value.toLowerCase().trim();
      let hasVisibleItems = false;

      itemOptions.forEach(function (option) {
        const ref = option.getAttribute("data-ref").toLowerCase();
        const name = option.getAttribute("data-name").toLowerCase();
        const matches = name.includes(keyword) || ref.includes(keyword);

        option.style.display = matches ? "block" : "none";

        if (matches) {
          hasVisibleItems = true;
        }
      });

      itemDropdown.style.display = hasVisibleItems ? "block" : "none";
    }
  </script>

  <script src="../js/script.js"></script>
</body>
</html>