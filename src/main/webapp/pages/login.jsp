<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>MedIMS Login</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
</head>

<body>
  <div class="auth-wrapper">
    <div class="auth-card">

      <!-- Logo + Title -->
      <div class="login-header">
        <div class="brand-row">
          <h1>MedIMS</h1>
          <img src="${pageContext.request.contextPath}/images/logo.png" alt="MedIMS Logo" class="logo">
          
        </div>

        <p class="tagline">Medical Inventory Management System</p>
      </div>

      <form action="${pageContext.request.contextPath}/login" method="post">
        
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

        <div class="form-actions">
          <button type="submit">Login</button>
          <button
            type="button"
            class="secondary"
            onclick="window.location.href='${pageContext.request.contextPath}/create-account'"
          >
            Create Account
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