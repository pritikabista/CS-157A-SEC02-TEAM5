<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MedIMS Create Account</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
</head>
<body>
  <div class="auth-wrapper">
    <div class="auth-card">
      <h1>MedIMS</h1>
      <p>Create New Account</p>

      <form action="${pageContext.request.contextPath}/create-account" method="post">
        <div class="form-group">
          <label for="username">Username</label>
          <input
            type="text"
            id="username"
            name="username"
            placeholder="Enter username"
            required
          />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Enter password"
            required
          />
        </div>

        <div class="form-group">
          <label for="departmentId">Department ID</label>
          <input
            type="number"
            id="departmentId"
            name="departmentId"
            placeholder="Enter department ID"
            required
          />
        </div>

        <div class="form-group">
          <label for="phoneNumber">Phone Number</label>
          <input
            type="text"
            id="phoneNumber"
            name="phoneNumber"
            placeholder="Enter phone number"
            required
          />
        </div>

        <div class="form-actions">
          <button type="submit">Create Account</button>
          <button
            type="button"
            class="secondary"
            onclick="window.location.href='${pageContext.request.contextPath}/pages/login.jsp'"
          >
            Back to Login
          </button>
        </div>
      </form>

      <%
        String error = (String) request.getAttribute("error");
        String success = (String) request.getAttribute("success");
        if (error != null) {
      %>
        <p style="color: red; margin-top: 10px;"><%= error %></p>
      <%
        }
        if (success != null) {
      %>
        <p style="color: green; margin-top: 10px;"><%= success %></p>
      <%
        }
      %>
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>