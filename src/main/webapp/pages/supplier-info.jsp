<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.medicalims.model.Supplier" %>

<%
    Boolean approvedModeObj = (Boolean) request.getAttribute("approvedMode");
    boolean approvedMode = approvedModeObj != null && approvedModeObj;

    Supplier filteredSupplier = (Supplier) request.getAttribute("supplier");
    List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MedIMS Supplier Info</title>

  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>

<body>
  <div class="layout">

    <aside class="sidebar">
      <h2>MedIMS Admin</h2>

      <a href="<%= request.getContextPath() %>/admin-dashboard">Dashboard</a>
      <a href="<%= request.getContextPath() %>/pages/admin-inventory.jsp">Inventory</a>
      <a href="<%= request.getContextPath() %>/admin-purchaseOrder">Purchase Requests</a>
      <a href="<%= request.getContextPath() %>/orders">Orders</a>
      <a href="<%= request.getContextPath() %>/supplier-info">Supplier Info</a>
      <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </aside>

    <main class="main">

      <div class="topbar">
        <h2>Supplier Information</h2>
      </div>

      <% if (approvedMode) { %>

        <div class="card" style="margin-top: 20px;">

          <h3 style="margin-bottom: 16px; color: #156f74;">
            Recommended Supplier For Approved Request
          </h3>

          <div class="table-wrap">
            <table>

              <thead>
                <tr>
                  <th>Supplier Name</th>
                  <th>Website</th>
                </tr>
              </thead>

              <tbody>

                <% if (filteredSupplier != null) { %>

                  <tr>
                    <td><%= filteredSupplier.getSupplierID() %></td>

                    <td>
                      <a
                        href="<%= filteredSupplier.getUrl() %>"
                        target="_blank"
                        style="color:#167d7f;"
                      >
                        <%= filteredSupplier.getUrl() %>
                      </a>
                    </td>
                  </tr>

                <% } else { %>

                  <tr>
                    <td colspan="2">
                      No supplier found for this order.
                    </td>
                  </tr>

                <% } %>

              </tbody>

            </table>
          </div>

          <div class="action-row mt-16">

            <form action="<%= request.getContextPath() %>/supplier-info" method="get">
                <button type="submit" class="gray-btn">
                    View All Suppliers
                </button>
            </form>

            <form action="<%= request.getContextPath() %>/admin-purchaseOrder" method="get">
                <button type="submit" class="primary-btn">
                    Complete
                </button>
            </form>

          </div>

        </div>

      <% } else { %>

        <div class="card" style="margin-top: 20px;">

          <h3 style="margin-bottom: 16px; color: #156f74;">
            All Suppliers
          </h3>

          <div class="table-wrap">

            <table>

              <thead>
                <tr>
                  <th>Supplier Name</th>
                  <th>Phone</th>
                  <th>Website</th>
                </tr>
              </thead>

              <tbody>

                <% if (suppliers != null && !suppliers.isEmpty()) { %>

                  <% for (Supplier supplier : suppliers) { %>

                    <tr>

                      <td>
                        <%= supplier.getSupplierID() %>
                      </td>

                      <td>
                        <%= supplier.getPhNum() %>
                      </td>

                      <td>
                        <a
                          href="<%= supplier.getUrl() %>"
                          target="_blank"
                          style="color:#167d7f;"
                        >
                          <%= supplier.getUrl() %>
                        </a>
                      </td>

                    </tr>

                  <% } %>

                <% } else { %>

                  <tr>
                    <td colspan="3">
                      No suppliers available.
                    </td>
                  </tr>

                <% } %>

              </tbody>

            </table>

          </div>

        </div>

      <% } %>

    </main>

  </div>
</body>
</html>