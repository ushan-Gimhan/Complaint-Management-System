<%--
  Created by IntelliJ IDEA.
  User: ushan
  Date: 15-Jun-25
  Time: 1:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            max-width: 400px;
            width: 100%;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            background: white;
            border: none;
        }

        .login-title {
            text-align: center;
            margin-bottom: 2rem;
            color: #007bff;
            font-weight: 600;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .btn-login {
            background: linear-gradient(45deg, #007bff, #0056b3);
            border: none;
            padding: 12px;
            font-weight: 500;
        }

        .btn-login:hover {
            background: linear-gradient(45deg, #0069d9, #004085);
            transform: translateY(-1px);
        }

        .btn-signup {
            background: linear-gradient(45deg, #28a745, #1e7e34);
            border: none;
            padding: 12px;
            font-weight: 500;
        }

        .btn-signup:hover {
            background: linear-gradient(45deg, #218838, #155724);
            transform: translateY(-1px);
        }

        .form-check-input:checked {
            background-color: #007bff;
            border-color: #007bff;
        }

        a {
            color: #007bff !important;
        }

        a:hover {
            color: #0056b3 !important;
        }
    </style>
</head>
<body>
<div class="login-card">
    <h3 class="login-title">Complaint Management System</h3>

    <form action="${pageContext.request.contextPath}/signIn" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">User Name</label>
            <input type="text" name="username" class="form-control" id="username" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" class="form-control" id="password" required>
        </div>

        <div class="row mb-3">
            <div class="col-6">
                <button type="submit" class="btn btn-primary btn-login w-100">Login</button>
            </div>
            <div class="col-6">
                <button type="button" class="btn btn-success btn-signup w-100"
                        onclick="window.location.href='<%= request.getContextPath() %>/View/Signup.jsp'">
                    Sign Up
                </button>
            </div>

        </div>
    </form>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%
    String loginMsg = (String) session.getAttribute("loginMessage");
    if (loginMsg != null) {
        session.removeAttribute("loginMessage"); // Clear after showing
%>
<script>
    <% if ("success".equals(loginMsg)) { %>
    Swal.fire({
        icon: 'success',
        title: 'Login Successful!',
        text: 'Redirecting to dashboard...',
        showConfirmButton: false,
        timer: 2000
    });
    <% } else if ("error".equals(loginMsg)) { %>
    Swal.fire({
        icon: 'error',
        title: 'Login Failed!',
        text: 'Invalid username or password.',
        showConfirmButton: true
    });
    <% } else if ("inactive".equals(loginMsg)) { %>
    Swal.fire({
        icon: 'warning',
        title: 'Account Inactive',
        text: 'Please contact administrator.',
        showConfirmButton: true
    });
    <% } %>
</script>
<%
    }
%>
</body>
</html>